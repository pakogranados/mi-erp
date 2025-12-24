"""
Sistema de Órdenes de Compra Automáticas
Genera órdenes basadas en:
1. Stock bajo mínimo
2. Proyección de producción
3. Solicitudes especiales
4. Punto de reorden
"""

from decimal import Decimal
from datetime import datetime, timedelta
import mysql.connector

def conexion_db():
    """Conexión a la base de datos"""
    return mysql.connector.connect(
        host='localhost',  # Cambiar según entorno
        user='root',
        password='',
        database='miapp',
        charset='utf8mb4',
        collation='utf8mb4_unicode_ci'
    )

def generar_folio_oc_auto(empresa_id):
    """Genera folio único: OCA-EMP-YYYYMMDD-###"""
    db = conexion_db()
    cursor = db.cursor()
    
    hoy = datetime.now().strftime('%Y%m%d')
    prefijo = f'OCA-{empresa_id}-{hoy}'
    
    cursor.execute("""
        SELECT COUNT(*) as total
        FROM ordenes_compra_automaticas
        WHERE folio LIKE %s
    """, (f'{prefijo}%',))
    
    count = cursor.fetchone()[0]
    numero = count + 1
    folio = f'{prefijo}-{numero:03d}'
    
    cursor.close()
    db.close()
    
    return folio

def calcular_necesidades_compra(empresa_id):
    """
    Calcula qué mercancías necesitan comprarse
    Retorna lista de diccionarios con: mercancia_id, cantidad_sugerida, criterio, etc.
    """
    db = conexion_db()
    cursor = db.cursor(dictionary=True)
    
    necesidades = []
    
    # ===== CRITERIO 1: Stock bajo mínimo =====
    cursor.execute("""
        SELECT 
            m.id as mercancia_id,
            m.nombre,
            m.producto_base_id,
            m.minimo_existencia,
            m.maximo_existencia,
            COALESCE(i.disponible_base, 0) as stock_actual,
            (m.maximo_existencia - COALESCE(i.disponible_base, 0)) as cantidad_sugerida
        FROM mercancia m
        LEFT JOIN inventario i ON i.mercancia_id = m.id AND i.empresa_id = %s
        WHERE m.empresa_id = %s
          AND m.activo = 1
          AND m.minimo_existencia > 0
          AND COALESCE(i.disponible_base, 0) < m.minimo_existencia
    """, (empresa_id, empresa_id))
    
    for row in cursor.fetchall():
        necesidades.append({
            'mercancia_id': row['mercancia_id'],
            'producto_base_id': row['producto_base_id'],
            'descripcion': row['nombre'],
            'cantidad_sugerida': max(row['cantidad_sugerida'], 0),
            'stock_actual': row['stock_actual'],
            'stock_minimo': row['minimo_existencia'],
            'stock_maximo': row['maximo_existencia'],
            'criterio': 'bajo_minimo',
            'prioridad': 1  # Alta prioridad
        })
    
    # ===== CRITERIO 2: Proyección de producción =====
    # TODO: Implementar análisis de órdenes de producción futuras
    # Por ahora dejamos vacío, se implementará después
    
    # ===== CRITERIO 3: Solicitudes especiales =====
    # TODO: Implementar sistema de solicitudes manuales
    # Por ahora dejamos vacío
    
    # ===== CRITERIO 4: Punto de reorden (stock cercano al mínimo) =====
    cursor.execute("""
        SELECT 
            m.id as mercancia_id,
            m.nombre,
            m.producto_base_id,
            m.minimo_existencia,
            m.maximo_existencia,
            COALESCE(i.disponible_base, 0) as stock_actual,
            (m.maximo_existencia - COALESCE(i.disponible_base, 0)) as cantidad_sugerida
        FROM mercancia m
        LEFT JOIN inventario i ON i.mercancia_id = m.id AND i.empresa_id = %s
        WHERE m.empresa_id = %s
          AND m.activo = 1
          AND m.minimo_existencia > 0
          AND COALESCE(i.disponible_base, 0) >= m.minimo_existencia
          AND COALESCE(i.disponible_base, 0) <= (m.minimo_existencia * 1.2)
    """, (empresa_id, empresa_id))
    
    for row in cursor.fetchall():
        # Evitar duplicados
        if not any(n['mercancia_id'] == row['mercancia_id'] for n in necesidades):
            necesidades.append({
                'mercancia_id': row['mercancia_id'],
                'producto_base_id': row['producto_base_id'],
                'descripcion': row['nombre'],
                'cantidad_sugerida': max(row['cantidad_sugerida'], 0),
                'stock_actual': row['stock_actual'],
                'stock_minimo': row['minimo_existencia'],
                'stock_maximo': row['maximo_existencia'],
                'criterio': 'punto_reorden',
                'prioridad': 2  # Prioridad media
            })
    
    cursor.close()
    db.close()
    
    # Ordenar por prioridad
    necesidades.sort(key=lambda x: x['prioridad'])
    
    return necesidades

