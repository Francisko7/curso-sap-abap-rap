CLASS zcl_0017_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_connection,
             carrier_id      TYPE /dmo/carrier_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             airport_via_id  TYPE /dmo/airport_from_id,
           END OF ty_connection,
           tt_connections TYPE STANDARD TABLE OF ty_connection WITH DEFAULT KEY.

    METHODS get_connections
      IMPORTING
        i_departure          TYPE /dmo/airport_from_id
      RETURNING
        VALUE(r_connections) TYPE tt_connections.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_0017_connections IMPLEMENTATION.
  METHOD get_connections.
*    " 1. Obtener conexiones directas desde el aeropuerto de salida
*    SELECT FROM /dmo/connection
*      FIELDS
*        carrier_id,
*        airport_from_id,
*        airport_to_id,
*        '-' AS airport_via_id
*      WHERE airport_from_id = @i_departure
*      INTO TABLE @DATA(lt_direct_connections).
*
*    " 2. Obtener conexiones con 1 escala (misma aerolínea, evitando retornos)
*    SELECT FROM /dmo/connection AS c1
*      INNER JOIN /dmo/connection AS c2
*        ON  c1~carrier_id      = c2~carrier_id
*        AND c1~airport_to_id    = c2~airport_from_id
*      FIELDS
*        c1~carrier_id,
*        c1~airport_from_id,
*        c2~airport_to_id   AS airport_to_id,
*        c1~airport_to_id     AS airport_via_id
*      WHERE c1~airport_from_id = @i_departure
*        AND c2~airport_to_id   <> @i_departure " Excluir vuelos de retorno
*      INTO TABLE @DATA(lt_transfer_connections).
*
*    " 3. Combinar ambos resultados en la tabla de salida
*    r_connections = CORRESPONDING #( lt_direct_connections ).
*    APPEND LINES OF CORRESPONDING zcert_connections( lt_transfer_connections ) TO r_connections.




    " 1. Vuelos directos desde el aeropuerto de origen
    SELECT FROM /dmo/connection
      FIELDS
        carrier_id,
        airport_from_id,
        airport_to_id,
        '-' AS airport_via_id
      WHERE airport_from_id = @i_departure
      INTO TABLE @DATA(lt_direct_connections).

    " 2. Vuelos con 1 escala (misma aerolínea, sin incluir retornos)
    SELECT FROM /dmo/connection AS c1
      INNER JOIN /dmo/connection AS c2
        ON  c1~carrier_id   = c2~carrier_id
        AND c1~airport_to_id = c2~airport_from_id
      FIELDS
        c1~carrier_id,
        c1~airport_from_id,
        c2~airport_to_id AS airport_to_id,
        c1~airport_to_id   AS airport_via_id
      WHERE c1~airport_from_id = @i_departure
        AND c2~airport_to_id   <> @i_departure
      INTO TABLE @DATA(lt_transfer_connections).

    " 3. Combinar ambos resultados en la tabla de salida
    r_connections = CORRESPONDING #( lt_direct_connections ).
    APPEND LINES OF CORRESPONDING tt_connections( lt_transfer_connections ) TO r_connections.

  ENDMETHOD.
ENDCLASS.
