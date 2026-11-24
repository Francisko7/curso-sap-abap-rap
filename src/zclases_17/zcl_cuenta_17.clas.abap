CLASS zcl_cuenta_17 DEFINITION
 PUBLIC
 FINAL
 CREATE PUBLIC.
  PUBLIC SECTION.
    DATA titular TYPE string.
    DATA saldo   TYPE i.

    METHODS ingresar      IMPORTING iv_importe TYPE i.
    METHODS retirar       IMPORTING iv_importe TYPE i.
    METHODS obtener_saldo RETURNING VALUE(rv_saldo) TYPE i.
ENDCLASS.



CLASS ZCL_CUENTA_17 IMPLEMENTATION.


  METHOD obtener_saldo.
    rv_saldo = saldo.
  ENDMETHOD.


  METHOD retirar.
    IF iv_importe <= saldo.
      saldo = saldo - iv_importe.
    ENDIF.
  ENDMETHOD.


  METHOD ingresar.
    saldo = saldo + iv_importe.
  ENDMETHOD.
ENDCLASS.