def crear_orden_compra_automatica(empresa_id):
    """
    Genera la orden de compra automática del día
    Retorna: orden_id si se creó, None si no había necesidades
    """
    db = conexion_db()
    cursor = db.cursor(dictionary=True)
    
    try:
        # Calcular necesidades
        necesidades = calcular_necesidades_compra(empresa_id)
        
        if not necesidades:
            print(f"No hay necesidades de compra para empresa {empresa_id}")
            return None
        
        # Generar folio
        folio = generar_folio_oc_auto(empresa_id)
        
        # Crear orden maestra
        cursor.execute("""
            INSERT INTO ordenes_compra_automaticas
            (empresa_id, folio, fecha_generacion, tipo_orden, estado, solicitado_por)
            VALUES (%s, %s, NOW(), 'automatica', 'pendiente_revision', 'SISTEMA')
        """, (empresa_id, folio))
        
        orden_id = cursor.lastrowid
        
        # Insertar detalles
        subtotal = Decimal('0.00')
        
        for item in necesidades:
            # Obtener precio estimado (último precio de compra o precio_venta)
            cursor.execute("""
                SELECT precio_venta FROM mercancia WHERE id = %s
            """, (item['mercancia_id'],))
            precio_row = cursor.fetchone()
            precio_estimado = Decimal(precio_row['precio_venta'] if precio_row else '0.00')
            
            cantidad = Decimal(str(item['cantidad_sugerida']))
            importe = cantidad * precio_estimado
            subtotal += importe
            
            # Verificar si ya existe solicitud pendiente
            cursor.execute("""
                SELECT fecha_primera_solicitud
                FROM ordenes_compra_automaticas_detalle
                WHERE mercancia_id = %s
                  AND estado NOT IN ('completado', 'cancelado')
                ORDER BY fecha_primera_solicitud ASC
                LIMIT 1
            """, (item['mercancia_id'],))
            
            fecha_primera = cursor.fetchone()
            fecha_primera_solicitud = fecha_primera['fecha_primera_solicitud'] if fecha_primera else datetime.now()
            
            # Calcular días pendiente
            dias_pendiente = (datetime.now() - fecha_primera_solicitud).days if fecha_primera else 0
            
            cursor.execute("""
                INSERT INTO ordenes_compra_automaticas_detalle
                (orden_id, mercancia_id, producto_base_id, descripcion,
                 cantidad_solicitada, precio_estimado, importe, criterio,
                 stock_actual, stock_minimo, stock_maximo,
                 fecha_primera_solicitud, dias_pendiente, estado)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 'pendiente')
            """, (
                orden_id,
                item['mercancia_id'],
                item['producto_base_id'],
                item['descripcion'],
                item['cantidad_sugerida'],
                precio_estimado,
                importe,
                item['criterio'],
                item['stock_actual'],
                item['stock_minimo'],
                item['stock_maximo'],
                fecha_primera_solicitud,
                dias_pendiente
            ))
        
        # Actualizar totales de la orden
        iva = subtotal * Decimal('0.16')
        total = subtotal + iva
        
        cursor.execute("""
            UPDATE ordenes_compra_automaticas
            SET subtotal = %s, iva = %s, total = %s
            WHERE id = %s
        """, (subtotal, iva, total, orden_id))
        
        db.commit()
        
        print(f"✅ Orden {folio} creada con {len(necesidades)} items")
        return orden_id
        
    except Exception as e:
        db.rollback()
        print(f"❌ Error al crear orden automática: {e}")
        return None
    finally:
        cursor.close()
        db.close()

# Para testing
if __name__ == "__main__":
    empresa_id = 1
    orden_id = crear_orden_compra_automatica(empresa_id)
    if orden_id:
        print(f"Orden creada con ID: {orden_id}")