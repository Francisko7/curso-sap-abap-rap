CLASS zcl_mil_gestion_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  " metodos publicos para operaciones crud

  METHODS crear_unidad
    IMPORTING
        !is_unidad TYPE zmil_unidad_17
      RAISING
        zcx_mil_error_17.

   METHODS leer_unidad
      IMPORTING
        !iv_id_unidad    TYPE zmil_de_id_unidad_17
      RETURNING
        VALUE(rs_unidad) TYPE zmil_unidad_17
      RAISING
        zcx_mil_error_17.

    METHODS actualizar_unidad
      IMPORTING
        !is_unidad TYPE zmil_unidad_17
      RAISING
        zcx_mil_error_17.

    METHODS borrar_unidad
      IMPORTING
        !iv_id_unidad TYPE zmil_de_id_unidad_17
      RAISING
        zcx_mil_error_17.



   " metodos publicos para los efectivos ya dentro de la unidad operaciones CRUD

   METHODS crear_efectivo
      IMPORTING
        !is_efectivo TYPE zmil_efectivo_17
      RAISING
        zcx_mil_error_17.

    METHODS leer_efectivo
      IMPORTING
        !iv_id_efectivo    TYPE zmil_de_id_efectivo_17
      RETURNING
        VALUE(rs_efectivo) TYPE zmil_efectivo_17
      RAISING
        zcx_mil_error_17.

    METHODS actualizar_efectivo
      IMPORTING
        !is_efectivo TYPE zmil_efectivo_17
      RAISING
        zcx_mil_error_17.

    METHODS borrar_efectivo
      IMPORTING
        !iv_id_efectivo TYPE zmil_de_id_efectivo_17
      RAISING
        zcx_mil_error_17.
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS existe_unidad
      IMPORTING
        !iv_id_unidad    TYPE zmil_de_id_unidad_17
      RETURNING
        VALUE(rv_existe) TYPE abap_bool.

    METHODS existe_efectivo
      IMPORTING
        !iv_id_efectivo  TYPE zmil_de_id_efectivo_17
      RETURNING
        VALUE(rv_existe) TYPE abap_bool.

    METHODS contar_efectivos_unidad
      IMPORTING
        !iv_id_unidad    TYPE zmil_de_id_unidad_17
      RETURNING
        VALUE(rv_conteo) TYPE i.

    METHODS validar_unidad
      IMPORTING
        !is_unidad TYPE zmil_unidad_17
      RAISING
        zcx_mil_error_17.

    METHODS validar_efectivo
      IMPORTING
        !is_efectivo TYPE zmil_efectivo_17
      RAISING
        zcx_mil_error_17.
ENDCLASS.



