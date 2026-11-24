CLASS zcl_0017_flight DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.
   " Atributos visibles y de solo lectura para consumidores externos
    DATA carrier_id    TYPE /dmo/carrier_id READ-ONLY.
    DATA connection_id TYPE /dmo/connection_id READ-ONLY.
    DATA airport_from  TYPE /dmo/airport_from_id READ-ONLY.
    DATA airport_to    TYPE /dmo/airport_to_id READ-ONLY.

    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_plane_type    TYPE /dmo/plane_type_id
      RAISING
        zcx_c_abapd_no_connection.
  PROTECTED SECTION.
    " Atributo accesible por la clase y sus subclases (no por consumidores externos)
    DATA plane_type TYPE /dmo/plane_type_id.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_0017_flight IMPLEMENTATION.

   METHOD constructor.
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.
    me->plane_type    = i_plane_type.

    " 2. Leer /dmo/connection para obtener airport_from y airport_to
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id    = @i_carrier_id
        AND connection_id = @i_connection_id
      INTO (@me->airport_from, @me->airport_to).

    " Si no existe el registro, lanzar la excepción requerida
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
