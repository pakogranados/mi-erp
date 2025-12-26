"""
    app_multitenant.py - Sistema ERP Multi-Tenant
    Sistema modular con onboarding, autenticación y administración por contratante
"""

from flask import Flask, g, session
from flask_mysqldb import MySQL
import sys
import os

# Detectar si estamos en PythonAnywhere
if '/home/' in os.getcwd():
    try:
        from config_pythonanywhere import Config
    except:
        from config import Config
else:
    from config import Config

app = Flask(__name__)
app.config.from_object(Config)

mysql = MySQL(app)

@app.before_request
def before_request():
    """Carga contexto multi-tenant automáticamente en cada petición"""
    # Variables básicas de sesión
    g.user_id = session.get('user_id')
    g.usuario_id = session.get('user_id')  # Compatibilidad con código existente
    g.empresa_id = session.get('empresa_id')
    g.contratante_id = session.get('contratante_id')
    g.rango = session.get('rango', 4)
    g.empresas_acceso = session.get('empresas_acceso', [])
    g.puede_agregar_usuarios = session.get('puede_agregar_usuarios', False)
    g.user_name = session.get('user_name', '')
    g.usuario_nombre = session.get('user_name', '')  # Compatibilidad
    g.user_email = session.get('user_email', '')
    g.rol = session.get('rol', 'editor')
    g.es_admin = session.get('rol') == 'admin'
    
    # Variables de empresa (se cargan dinámicamente)
    g.empresa_nombre = None
    g.empresa_logo = None
    g.empresas_usuario = []
    g.usuario_areas = []
    
    # Si el usuario está logueado, cargar información adicional
    if g.user_id and g.empresa_id:
        try:
            cur = mysql.connection.cursor()
            
            # Cargar info de la empresa actual
            cur.execute("""
                SELECT nombre, logo_url 
                FROM empresas 
                WHERE id = %s AND contratante_id = %s
            """, (g.empresa_id, g.contratante_id))
            empresa_actual = cur.fetchone()
            
            if empresa_actual:
                g.empresa_nombre = empresa_actual['nombre']
                g.empresa_logo = empresa_actual.get('logo_url')
            
            # Cargar áreas del usuario (si la tabla existe - compatibilidad)
            try:
                cur.execute("""
                    SELECT a.codigo, a.nombre, ua.rol_area
                    FROM usuario_areas ua
                    JOIN areas_sistema a ON a.id = ua.area_id
                    WHERE ua.usuario_id = %s 
                      AND ua.empresa_id = %s 
                      AND ua.activo = 1
                      AND a.activo = 1
                """, (g.user_id, g.empresa_id))
                areas = cur.fetchall()
                g.usuario_areas = [a['codigo'] for a in areas]
            except:
                # Si no existe la tabla usuario_areas, continuar
                g.usuario_areas = []
            
            # Admin tiene acceso a todo
            if g.es_admin or g.rango <= 2:
                g.usuario_areas = ['ADMIN', 'VENTAS', 'INVENTARIO', 'COMPRAS', 'CAJA', 
                                   'CXC', 'CXP', 'CONTABILIDAD', 'RRHH', 'GASTOS',
                                   'B2B_CLIENTE', 'B2B_PROVEEDOR', 'REPARTO', 
                                   'ADMINISTRACION', 'REPORTES', 'AUDITORIA']
            
            # Cargar lista de empresas del contratante (para selector)
            if g.rango <= 2:  # Director General o Gerente
                cur.execute("""
                    SELECT id, nombre 
                    FROM empresas 
                    WHERE contratante_id = %s AND activo = 1 
                    ORDER BY nombre
                """, (g.contratante_id,))
                g.empresas_usuario = cur.fetchall()
            else:
                # Usuarios de rango inferior solo ven las empresas a las que tienen acceso
                if g.empresas_acceso:
                    placeholders = ','.join(['%s'] * len(g.empresas_acceso))
                    cur.execute(f"""
                        SELECT id, nombre 
                        FROM empresas 
                        WHERE id IN ({placeholders}) AND activo = 1 
                        ORDER BY nombre
                    """, g.empresas_acceso)
                    g.empresas_usuario = cur.fetchall()
            
            cur.close()
                
        except Exception as e:
            print(f"⚠️ Error cargando contexto empresa: {e}")
            # En caso de error, asegurar valores por defecto
            g.empresa_nombre = None
            g.empresa_logo = None
            g.empresas_usuario = []
            g.usuario_areas = []

from routes import auth, onboarding, dashboard, admin



@app.context_processor
def inject_user():
    """Hace disponibles las variables de sesión en todos los templates"""
    return dict(
        user_id=g.get('user_id'),
        usuario_id=g.get('usuario_id'),
        user_name=g.get('user_name'),
        usuario_nombre=g.get('usuario_nombre'),
        user_email=g.get('user_email'),
        empresa_id=g.get('empresa_id'),
        empresa_nombre=g.get('empresa_nombre'),
        empresa_logo=g.get('empresa_logo'),
        contratante_id=g.get('contratante_id'),
        rango=g.get('rango'),
        rol=g.get('rol'),
        es_admin=g.get('es_admin'),
        puede_agregar_usuarios=g.get('puede_agregar_usuarios', False),
        empresas_usuario=g.get('empresas_usuario', []),
        usuario_areas=g.get('usuario_areas', [])
    )

if __name__ == '__main__':
    app.run(debug=True, port=5001)