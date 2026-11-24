CLASS LHC_ZR_AUTO_VEH_17 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrAutoVeh17
        RESULT result.

        METHODS setDatosIniciales FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZrAutoVeh17~setDatosIniciales.

      METHODS validarDatosObligatorios FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarDatosObligatorios.


      METHODS validarMatricula FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarMatricula.

      METHODS validarAnioFabricacion FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarAnioFabricacion.

      METHODS validarKilometros FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarKilometros.

      METHODS validarPotencia FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarPotencia.

      METHODS validarPrecio FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarPrecio.

      METHODS validarCombustible FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarCombustible.

      METHODS validarEstadoModificacion FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarEstadoModificacion.

      METHODS validarBastidor FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrAutoVeh17~validarBastidor.


      " acciones personalizadas


      " duplicar precio solo si esta disponible

      METHODS DuplicarPrecio FOR MODIFY
          IMPORTING keys FOR ACTION ZrAutoVeh17~DuplicarPrecio RESULT result.

      METHODS AplicarDescuento FOR MODIFY
      IMPORTING keys FOR ACTION ZrAutoVeh17~AplicarDescuento RESULT result.

      METHODS ReservarVehiculo FOR MODIFY
      IMPORTING keys FOR ACTION ZrAutoVeh17~ReservarVehiculo RESULT result.

      METHODS CancelarReserva FOR MODIFY
      IMPORTING keys FOR ACTION ZrAutoVeh17~CancelarReserva RESULT result.

      METHODS VenderVehiculo FOR MODIFY
      IMPORTING keys FOR ACTION ZrAutoVeh17~VenderVehiculo RESULT result.




ENDCLASS.

CLASS LHC_ZR_AUTO_VEH_17 IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD setDatosIniciales.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Estado Moneda )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    MODIFY ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      UPDATE FIELDS ( Estado Moneda )
      WITH VALUE #( FOR veh IN lt_vehiculos (
        %tky   = veh-%tky
        Estado = COND #( WHEN veh-Estado IS INITIAL THEN 'D' ELSE veh-Estado )
        Moneda = COND #( WHEN veh-Moneda IS INITIAL THEN 'EUR' ELSE veh-Moneda )
      ) ).
  ENDMETHOD.


  METHOD validarDatosObligatorios.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Marca Modelo )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Marca IS INITIAL.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-marca = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'La marca es un campo obligatorio.' )
                      ) TO reported-zrautoveh17.
      ENDIF.

      IF ls_veh-Modelo IS INITIAL.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-modelo = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'El modelo es un campo obligatorio.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD validarMatricula.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Matricula )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Matricula IS INITIAL.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-matricula = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'La matrícula es obligatoria.' )
                      ) TO reported-zrautoveh17.
        CONTINUE.
      ENDIF.

      DATA(lv_mat_norm) = ls_veh-Matricula.
      CONDENSE lv_mat_norm NO-GAPS.
      TRANSLATE lv_mat_norm TO UPPER CASE.

      SELECT SINGLE FROM zauto_veh_17
        FIELDS vehiculo_uuid
        WHERE matricula = @ls_veh-Matricula
          AND vehiculo_uuid <> @ls_veh-VehiculoUUID
        INTO @DATA(lv_existe_mat).

      IF sy-subrc = 0.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-matricula = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Ya existe un vehículo con la misma matrícula.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validarBastidor.
  READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
    ENTITY ZrAutoVeh17
    FIELDS ( Bastidor )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_vehiculos).

  LOOP AT lt_vehiculos INTO DATA(ls_veh).
    IF strlen( ls_veh-Bastidor ) <> 17.
      APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
      APPEND VALUE #( %tky = ls_veh-%tky
                      %element-bastidor = if_abap_behv=>mk-on
                      %msg = new_message_with_text(
                               severity = if_abap_behv_message=>severity-error
                               text     = 'El bastidor debe tener exactamente 17 caracteres.' )
                    ) TO reported-zrautoveh17.
    ENDIF.

    IF ls_veh-Bastidor CA 'IOQioq'.
      APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
      APPEND VALUE #( %tky = ls_veh-%tky
                      %element-bastidor = if_abap_behv=>mk-on
                      %msg = new_message_with_text(
                               severity = if_abap_behv_message=>severity-error
                               text     = 'El bastidor no puede contener las letras I, O o Q.' )
                    ) TO reported-zrautoveh17.
    ENDIF.

    SELECT SINGLE FROM zauto_veh_17
      FIELDS vehiculo_uuid
      WHERE bastidor = @ls_veh-Bastidor
        AND vehiculo_uuid <> @ls_veh-VehiculoUUID
      INTO @DATA(lv_existe_bas).

    IF sy-subrc = 0.
      APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
      APPEND VALUE #( %tky = ls_veh-%tky
                      %element-bastidor = if_abap_behv=>mk-on
                      %msg = new_message_with_text(
                               severity = if_abap_behv_message=>severity-error
                               text     = 'Ya existe un vehículo con el mismo número de bastidor.' )
                    ) TO reported-zrautoveh17.
    ENDIF.
  ENDLOOP.