CLASS zcl_mil_gestion_17 IMPLEMENTATION.
  METHOD actualizar_unidad.

  " Validaciones generales de la unidad
    validar_unidad( is_unidad ).

    " Comprobar que el registro existe antes de actualizar
    IF existe_unidad( is_unidad-id_unidad ) = abap_false.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |La unidad { is_unidad-id_unidad } no existe para actualizar.|
      ).
    ENDIF.

    " No permitir reducir la capacidad por debajo de los efectivos actuales
    DATA(lv_efectivos) = contar_efectivos_unidad( is_unidad-id_unidad ).
    IF is_unidad-max_efectivos < lv_efectivos.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_unidad_llena
        iv_texto  = |No se puede reducir la capacidad por debajo de los { lv_efectivos } efectivos asignados.|
      ).
    ENDIF.

    " Actualización en base de datos
    DATA(ls_unidad) = is_unidad.
    ls_unidad-client = sy-mandt.

    UPDATE zmil_unidad_17 FROM @ls_unidad.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |Fallo al actualizar la unidad { is_unidad-id_unidad }.|
      ).
    ENDIF.

  ENDMETHOD.

  METHOD borrar_unidad.
  "  Comprobar identificador obligatorio
    IF iv_id_unidad IS INITIAL.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_campo_obligatorio
        iv_texto  = 'El identificador de la unidad es obligatorio.'
      ).
    ENDIF.

    "  Comprobar que la unidad existe
    IF existe_unidad( iv_id_unidad ) = abap_false.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |La unidad { iv_id_unidad } no existe.|
      ).
    ENDIF.

    " Impedir borrado si tiene tropas asignadas
    IF contar_efectivos_unidad( iv_id_unidad ) > 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_unidad_con_efectivos
        iv_texto  = |No se puede borrar la unidad { iv_id_unidad } porque tiene personal militar asignado.|
      ).
    ENDIF.

    "  Eliminación en base de datos
    DELETE FROM zmil_unidad_17 WHERE id_unidad = @iv_id_unidad.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |Fallo al borrar la unidad { iv_id_unidad }.|
      ).
    ENDIF.

  ENDMETHOD.

  METHOD crear_unidad.
   "  Validaciones de campos, dominio, fecha y capacidad
    validar_unidad( is_unidad ).

    "  Comprobar que la clave primaria no esté duplicada
    IF existe_unidad( is_unidad-id_unidad ) = abap_true.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_clave_duplicada
        iv_texto  = |La unidad { is_unidad-id_unidad } ya existe.|
      ).
    ENDIF.

    "  Inserción en base de datos
    DATA(ls_unidad) = is_unidad.
    ls_unidad-client = sy-mandt.

    INSERT zmil_unidad_17 FROM @ls_unidad.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_clave_duplicada
        iv_texto  = |Error de persistencia al crear la unidad { is_unidad-id_unidad }.|
      ).
    ENDIF.

  ENDMETHOD.

  METHOD leer_unidad.
  "  Comprobar que el identificador viene informado
    IF iv_id_unidad IS INITIAL.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_campo_obligatorio
        iv_texto  = 'El identificador de la unidad es obligatorio.'
      ).
    ENDIF.

    "  Lectura de la fila en base de datos
    SELECT SINGLE *
      FROM zmil_unidad_17
      WHERE id_unidad = @iv_id_unidad
      INTO @rs_unidad.

    "  Si no existe, lanzar excepción
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |La unidad { iv_id_unidad } no existe.|
      ).
    ENDIF.

  ENDMETHOD.






  METHOD actualizar_efectivo.
   " 1. Validaciones generales (E001, E004, E005, E006)
    validar_efectivo( is_efectivo ).

    " 2. Comprobar que el efectivo existe y obtener su unidad actual (E003)
    SELECT SINGLE id_unidad
      FROM zmil_efectivo_17
      WHERE id_efectivo = @is_efectivo-id_efectivo
      INTO @DATA(lv_unidad_actual).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |El efectivo { is_efectivo-id_efectivo } no existe para actualizar.|
      ).
    ENDIF.

    " 3. Si hay traslado de unidad, validar disponibilidad y aforo del destino (E007, E008)
    IF is_efectivo-id_unidad <> lv_unidad_actual.
      SELECT SINGLE activa, max_efectivos
        FROM zmil_unidad_17
        WHERE id_unidad = @is_efectivo-id_unidad
        INTO @DATA(ls_dest_info).

      IF sy-subrc <> 0 OR ls_dest_info-activa <> 'X'.
        RAISE EXCEPTION NEW zcx_mil_error_17(
          iv_codigo = zcx_mil_error_17=>gc_unidad_no_disponible
          iv_texto  = |La unidad destino { is_efectivo-id_unidad } no existe o no está activa.|
        ).
      ENDIF.

      IF contar_efectivos_unidad( is_efectivo-id_unidad ) >= ls_dest_info-max_efectivos.
        RAISE EXCEPTION NEW zcx_mil_error_17(
          iv_codigo = zcx_mil_error_17=>gc_unidad_llena
          iv_texto  = |La unidad destino { is_efectivo-id_unidad } está completa.|
        ).
      ENDIF.
    ENDIF.

    " 4. Actualización en base de datos
    DATA(ls_efectivo) = is_efectivo.
    ls_efectivo-client = sy-mandt.

    UPDATE zmil_efectivo_17 FROM @ls_efectivo.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |Fallo al actualizar al efectivo { is_efectivo-id_efectivo }.|
      ).
    ENDIF.

  ENDMETHOD.




  METHOD borrar_efectivo.
    " 1. Comprobar clave obligatoria (E001)
    IF iv_id_efectivo IS INITIAL.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_campo_obligatorio
        iv_texto  = 'El identificador del efectivo es obligatorio.'
      ).
    ENDIF.

    " 2. Comprobar existencia y recuperar su estado operativo (E003)
    SELECT SINGLE estado
      FROM zmil_efectivo_17
      WHERE id_efectivo = @iv_id_efectivo
      INTO @DATA(lv_estado).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |El efectivo { iv_id_efectivo } no existe.|
      ).
    ENDIF.

    " 3. Bloquear baja si el efectivo se encuentra en misión (E010)
    IF lv_estado = 'M'.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_efectivo_en_mision
        iv_texto  = |No se puede dar de baja al efectivo { iv_id_efectivo } porque se encuentra en misión.|
      ).
    ENDIF.

    " 4. Eliminación en base de datos
    DELETE FROM zmil_efectivo_17 WHERE id_efectivo = @iv_id_efectivo.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |Fallo al borrar el registro del efectivo { iv_id_efectivo }.|
      ).
    ENDIF.

  ENDMETHOD.






  METHOD crear_efectivo.
   " 1. Validaciones generales de campos, dominios, fecha y paga (E001, E004, E005, E006)
    validar_efectivo( is_efectivo ).

    " 2. Comprobar que el identificador del efectivo no exista (E002)
    IF existe_efectivo( is_efectivo-id_efectivo ) = abap_true.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_clave_duplicada
        iv_texto  = |El efectivo { is_efectivo-id_efectivo } ya existe.|
      ).
    ENDIF.

    " 3. Comprobar que la unidad asignada existe y está activa (E007)
    SELECT SINGLE activa, max_efectivos
      FROM zmil_unidad_17
      WHERE id_unidad = @is_efectivo-id_unidad
      INTO @DATA(ls_unidad_info).

    IF sy-subrc <> 0 OR ls_unidad_info-activa <> 'X'.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_unidad_no_disponible
        iv_texto  = |La unidad { is_efectivo-id_unidad } no existe o no está activa.|
      ).
    ENDIF.

    " 4. Comprobar que la unidad no ha alcanzado su capacidad máxima (E008)
    DATA(lv_ocupacion) = contar_efectivos_unidad( is_efectivo-id_unidad ).
    IF lv_ocupacion >= ls_unidad_info-max_efectivos.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_unidad_llena
        iv_texto  = |La unidad { is_efectivo-id_unidad } ha alcanzado su capacidad máxima.|
      ).
    ENDIF.

    " 5. Inserción en base de datos asignando el mandante
    DATA(ls_efectivo) = is_efectivo.
    ls_efectivo-client = sy-mandt.

    INSERT zmil_efectivo_17 FROM @ls_efectivo.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_clave_duplicada
        iv_texto  = |Error de persistencia al registrar al efectivo { is_efectivo-id_efectivo }.|
      ).
    ENDIF.

  ENDMETHOD.






  METHOD leer_efectivo.
    " 1. Comprobar clave obligatoria (E001)
    IF iv_id_efectivo IS INITIAL.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_campo_obligatorio
        iv_texto  = 'El identificador del efectivo es obligatorio.'
      ).
    ENDIF.

    " 2. Lectura en base de datos
    SELECT SINGLE *
      FROM zmil_efectivo_17
      WHERE id_efectivo = @iv_id_efectivo
      INTO @rs_efectivo.

    " 3. Si no existe, lanzar excepción E003
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_no_existe
        iv_texto  = |El efectivo { iv_id_efectivo } no existe.|
      ).
    ENDIF.

  ENDMETHOD.





  METHOD contar_efectivos_unidad.

  SELECT COUNT(*)
      FROM zmil_efectivo_17
      WHERE id_unidad = @iv_id_unidad
      INTO @rv_conteo.

  ENDMETHOD.





  METHOD existe_efectivo.

  SELECT SINGLE @abap_true
      FROM zmil_efectivo_17
      WHERE id_efectivo = @iv_id_efectivo
      INTO @rv_existe.

    IF sy-subrc <> 0.
      rv_existe = abap_false.
    ENDIF.


  ENDMETHOD.





  METHOD existe_unidad.
    " busca al menos una fila
    SELECT SINGLE @abap_true
      " dela tabla
      FROM zmil_unidad_17
      " Filtra por la clave primaria , El '@' avisa a SQL de que 'iv_id_unidad' es una variable de nuestro programa ABAP
      WHERE id_unidad = @iv_id_unidad
      " Si encuentra la fila, guarda
      INTO @rv_existe.

    " Comprueba el código de retorno de la base de datos (sy-subrc) <> 0) = no encontró nada
      IF sy-subrc <> 0.
      rv_existe = abap_false.
    ENDIF.

  ENDMETHOD.




  METHOD validar_efectivo.
  IF is_efectivo-id_efectivo   IS INITIAL OR
       is_efectivo-id_unidad     IS INITIAL OR
       is_efectivo-nombre        IS INITIAL OR
       is_efectivo-apellidos     IS INITIAL OR
       is_efectivo-rango         IS INITIAL OR
       is_efectivo-fecha_ingreso IS INITIAL OR
       is_efectivo-estado        IS INITIAL.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_campo_obligatorio
        iv_texto  = 'Todos los campos principales del efectivo militar son obligatorios.'
      ).
    ENDIF.

    " E004: Dominio Rango (SD, CB, SG, TN, CP, CM)
    IF is_efectivo-rango <> 'SD' AND
       is_efectivo-rango <> 'CB' AND
       is_efectivo-rango <> 'SG' AND
       is_efectivo-rango <> 'TN' AND
       is_efectivo-rango <> 'CP' AND
       is_efectivo-rango <> 'CM'.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_valor_no_permitido
        iv_texto  = |El rango militar '{ is_efectivo-rango }' no es válido.|
      ).
    ENDIF.

    " E004: Dominio Estado (A, B, M)
    IF is_efectivo-estado <> 'A' AND
       is_efectivo-estado <> 'B' AND
       is_efectivo-estado <> 'M'.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_valor_no_permitido
        iv_texto  = |El estado operativo '{ is_efectivo-estado }' no es válido.|
      ).
    ENDIF.

    " E005: Fecha futura
    IF is_efectivo-fecha_ingreso > cl_abap_context_info=>get_system_date( ).
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_fecha_futura
        iv_texto  = 'La fecha de ingreso militar no puede ser posterior a la fecha de hoy.'
      ).
    ENDIF.

    " E006: Paga mensual <= 0
    IF is_efectivo-paga_mensual <= 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_importe_invalido
        iv_texto  = 'La retribución mensual del efectivo militar debe ser mayor a 0 EUR.'
      ).
    ENDIF.

  ENDMETHOD.




  METHOD validar_unidad.
  IF is_unidad-id_unidad      IS INITIAL OR
       is_unidad-nombre         IS INITIAL OR
       is_unidad-tipo_unidad    IS INITIAL OR
       is_unidad-base           IS INITIAL OR
       is_unidad-fecha_creacion IS INITIAL.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_campo_obligatorio
        iv_texto  = 'Todos los campos de la unidad militar son obligatorios.'
      ).
    ENDIF.

    " E004: Dominio Tipo de Unidad (IN, TR, LG, SN, IG)
    IF is_unidad-tipo_unidad <> 'IN' AND
       is_unidad-tipo_unidad <> 'TR' AND
       is_unidad-tipo_unidad <> 'LG' AND
       is_unidad-tipo_unidad <> 'SN' AND
       is_unidad-tipo_unidad <> 'IG'.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_valor_no_permitido
        iv_texto  = |Tipo de unidad '{ is_unidad-tipo_unidad }' no permitido.|
      ).
    ENDIF.

    " E004: Dominio Activa ('X' o espacio)
    IF is_unidad-activa <> 'X' AND is_unidad-activa <> ' '.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_valor_no_permitido
        iv_texto  = 'El indicador de activa debe ser X o espacio.'
      ).
    ENDIF.

    " E005: Fecha futura
    IF is_unidad-fecha_creacion > cl_abap_context_info=>get_system_date( ).
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_fecha_futura
        iv_texto  = 'La fecha de creación no puede ser futura.'
      ).
    ENDIF.

    " E006: Capacidad máxima <= 0
    IF is_unidad-max_efectivos <= 0.
      RAISE EXCEPTION NEW zcx_mil_error_17(
        iv_codigo = zcx_mil_error_17=>gc_importe_invalido
        iv_texto  = 'La capacidad máxima de efectivos debe ser estrictamente mayor que cero.'
      ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
