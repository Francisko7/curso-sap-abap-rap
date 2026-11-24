CLASS zcl_mil_gestion_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mv_total_ok    TYPE i.
    DATA mv_total_tests TYPE i.

    METHODS limpiar_datos_prueba.

    METHODS registrar_resultado
      IMPORTING
        !io_out    TYPE REF TO if_oo_adt_classrun_out
        !iv_num    TYPE i
        !iv_nombre TYPE string
        !iv_ok     TYPE abap_bool
        !iv_info   TYPE string OPTIONAL.



ENDCLASS.



CLASS zcl_mil_gestion_test_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_gest) = NEW zcl_mil_gestion_17( ).
    DATA(lv_hoy)  = cl_abap_context_info=>get_system_date( ).
    DATA(lv_futuro) = CONV d( lv_hoy + 10 ).

    mv_total_ok    = 0.
    mv_total_tests = 18.

    " Limpieza inicial para garantizar idempotencia
    limpiar_datos_prueba( ).

    out->write( '====================================================================' ).
    out->write( '  SUITE DE PRUEBAS AUTOMATIZADAS - EJERCITO DE VALDORIA (_17)       ' ).
    out->write( '====================================================================' ).

    " ------------------------------------------------------------------
    " PRUEBA 01: Crear unidad valida (Exito)
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #(
          id_unidad      = 'TST001'
          nombre         = '1er Batallon Infanteria'
          tipo_unidad    = 'IN'
          base           = 'Fuerte Norte'
          fecha_creacion = lv_hoy
          max_efectivos  = 2
          activa         = 'X'
        ) ).
        registrar_resultado( io_out = out iv_num = 1 iv_nombre = 'Crear unidad TST001' iv_ok = abap_true ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e01).
        registrar_resultado( io_out = out iv_num = 1 iv_nombre = 'Crear unidad TST001' iv_ok = abap_false iv_info = lx_e01->mv_texto ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 02: Leer unidad existente (Exito)
    " ------------------------------------------------------------------
    TRY.
        DATA(ls_u_leida) = lo_gest->leer_unidad( 'TST001' ).
        DATA(lv_ok02) = xsdbool( ls_u_leida-nombre = '1er Batallon Infanteria' ).
        registrar_resultado( io_out = out iv_num = 2 iv_nombre = 'Leer unidad TST001' iv_ok = lv_ok02 ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e02).
        registrar_resultado( io_out = out iv_num = 2 iv_nombre = 'Leer unidad TST001' iv_ok = abap_false iv_info = lx_e02->mv_texto ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 03: Actualizar unidad existente (Exito)
    " ------------------------------------------------------------------
    TRY.
        ls_u_leida-base = 'Base Central'.
        lo_gest->actualizar_unidad( ls_u_leida ).
        DATA(ls_u_act) = lo_gest->leer_unidad( 'TST001' ).
        DATA(lv_ok03) = xsdbool( ls_u_act-base = 'Base Central' ).
        registrar_resultado( io_out = out iv_num = 3 iv_nombre = 'Actualizar base unidad TST001' iv_ok = lv_ok03 ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e03).
        registrar_resultado( io_out = out iv_num = 3 iv_nombre = 'Actualizar base unidad TST001' iv_ok = abap_false iv_info = lx_e03->mv_texto ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 04: Error E001 - Campo obligatorio vacio en unidad
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #( id_unidad = 'TST002' nombre = '' tipo_unidad = 'IN' ) ).
        registrar_resultado( io_out = out iv_num = 4 iv_nombre = 'Validacion E001 campo vacio' iv_ok = abap_false iv_info = 'No lanzo excepcion' ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e04).
        registrar_resultado( io_out = out iv_num = 4 iv_nombre = 'Validacion E001 campo vacio'
                             iv_ok = xsdbool( lx_e04->mv_codigo = zcx_mil_error_17=>gc_campo_obligatorio )
                             iv_info = lx_e04->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 05: Error E002 - Clave duplicada en unidad
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #(
          id_unidad = 'TST001' nombre = 'Duplicada' tipo_unidad = 'TR'
          base = 'Sur' fecha_creacion = lv_hoy max_efectivos = 5 activa = 'X'
        ) ).
        registrar_resultado( io_out = out iv_num = 5 iv_nombre = 'Validacion E002 clave duplicada' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e05).
        registrar_resultado( io_out = out iv_num = 5 iv_nombre = 'Validacion E002 clave duplicada'
                             iv_ok = xsdbool( lx_e05->mv_codigo = zcx_mil_error_17=>gc_clave_duplicada )
                             iv_info = lx_e05->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 06: Error E003 - Leer unidad inexistente
    " ------------------------------------------------------------------
    TRY.
        lo_gest->leer_unidad( 'TST999' ).
        registrar_resultado( io_out = out iv_num = 6 iv_nombre = 'Validacion E003 no existe' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e06).
        registrar_resultado( io_out = out iv_num = 6 iv_nombre = 'Validacion E003 no existe'
                             iv_ok = xsdbool( lx_e06->mv_codigo = zcx_mil_error_17=>gc_no_existe )
                             iv_info = lx_e06->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 07: Error E004 - Tipo de unidad fuera de dominio ('ZZ')
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #(
          id_unidad = 'TST002' nombre = 'Tipo Invalido' tipo_unidad = 'ZZ'
          base = 'Este' fecha_creacion = lv_hoy max_efectivos = 5 activa = 'X'
        ) ).
        registrar_resultado( io_out = out iv_num = 7 iv_nombre = 'Validacion E004 tipo invalido ZZ' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e07).
        registrar_resultado( io_out = out iv_num = 7 iv_nombre = 'Validacion E004 tipo invalido ZZ'
                             iv_ok = xsdbool( lx_e07->mv_codigo = zcx_mil_error_17=>gc_valor_no_permitido )
                             iv_info = lx_e07->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 08: Error E005 - Fecha de creacion futura
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #(
          id_unidad = 'TST002' nombre = 'Unidad Futura' tipo_unidad = 'LG'
          base = 'Oeste' fecha_creacion = lv_futuro max_efectivos = 5 activa = 'X'
        ) ).
        registrar_resultado( io_out = out iv_num = 8 iv_nombre = 'Validacion E005 fecha futura' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e08).
        registrar_resultado( io_out = out iv_num = 8 iv_nombre = 'Validacion E005 fecha futura'
                             iv_ok = xsdbool( lx_e08->mv_codigo = zcx_mil_error_17=>gc_fecha_futura )
                             iv_info = lx_e08->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 09: Error E006 - Capacidad maxima <= 0
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #(
          id_unidad = 'TST002' nombre = 'Sin Aforo' tipo_unidad = 'SN'
          base = 'Norte' fecha_creacion = lv_hoy max_efectivos = 0 activa = 'X'
        ) ).
        registrar_resultado( io_out = out iv_num = 9 iv_nombre = 'Validacion E006 capacidad <= 0' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e09).
        registrar_resultado( io_out = out iv_num = 9 iv_nombre = 'Validacion E006 capacidad <= 0'
                             iv_ok = xsdbool( lx_e09->mv_codigo = zcx_mil_error_17=>gc_importe_invalido )
                             iv_info = lx_e09->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 10: Crear efectivo valido 1 en TST001 (Exito)
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_efectivo( VALUE #(
          id_efectivo   = 'TST00001'
          id_unidad     = 'TST001'
          nombre        = 'Elena'
          apellidos     = 'Vargas Soto'
          rango         = 'CP'
          fecha_ingreso = lv_hoy
          paga_mensual  = '2450.00'
          estado        = 'A'
        ) ).
        registrar_resultado( io_out = out iv_num = 10 iv_nombre = 'Crear efectivo TST00001' iv_ok = abap_true ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e10).
        registrar_resultado( io_out = out iv_num = 10 iv_nombre = 'Crear efectivo TST00001' iv_ok = abap_false iv_info = lx_e10->mv_texto ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 11: Leer y actualizar efectivo (Exito)
    " ------------------------------------------------------------------
    TRY.
        DATA(ls_ef) = lo_gest->leer_efectivo( 'TST00001' ).
        ls_ef-rango = 'CM'.
        ls_ef-paga_mensual = '2900.00'.
        lo_gest->actualizar_efectivo( ls_ef ).
        DATA(ls_ef_act) = lo_gest->leer_efectivo( 'TST00001' ).
        registrar_resultado( io_out = out iv_num = 11 iv_nombre = 'Leer y ascender efectivo TST00001'
                             iv_ok = xsdbool( ls_ef_act-rango = 'CM' ) ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e11).
        registrar_resultado( io_out = out iv_num = 11 iv_nombre = 'Leer y ascender efectivo TST00001' iv_ok = abap_false iv_info = lx_e11->mv_texto ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 12: Error E007 - Asignar efectivo a unidad inactiva
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_unidad( VALUE #(
          id_unidad = 'TST002' nombre = 'Unidad Reserva' tipo_unidad = 'IG'
          base = 'Este' fecha_creacion = lv_hoy max_efectivos = 5 activa = ' '
        ) ).
        lo_gest->crear_efectivo( VALUE #(
          id_efectivo = 'TST00002' id_unidad = 'TST002' nombre = 'Marco' apellidos = 'Ruiz'
          rango = 'SD' fecha_ingreso = lv_hoy paga_mensual = '1300.00' estado = 'A'
        ) ).
        registrar_resultado( io_out = out iv_num = 12 iv_nombre = 'Validacion E007 unidad inactiva' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e12).
        registrar_resultado( io_out = out iv_num = 12 iv_nombre = 'Validacion E007 unidad inactiva'
                             iv_ok = xsdbool( lx_e12->mv_codigo = zcx_mil_error_17=>gc_unidad_no_disponible )
                             iv_info = lx_e12->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 13: Error E008 - Unidad llena (capacidad maxima = 2)
    " ------------------------------------------------------------------
    TRY.
        " Llenamos la segunda y ultima plaza de TST001 (en mision 'M' para prueba 15)
        lo_gest->crear_efectivo( VALUE #(
          id_efectivo = 'TST00002' id_unidad = 'TST001' nombre = 'Carlos' apellidos = 'Mendez'
          rango = 'TN' fecha_ingreso = lv_hoy paga_mensual = '2100.00' estado = 'M'
        ) ).
        " Intentamos meter un tercero (debe saltar E008)
        lo_gest->crear_efectivo( VALUE #(
          id_efectivo = 'TST00003' id_unidad = 'TST001' nombre = 'Lucia' apellidos = 'Gomez'
          rango = 'SG' fecha_ingreso = lv_hoy paga_mensual = '1750.00' estado = 'A'
        ) ).
        registrar_resultado( io_out = out iv_num = 13 iv_nombre = 'Validacion E008 unidad llena' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e13).
        registrar_resultado( io_out = out iv_num = 13 iv_nombre = 'Validacion E008 unidad llena'
                             iv_ok = xsdbool( lx_e13->mv_codigo = zcx_mil_error_17=>gc_unidad_llena )
                             iv_info = lx_e13->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 14: Error E009 - Borrar unidad con efectivos asignados
    " ------------------------------------------------------------------
    TRY.
        lo_gest->borrar_unidad( 'TST001' ).
        registrar_resultado( io_out = out iv_num = 14 iv_nombre = 'Validacion E009 unidad con efectivos' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e14).
        registrar_resultado( io_out = out iv_num = 14 iv_nombre = 'Validacion E009 unidad con efectivos'
                             iv_ok = xsdbool( lx_e14->mv_codigo = zcx_mil_error_17=>gc_unidad_con_efectivos )
                             iv_info = lx_e14->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 15: Error E010 - Borrar efectivo en mision ('M')
    " ------------------------------------------------------------------
    TRY.
        lo_gest->borrar_efectivo( 'TST00002' ).
        registrar_resultado( io_out = out iv_num = 15 iv_nombre = 'Validacion E010 efectivo en mision' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e15).
        registrar_resultado( io_out = out iv_num = 15 iv_nombre = 'Validacion E010 efectivo en mision'
                             iv_ok = xsdbool( lx_e15->mv_codigo = zcx_mil_error_17=>gc_efectivo_en_mision )
                             iv_info = lx_e15->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 16: Error E006 - Paga mensual negativa o cero
    " ------------------------------------------------------------------
    TRY.
        lo_gest->crear_efectivo( VALUE #(
          id_efectivo = 'TST00004' id_unidad = 'TST001' nombre = 'Juan' apellidos = 'Diaz'
          rango = 'SD' fecha_ingreso = lv_hoy paga_mensual = '-100.00' estado = 'A'
        ) ).
        registrar_resultado( io_out = out iv_num = 16 iv_nombre = 'Validacion E006 paga <= 0' iv_ok = abap_false ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e16).
        registrar_resultado( io_out = out iv_num = 16 iv_nombre = 'Validacion E006 paga <= 0'
                             iv_ok = xsdbool( lx_e16->mv_codigo = zcx_mil_error_17=>gc_importe_invalido )
                             iv_info = lx_e16->mv_codigo ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 17: Borrar efectivo activo (Exito)
    " ------------------------------------------------------------------
    TRY.
        lo_gest->borrar_efectivo( 'TST00001' ).
        registrar_resultado( io_out = out iv_num = 17 iv_nombre = 'Borrar efectivo activo TST00001' iv_ok = abap_true ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e17).
        registrar_resultado( io_out = out iv_num = 17 iv_nombre = 'Borrar efectivo activo TST00001' iv_ok = abap_false iv_info = lx_e17->mv_texto ).
    ENDTRY.

    " ------------------------------------------------------------------
    " PRUEBA 18: Cambiar estado de mision a activo y borrar efectivos + unidad (Exito)
    " ------------------------------------------------------------------
    TRY.
        DATA(ls_ef2) = lo_gest->leer_efectivo( 'TST00002' ).
        ls_ef2-estado = 'A'.
        lo_gest->actualizar_efectivo( ls_ef2 ).
        lo_gest->borrar_efectivo( 'TST00002' ).
        lo_gest->borrar_unidad( 'TST001' ).
        lo_gest->borrar_unidad( 'TST002' ).
        registrar_resultado( io_out = out iv_num = 18 iv_nombre = 'Baja completa efectivos y unidades' iv_ok = abap_true ).
      CATCH zcx_mil_error_17 INTO DATA(lx_e18).
        registrar_resultado( io_out = out iv_num = 18 iv_nombre = 'Baja completa efectivos y unidades' iv_ok = abap_false iv_info = lx_e18->mv_texto ).
    ENDTRY.

    " Limpieza final para dejar la base de datos intacta
    limpiar_datos_prueba( ).

    out->write( '====================================================================' ).
    out->write( |  RESUMEN FINAL: { mv_total_ok } / { mv_total_tests } PRUEBAS SUPERADAS  | ).
    out->write( '====================================================================' ).
  ENDMETHOD.

  METHOD limpiar_datos_prueba.
    DELETE FROM zmil_efectivo_17 WHERE id_efectivo LIKE 'TST%'.
    DELETE FROM zmil_unidad_17   WHERE id_unidad   LIKE 'TST%'.
  ENDMETHOD.

  METHOD registrar_resultado.
    DATA(lv_estado) = COND string( WHEN iv_ok = abap_true THEN '[ OK ]' ELSE '[ ERROR ]' ).
    IF iv_ok = abap_true.
      mv_total_ok = mv_total_ok + 1.
    ENDIF.

    DATA(lv_num_txt) = |{ iv_num WIDTH = 2 PAD = '0' ALIGN = RIGHT }|.
    IF iv_info IS INITIAL.
      io_out->write( |Test { lv_num_txt } { lv_estado } - { iv_nombre }| ).
    ELSE.
      io_out->write( |Test { lv_num_txt } { lv_estado } - { iv_nombre } ({ iv_info })| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
