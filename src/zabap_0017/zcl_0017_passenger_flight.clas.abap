CLASS zcl_0017_passenger_flight DEFINITION
  PUBLIC
  INHERITING FROM zcl_0017_flight
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_plane_type    TYPE /dmo/plane_type_id
      RAISING
        zcx_c_abapd_no_connection.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA seats_max TYPE /dmo/plane_seats_max.
ENDCLASS.

CLASS zcl_0017_passenger_flight IMPLEMENTATION.
  METHOD constructor.
    " 1. Llamar al constructor de la superclase
    super->constructor(
      i_carrier_id    = i_carrier_id
      i_connection_id = i_connection_id
      i_plane_type    = i_plane_type
    ).

    " 2. Leer la CDS View ZI_CABAPD_PASSENGER
    DATA(lv_plane_type) = me->plane_type.

    SELECT SINGLE
      FROM zi_cabapd_passenger
      FIELDS maximumseats
      WHERE plane_type_id = @lv_plane_type
      INTO @me->seats_max.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
