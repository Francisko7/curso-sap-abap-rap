CLASS lhc_zrrapmolino17 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR ZrRapMolino17
        RESULT result.

    METHODS validarPotencia FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrRapMolino17~validarPotencia.

    METHODS validarFechaInst FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrRapMolino17~validarFechaInst.

    METHODS setEstadoInicial FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZrRapMolino17~setEstadoInicial.

   " METHODS setEstadoOperativo FOR DETERMINE ON SAVE
    "  IMPORTING keys FOR ZrRapMolino17~setEstadoOperativo.

    " Nuevo método de determinación al guardar
    METHODS setEstadoActivo FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrRapMolino17~setEstadoActivo.

      " Firma de la determinación del Responsable
    METHODS setResponsableInicial FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZrRapMolino17~setResponsableInicial.

     METHODS validarObligatorios FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrRapMolino17~validarObligatorios.

      METHODS duplicarPotencia FOR MODIFY
      IMPORTING keys FOR ACTION ZrRapMolino17~duplicarPotencia RESULT result.

      METHODS reactivarMolino FOR MODIFY
      IMPORTING keys FOR ACTION ZrRapMolino17~reactivarMolino RESULT result.

ENDCLASS.

CLASS lhc_zrrapmolino17 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validarPotencia.
    " 1. Leer PotenciaKw
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( PotenciaKw )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    " 2. Comprobar potencia negativa
    LOOP AT lt_molinos INTO DATA(ls_molino).
      IF ls_molino-PotenciaKw < 0.
        APPEND VALUE #( %tky = ls_molino-%tky ) TO failed-zrrapmolino17.

        APPEND VALUE #(
          %tky                = ls_molino-%tky
          %element-PotenciaKw = if_abap_behv=>mk-on
          %msg                = new_message_with_text(
                                  severity = if_abap_behv_message=>severity-error
                                  text     = 'La potencia del aerogenerador no puede ser negativa.' )
        ) TO reported-zrrapmolino17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
METHOD validarFechaInst.
    DATA(lv_fecha_hoy) = cl_abap_context_info=>get_system_date( ).

    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( FechaInst )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    LOOP AT lt_molinos INTO DATA(ls_molino).
      " 1. Limpiar estado previo
      APPEND VALUE #( %tky        = ls_molino-%tky
                      %state_area = 'VALIDAR_FECHA' ) TO reported-zrrapmolino17.

      " 2. Comprobar fecha pasada
      IF ls_molino-FechaInst IS NOT INITIAL AND ls_molino-FechaInst < lv_fecha_hoy.
        APPEND VALUE #( %tky = ls_molino-%tky ) TO failed-zrrapmolino17.

        APPEND VALUE #(
          %tky               = ls_molino-%tky
          %state_area        = 'VALIDAR_FECHA'
          %element-FechaInst = if_abap_behv=>mk-on
          %msg               = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'La fecha de instalación no puede ser anterior a la fecha actual.' )
        ) TO reported-zrrapmolino17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD setEstadoActivo.
    " 1. Leer el campo Estado de las instancias que se van a guardar
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    DATA lt_molinos_update TYPE TABLE FOR UPDATE zr_rap_molino_17.

    " 2. Comprobar si el campo Estado está en blanco
    LOOP AT lt_molinos INTO DATA(ls_molino).
      IF ls_molino-Estado IS INITIAL.
        APPEND VALUE #(
          %tky   = ls_molino-%tky
          Estado = 'Activo'
        ) TO lt_molinos_update.
      ENDIF.
    ENDLOOP.

    " 3. Asignar 'Activo' mediante EML en el buffer antes de la persistencia
    IF lt_molinos_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
        ENTITY ZrRapMolino17
        UPDATE FIELDS ( Estado )
        WITH lt_molinos_update.
    ENDIF.
  ENDMETHOD.
METHOD setEstadoInicial.
    " Leer el estado actual al instanciar el borrador
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    DATA lt_molinos_update TYPE TABLE FOR UPDATE zr_rap_molino_17.

    LOOP AT lt_molinos INTO DATA(ls_molino).
      " Solo si viene sin valor, se inicializa como 'Inicial'
      IF ls_molino-Estado IS INITIAL.
        APPEND VALUE #(
          %tky   = ls_molino-%tky
          Estado = 'Inicial'
        ) TO lt_molinos_update.
      ENDIF.
    ENDLOOP.

    IF lt_molinos_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
        ENTITY ZrRapMolino17
        UPDATE FIELDS ( Estado )
        WITH lt_molinos_update.
    ENDIF.
  ENDMETHOD.