ENDMETHOD.

METHOD validarAnioFabricacion.
   " obtenemos la fecha actual con la api de abap
    DATA(lv_today)        = cl_abap_context_info=>get_system_date( ).

    " extra los primeros 4 caracteres de la fecha
    DATA(lv_current_year) = lv_today(4).


   " lectura eml sobre el bufer
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17      " especificamos el alias de la entidad
      FIELDS ( AnioFabricacion )  " solo el campo necesario
      WITH CORRESPONDING #( keys )   " pasa la clave
      RESULT DATA(lt_vehiculos).    " guardamos en la tabla interna

    LOOP AT lt_vehiculos INTO DATA(ls_veh).  " loop que itera sobre cada uno de los objetos
      IF ls_veh-AnioFabricacion < 1900 OR ls_veh-AnioFabricacion > lv_current_year.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-aniofabricacion = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'El año de fabricación debe estar entre 1900 y el año actual.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


 METHOD validarKilometros.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Kilometros )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      " 1. Limpieza de estado previo (imprescindible para refresco en tiempo real)
      APPEND VALUE #( %tky        = ls_veh-%tky
                      %state_area = 'VALIDAR_KM' ) TO reported-zrautoveh17.

      " 2. Comprobación de kilómetros negativos
      IF ls_veh-Kilometros < 0.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.

        " 3. Mensaje de estado vinculado al campo visual
        APPEND VALUE #(
          %tky                = ls_veh-%tky
          %state_area         = 'VALIDAR_KM'
          %element-Kilometros = if_abap_behv=>mk-on
          %msg                = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Los kilómetros no pueden ser negativos.' )
        ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validarPotencia.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( PotenciaCv )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-PotenciaCv <= 0.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-potenciacv = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'La potencia debe ser estrictamente positiva.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validarPrecio.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Precio )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Precio <= 0.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-precio = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'El precio debe ser estrictamente positivo.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validarCombustible.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Combustible )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF NOT ( ls_veh-Combustible = 'GA' OR
               ls_veh-Combustible = 'DI' OR
               ls_veh-Combustible = 'HI' OR
               ls_veh-Combustible = 'EL' ).
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %element-combustible = if_abap_behv=>mk-on
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Combustible inválido. Valores permitidos: GA, DI, HI, EL.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

