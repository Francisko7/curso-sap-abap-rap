CLASS zcl_0017_test_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_0017_test_runner IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " =====================================================================
    " 1. PRUEBA DE TASK 4: Jerarquía de Clases (Flight & Passenger Flight)
    " =====================================================================
    out->write( '---------------------------------------------------' ).
    out->write( '1. Probando Task 4 (Jerarquía de Clases)...' ).
    out->write( '---------------------------------------------------' ).

    TRY.
        " Instanciamos la subclase ZCL_0017_PASSENGER_FLIGHT
        " Nota: Se sugieren valores válidos de prueba del manual (LH, 400, A320-200)
        DATA(lo_passenger_flight) = NEW zcl_0017_passenger_flight(
            i_carrier_id    = 'LH'
            i_connection_id = '0400'
            i_plane_type    = 'A320-200'
        ).

        out->write( |[ÉXITO] Objeto Vuelo Creado:| ).
        out->write( |  Carrier ID: { lo_passenger_flight->carrier_id }| ).
        out->write( |  Connection ID: { lo_passenger_flight->connection_id }| ).
        out->write( |  Origen: { lo_passenger_flight->airport_from }| ).
        out->write( |  Destino: { lo_passenger_flight->airport_to }| ).

      CATCH zcx_c_abapd_no_connection.
        out->write( '[ERROR Task 4] Excepción capturada: Conexión o Avión no encontrado.' ).
      CATCH cx_root INTO DATA(lx_err_t4).
        out->write( |[ERROR Task 4] Ocurrió una excepción inesperada: { lx_err_t4->get_text( ) }| ).
    ENDTRY.


    " =====================================================================
    " PRUEBA EXCLUSIVA DE TASK 5: ZCL_0017_CONNECTIONS
    " =====================================================================
    out->write( '---------------------------------------------------' ).
    out->write( 'Probando Task 5: Lectura de Conexiones desde EDI...' ).
    out->write( '---------------------------------------------------' ).

    " 1. Instanciar la clase de conexiones
    DATA(lo_conn) = NEW zcl_0017_connections( ).

    " 2. Consultar las conexiones para el aeropuerto 'EDI' (caso de prueba del examen)
    DATA(lt_connections) = lo_conn->get_connections( i_departure = 'FRA' ).

    " 3. Mostrar el número de registros y la tabla con los resultados en la consola
    IF lt_connections IS NOT INITIAL.
      out->write( |Conexiones encontradas: { lines( lt_connections ) }| ).
      out->write( lt_connections ).
    ELSE.
      out->write( 'No se encontraron registros para el aeropuerto especificado.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
