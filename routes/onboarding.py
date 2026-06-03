# ========== ONBOARDING MULTI-TENANT (4 PASOS) ==========

@app.route('/onboarding/contratante', methods=['GET', 'POST'])
def onboarding_contratante():
    """PASO 1: Datos del contratante"""
    if 'temp_user_id' not in session:
        return redirect(url_for('registro'))
    
    if request.method == 'POST':
        razon_social = request.form['razon_social']
        rfc = request.form['rfc']
        email_contacto = request.form['email_contacto']
        telefono = request.form.get('telefono', '')
        direccion = request.form.get('direccion', '')
        ciudad = request.form.get('ciudad', '')
        estado = request.form.get('estado', '')
        cp = request.form.get('cp', '')
        tipo_organizacion = request.form['tipo_organizacion']
        tipo_industria = request.form['tipo_industria']
        
        conn = conexion_db()
        cur = conn.cursor(dictionary=True)
        try:
            cur.execute("""
                INSERT INTO contratantes (razon_social, tipo_organizacion, tipo_industria, rfc, email_contacto, 
                                         telefono, direccion, ciudad, estado, cp, activo)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, TRUE)
            """, (razon_social, tipo_organizacion, tipo_industria, rfc, email_contacto, telefono, direccion, ciudad, estado, cp))
            conn.commit()
            contratante_id = cur.lastrowid
            
            session['temp_contratante_id'] = contratante_id
            session['temp_tipo_organizacion'] = tipo_organizacion
            session['temp_tipo_industria'] = tipo_industria
            
            return redirect(url_for('onboarding_empresa'))
        except Exception as e:
            conn.rollback()
            flash(f'Error al registrar contratante: {e}', 'danger')
            return redirect(url_for('onboarding_contratante'))
        finally:
            cur.close()
            conn.close()
    
    return render_template('onboarding/contratante.html')

@app.route('/onboarding/empresa', methods=['GET', 'POST'])
def onboarding_empresa():
    """PASO 2: Datos de la empresa"""
    if 'temp_contratante_id' not in session:
        return redirect(url_for('onboarding_contratante'))
    
    if request.method == 'POST':
        nombre = request.form['nombre']
        rfc = request.form['rfc']
        contratante_id = session['temp_contratante_id']
        
        conn = conexion_db()
        cur = conn.cursor(dictionary=True)
        try:
            cur.execute("""
                INSERT INTO empresas (contratante_id, nombre, rfc, puede_compartir_rfc, activo)
                VALUES (%s, %s, %s, TRUE, TRUE)
            """, (contratante_id, nombre, rfc))
            conn.commit()
            empresa_id = cur.lastrowid
            
            session['temp_empresa_id'] = empresa_id
            return redirect(url_for('onboarding_modulos'))
        except Exception as e:
            conn.rollback()
            flash(f'Error al registrar empresa: {e}', 'danger')
            return redirect(url_for('onboarding_empresa'))
        finally:
            cur.close()
            conn.close()
    
    return render_template('onboarding/empresa.html')

@app.route('/onboarding/modulos', methods=['GET', 'POST'])
def onboarding_modulos():
    """PASO 3: Selección de módulos"""
    if 'temp_empresa_id' not in session:
        return redirect(url_for('onboarding_empresa'))
    
    conn = conexion_db()
    cur = conn.cursor(dictionary=True)
    
    try:
        cur.execute("SELECT * FROM catalogo_modulos WHERE activo = TRUE ORDER BY nombre")
        modulos_lista = cur.fetchall()
        
        if request.method == 'POST':
            modulos_seleccionados = request.form.getlist('modulos[]')
            empresa_id = session['temp_empresa_id']
            
            for modulo_id in modulos_seleccionados:
                cur.execute("""
                    INSERT INTO empresa_modulos (empresa_id, modulo_id, activo)
                    VALUES (%s, %s, TRUE)
                """, (empresa_id, modulo_id))
            conn.commit()
            
            return redirect(url_for('onboarding_plan'))
        
        return render_template('onboarding/modulos.html', modulos=modulos_lista)
    except Exception as e:
        flash(f'Error en módulos: {e}', 'danger')
        return redirect(url_for('onboarding_empresa'))
    finally:
        cur.close()
        conn.close()

@app.route('/onboarding/plan', methods=['GET', 'POST'])
def onboarding_plan():
    """PASO 4: Selección de plan y finalización"""
    if 'temp_empresa_id' not in session:
        return redirect(url_for('onboarding_modulos'))
    
    conn = conexion_db()
    cur = conn.cursor(dictionary=True)
    
    try:
        empresa_id = session['temp_empresa_id']
        contratante_id = session['temp_contratante_id']
        
        cur.execute("""
            SELECT cm.nombre, cm.precio_mensual, cm.precio_anual
            FROM empresa_modulos em
            JOIN catalogo_modulos cm ON em.modulo_id = cm.id
            WHERE em.empresa_id = %s AND em.activo = TRUE
        """, (empresa_id,))
        modulos_lista = cur.fetchall()
        
        subtotal_mensual = sum([float(m['precio_mensual']) for m in modulos_lista])
        subtotal_anual = sum([float(m['precio_anual']) for m in modulos_lista])
        
        if request.method == 'POST':
            tipo_plan = request.form['tipo_plan']
            
            if tipo_plan == 'MENSUAL':
                total = subtotal_mensual
                fecha_vencimiento = datetime.now() + timedelta(days=30)
            else:
                total = subtotal_anual
                fecha_vencimiento = datetime.now() + timedelta(days=365)
            
            cur.execute("""
                INSERT INTO suscripciones (contratante_id, tipo_plan, fecha_inicio, fecha_vencimiento, fecha_proximo_pago, subtotal, total, estado)
                VALUES (%s, %s, CURDATE(), %s, %s, %s, %s, 'ACTIVA')
            """, (contratante_id, tipo_plan, fecha_vencimiento, fecha_vencimiento, total, total))
            conn.commit()
            
            user_id = session['temp_user_id']
            cur.execute("""
                UPDATE usuarios 
                SET contratante_id = %s, empresa_id = %s, activo = TRUE, nombre = %s, empresas_acceso = %s
                WHERE id = %s
            """, (contratante_id, empresa_id, 'Director General', json.dumps([empresa_id]), user_id))
            conn.commit()
            
            # Limpiar sesión temporal
            session.pop('temp_user_id', None)
            session.pop('temp_contratante_id', None)
            session.pop('temp_empresa_id', None)
            session.pop('temp_tipo_organizacion', None)
            session.pop('temp_tipo_industria', None)
            
            flash('¡Registro completado exitosamente! Por favor inicia sesión.', 'success')
            return redirect(url_for('login'))
        
        return render_template('onboarding/plan.html', modulos=modulos_lista, subtotal_mensual=subtotal_mensual, subtotal_anual=subtotal_anual)
    except Exception as e:
        flash(f'Error en plan: {e}', 'danger')
        return redirect(url_for('onboarding_modulos'))
    finally:
        cur.close()
        conn.close()

# Ruta de compatibilidad - redirige al primer paso
@app.route('/onboarding')
@require_login
def onboarding():
    """Redirige al primer paso del onboarding multi-tenant"""
    return redirect(url_for('onboarding_contratante'))