METHOD validarEstadoModificacion.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Estado VehiculoUUID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      " 1. Consultar el estado previo en la tabla de base de datos
      SELECT SINGLE estado
        FROM zauto_veh_17
        WHERE vehiculo_uuid = @ls_veh-VehiculoUUID
        INTO @DATA(lv_estado_db).

      " 2. Solo se bloquea si el coche YA figuraba como vendido en la base de datos
      IF sy-subrc = 0 AND lv_estado_db = 'V'.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Los vehículos vendidos no admiten modificaciones.' )
                      ) TO reported-zrautoveh17.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  " implementación de las acciones personalizadas

  METHOD DuplicarPrecio.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Precio Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Estado <> 'D'.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Solo se puede duplicar el precio de vehículos Disponibles.' )
                      ) TO reported-zrautoveh17.
     ELSE.
        MODIFY ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
          ENTITY ZrAutoVeh17
          UPDATE FIELDS ( Precio )
          WITH VALUE #( ( %tky   = ls_veh-%tky
                          Precio = ls_veh-Precio * 2 ) ).

      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_actualizados).

    result = VALUE #( FOR veh IN lt_actualizados
                      ( %tky = veh-%tky %param = veh ) ).
  ENDMETHOD.

  METHOD AplicarDescuento.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Precio Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Estado <> 'D'.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Solo se puede aplicar descuento a vehículos Disponibles.' )
                      ) TO reported-zrautoveh17.
      ELSE.
        DATA(lv_descontado) = round( val = ls_veh-Precio * '0.90' dec = 2 ).
        IF lv_descontado <= 0.
          APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
          APPEND VALUE #( %tky = ls_veh-%tky
                          %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'El precio resultante con descuento no es válido.' )
                        ) TO reported-zrautoveh17.
        ELSE.
          MODIFY ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
            ENTITY ZrAutoVeh17
            UPDATE FIELDS ( Precio )
            WITH VALUE #( ( %tky = ls_veh-%tky Precio = lv_descontado ) ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_actualizados).

    result = VALUE #( FOR veh IN lt_actualizados
                      ( %tky = veh-%tky %param = veh ) ).
  ENDMETHOD.

  METHOD ReservarVehiculo.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Estado <> 'D'.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |No es posible reservar: el estado actual no es Disponible.| )
                      ) TO reported-zrautoveh17.
      ELSE.
        MODIFY ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
          ENTITY ZrAutoVeh17
          UPDATE FIELDS ( Estado )
          WITH VALUE #( ( %tky = ls_veh-%tky Estado = 'R' ) ).
      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_actualizados).

    result = VALUE #( FOR veh IN lt_actualizados
                      ( %tky = veh-%tky %param = veh ) ).
  ENDMETHOD.

  METHOD CancelarReserva.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Estado <> 'R'.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Solo se puede cancelar la reserva de un vehículo Reservado.' )
                      ) TO reported-zrautoveh17.
      ELSE.
        MODIFY ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
          ENTITY ZrAutoVeh17
          UPDATE FIELDS ( Estado )
          WITH VALUE #( ( %tky = ls_veh-%tky Estado = 'D' ) ).
      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_actualizados).

    result = VALUE #( FOR veh IN lt_actualizados
                      ( %tky = veh-%tky %param = veh ) ).
  ENDMETHOD.

  METHOD VenderVehiculo.
    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      FIELDS ( Estado )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vehiculos).

    LOOP AT lt_vehiculos INTO DATA(ls_veh).
      IF ls_veh-Estado = 'V'.
        APPEND VALUE #( %tky = ls_veh-%tky ) TO failed-zrautoveh17.
        APPEND VALUE #( %tky = ls_veh-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'El vehículo ya se encuentra Vendido.' )
                      ) TO reported-zrautoveh17.
      ELSE.
        MODIFY ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
          ENTITY ZrAutoVeh17
          UPDATE FIELDS ( Estado )
          WITH VALUE #( ( %tky = ls_veh-%tky Estado = 'V' ) ).
      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_auto_veh_17 IN LOCAL MODE
      ENTITY ZrAutoVeh17
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_actualizados).

    result = VALUE #( FOR veh IN lt_actualizados
                      ( %tky = veh-%tky %param = veh ) ).
  ENDMETHOD.
ENDCLASS.