*  METHOD setEstadoOperativo.
*    " Leer el estado en la fase de guardado
*    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
*      ENTITY ZrRapMolino17
*      FIELDS ( Estado )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_molinos).
*
*    DATA lt_molinos_update TYPE TABLE FOR UPDATE zr_rap_molino_17.
*
*    LOOP AT lt_molinos INTO DATA(ls_molino).
*      " Si el usuario borró el contenido y lo dejó en blanco, se fija 'Operativo'
*      IF ls_molino-Estado IS INITIAL.
*        APPEND VALUE #(
*          %tky   = ls_molino-%tky
*          Estado = 'Operativo'
*        ) TO lt_molinos_update.
*      ENDIF.
*    ENDLOOP.
*
*    IF lt_molinos_update IS NOT INITIAL.
*      MODIFY ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
*        ENTITY ZrRapMolino17
*        UPDATE FIELDS ( Estado )
*        WITH lt_molinos_update.
*    ENDIF.
*  ENDMETHOD.
METHOD setResponsableInicial.
    " 1. Leer el campo Responsable de las instancias creadas en borrador
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( Responsable )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    DATA lt_molinos_update TYPE TABLE FOR UPDATE zr_rap_molino_17.

    " 2. Asignar el nombre si el campo viene vacío
    LOOP AT lt_molinos INTO DATA(ls_molino).
      IF ls_molino-Responsable IS INITIAL.
        APPEND VALUE #(
          %tky        = ls_molino-%tky
          Responsable = 'Francisco Robleda Torrejón'  " O 'Gemini' si prefieres el nombre del asistente
        ) TO lt_molinos_update.
      ENDIF.
    ENDLOOP.

    " 3. Actualizar el buffer transaccional mediante EML
    IF lt_molinos_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
        ENTITY ZrRapMolino17
        UPDATE FIELDS ( Responsable )
        WITH lt_molinos_update.
    ENDIF.
  ENDMETHOD.

  METHOD validarObligatorios.
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( Nombre Fabricante )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    LOOP AT lt_molinos INTO DATA(ls_molino).
      " Validar Nombre
      IF ls_molino-Nombre IS INITIAL.
        APPEND VALUE #( %tky = ls_molino-%tky ) TO failed-zrrapmolino17.
        APPEND VALUE #(
          %tky            = ls_molino-%tky
          %element-Nombre = if_abap_behv=>mk-on
          %msg            = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'El nombre del aerogenerador es obligatorio.' )
        ) TO reported-zrrapmolino17.
      ENDIF.

      " Validar Fabricante
      IF ls_molino-Fabricante IS INITIAL.
        APPEND VALUE #( %tky = ls_molino-%tky ) TO failed-zrrapmolino17.
        APPEND VALUE #(
          %tky                = ls_molino-%tky
          %element-Fabricante = if_abap_behv=>mk-on
          %msg                = new_message_with_text(
                                  severity = if_abap_behv_message=>severity-error
                                  text     = 'El fabricante es obligatorio.' )
        ) TO reported-zrrapmolino17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD duplicarPotencia.
    " 1. Leer la potencia actual de todos los molinos seleccionados
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( PotenciaKw )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    DATA lt_molinos_update TYPE TABLE FOR UPDATE zr_rap_molino_17.

    " 2. Multiplicar por 2 la potencia de cada molino seleccionado
    LOOP AT lt_molinos INTO DATA(ls_molino).
      APPEND VALUE #(
        %tky       = ls_molino-%tky
        PotenciaKw = ls_molino-PotenciaKw * 2
      ) TO lt_molinos_update.
    ENDLOOP.

    " 3. Actualizar los registros en el buffer transaccional
    IF lt_molinos_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
        ENTITY ZrRapMolino17
        UPDATE FIELDS ( PotenciaKw )
        WITH lt_molinos_update.
    ENDIF.

    " 4. Leer las entidades actualizadas para refrescar la tabla Fiori
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos_actualizados).

    " 5. Devolver el resultado a la pantalla
    result = VALUE #( FOR molino IN lt_molinos_actualizados
                      ( %tky   = molino-%tky
                        %param = molino ) ).
  ENDMETHOD.

  METHOD reactivarMolino.
    " 1. Leer los registros marcados
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      FIELDS ( Estado PotenciaKw )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos).

    DATA lt_molinos_update TYPE TABLE FOR UPDATE zr_rap_molino_17.

    " 2. Asignar Estado = 'Operativo' y PotenciaKw = 1500 directamente
    LOOP AT lt_molinos INTO DATA(ls_molino).
      APPEND VALUE #(
        %tky       = ls_molino-%tky
        Estado     = 'Operativo'
        PotenciaKw = 1500
      ) TO lt_molinos_update.
    ENDLOOP.

    " 3. Aplicar en el buffer transaccional
    IF lt_molinos_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
        ENTITY ZrRapMolino17
        UPDATE FIELDS ( Estado PotenciaKw )
        WITH lt_molinos_update.
    ENDIF.

    " 4. Leer las entidades modificadas
    READ ENTITIES OF zr_rap_molino_17 IN LOCAL MODE
      ENTITY ZrRapMolino17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_molinos_actualizados).

    " 5. Devolver datos actualizados a la tabla
    result = VALUE #( FOR molino IN lt_molinos_actualizados
                      ( %tky   = molino-%tky
                        %param = molino ) ).
  ENDMETHOD.
ENDCLASS.
