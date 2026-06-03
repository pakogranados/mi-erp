"""
Sistema de Órdenes de Compra Automáticas
Genera órdenes basadas en:
1. Stock total por MATERIA PRIMA (producto_base) bajo mínimo
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
        host='localhost',
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

def calcular_stock_total_materia_prima(empresa_id, producto_base_id):
    """
    Calcula el stock TOTAL de una materia prima sumando TODAS sus presentaciones
    """
    db = conexion_db()
    cursor = db.cursor(dictionary=True)
    
    cursor.execute("""
        SELECT COALESCE(SUM(i.disponible_base), 0) as stock_total
        FROM mercancia m
        LEFT JOIN inventario i ON i.mercancia_id = m.id AND i.empresa_id = %s
        WHERE m.producto_base_id = %s
          AND m.empresa_id = %s
          AND m.activo = 1
    """, (empresa_id, producto_base_id, empresa_id))
    
    resultado = cursor.fetchone()
    stock_total = Decimal(str(resultado['stock_total'])) if resultado else Decimal('0')
    
    cursor.close()
    db.close()
    
    return stock_total

def obtener_presentacion_preferida(empresa_id, producto_base_id):
    """
    Obtiene la presentación preferida de compra (la más comprada o la primera registrada)
    """
    db = conexion_db()
    cursor = db.cursor(dictionary=True)
    
    # Intentar obtener la más comprada
    cursor.execute("""
        SELECT m.id, m.nombre
        FROM mercancia m
        LEFT JOIN detalle_compra dc ON dc.mercancia_id = m.id
        WHERE m.producto_base_id = %s
          AND m.empresa_id = %s
          AND m.activo = 1
        GROUP BY m.id, m.nombre
        ORDER BY COUNT(dc.id) DESC, m.id ASC
        LIMIT 1
    """, (producto_base_id, empresa_id))
    
    presentacion = cursor.fetchone()
    
    cursor.close()
    db.close()
    
    return presentacion

def calcular_necesidades_compra(empresa_id):
    """
    Calcula qué MATERIAS PRIMAS necesitan comprarse
    Retorna lista de diccionarios con: producto_base_id, mercancia_id (presentación), cantidad_sugerida, etc.
    """
    db = conexion_db()
    cursor = db.cursor(dictionary=True)
    
    necesidades = []
    
    # ===== CRITERIO 1: Stock total de MATERIA PRIMA bajo mínimo =====
    cursor.execute("""
        SELECT 
            pb.id as producto_base_id,
            pb.nombre as materia_prima,
            pb.minimo_existencia,
            pb.maximo_existencia,
            pb.subcuenta_id
        FROM producto_base pb
        WHERE pb.empresa_id = %s
          AND pb.activo = 1
          AND pb.minimo_existencia > 0
    """, (empresa_id,))
    
    for row in cursor.fetchall():
        producto_base_id = row['producto_base_id']
        
        # Calcular stock TOTAL de esta materia prima (suma de todas presentaciones)
        stock_total = calcular_stock_total_materia_prima(empresa_id, producto_base_id)
        minimo = Decimal(str(row['minimo_existencia']))
        maximo = Decimal(str(row['maximo_existencia']))
        
        # ¿Está bajo el mínimo?
        if stock_total < minimo:
            # Obtener presentación preferida para comprar
            presentacion = obtener_presentacion_preferida(empresa_id, producto_base_id)
            
            if presentacion:
                cantidad_sugerida = max(maximo - stock_total, Decimal('0'))
                
                necesidades.append({
                    'producto_base_id': producto_base_id,
                    'mercancia_id': presentacion['id'],
                    'descripcion': f"{presentacion['nombre']} (MP: {row['materia_prima']})",
                    'materia_prima': row['materia_prima'],
                    'cantidad_sugerida': cantidad_sugerida,
                    'stock_actual': stock_total,
                    'stock_minimo': minimo,
                    'stock_maximo': maximo,
                    'criterio': 'mp_bajo_minimo',
                    'prioridad': 1  # Alta prioridad
                })
    
    # ===== CRITERIO 2: Punto de reorden (stock cercano al mínimo - 20% sobre mínimo) =====
    cursor.execute("""
        SELECT 
            pb.id as producto_base_id,
            pb.nombre as materia_prima,
            pb.minimo_existencia,
            pb.maximo_existencia,
            pb.subcuenta_id
        FROM producto_base pb
        WHERE pb.empresa_id = %s
          AND pb.activo = 1
          AND pb.minimo_existencia > 0
    """, (empresa_id,))
    
    for row in cursor.fetchall():
        producto_base_id = row['producto_base_id']
        
        # Evitar duplicados (si ya está en necesidades por criterio 1)
        if any(n['producto_base_id'] == producto_base_id for n in necesidades):
            continue
        
        stock_total = calcular_stock_total_materia_prima(empresa_id, producto_base_id)
        minimo = Decimal(str(row['minimo_existencia']))
        maximo = Decimal(str(row['maximo_existencia']))
        umbral_reorden = minimo * Decimal('1.2')
        
        # ¿Está sobre mínimo pero bajo umbral de reorden?
        if stock_total >= minimo and stock_total <= umbral_reorden:
            presentacion = obtener_presentacion_preferida(empresa_id, producto_base_id)
            
            if presentacion:
                cantidad_sugerida = max(maximo - stock_total, Decimal('0'))
                
                necesidades.append({
                    'producto_base_id': producto_base_id,
                    'mercancia_id': presentacion['id'],
                    'descripcion': f"{presentacion['nombre']} (MP: {row['materia_prima']})",
                    'materia_prima': row['materia_prima'],
                    'cantidad_sugerida': cantidad_sugerida,
                    'stock_actual': stock_total,
                    'stock_minimo': minimo,
                    'stock_maximo': maximo,
                    'criterio': 'mp_punto_reorden',
                    'prioridad': 2  # Prioridad media
                })
    
    cursor.close()
    db.close()
    
    # Ordenar por prioridad
    necesidades.sort(key=lambda x: x['prioridad'])
    
    return necesidades

def crear_orden_compra_automatica(empresa_id):
    """
    Genera la orden de compra automática del día basada en MATERIA PRIMA
    Retorna: orden_id si se creó, None si no había necesidades
    """
    db = conexion_db()
    cursor = db.cursor(dictionary=True)
    
    try:
        # Calcular necesidades
        necesidades = calcular_necesidades_compra(empresa_id)
        
        if not necesidades:
            print(f"✅ No hay necesidades de compra para empresa {empresa_id}")
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
            
            # Verificar si ya existe solicitud pendiente para esta MATERIA PRIMA
            cursor.execute("""
                SELECT fecha_primera_solicitud
                FROM ordenes_compra_automaticas_detalle
                WHERE producto_base_id = %s
                  AND estado NOT IN ('completado', 'cancelado')
                ORDER BY fecha_primera_solicitud ASC
                LIMIT 1
            """, (item['producto_base_id'],))
            
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
        
        print(f"✅ Orden {folio} creada con {len(necesidades)} items (por MATERIA PRIMA)")
        return orden_id
        
    except Exception as e:
        db.rollback()
        print(f"❌ Error al crear orden automática: {e}")
        import traceback
        traceback.print_exc()
        return None
    finally:
        cursor.close()
        db.close()

# Para testing
if __name__ == "__main__":
    empresa_id = 10  # Cambiar por tu empresa_id
    print(f"Generando orden automática para empresa {empresa_id}...")
    orden_id = crear_orden_compra_automatica(empresa_id)
    if orden_id:
        print(f"✅ Orden creada con ID: {orden_id}")
    else:
        print("ℹ️ No se creó orden (no hay necesidades)")