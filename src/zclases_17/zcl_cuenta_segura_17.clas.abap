CLASS zcl_cuenta_segura_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS constructor
      IMPORTING iv_titular TYPE string
                iv_saldo   TYPE i DEFAULT 0.

    METHODS ingresar      IMPORTING iv_importe TYPE i.
    METHODS retirar       IMPORTING iv_importe TYPE i
                          RETURNING VALUE(rv_ok) TYPE abap_boolean.
    METHODS obtener_saldo   RETURNING VALUE(rv_saldo)   TYPE i.
    METHODS obtener_titular RETURNING VALUE(rv_titular) TYPE string.


  PRIVATE SECTION.
   DATA titular TYPE string.
    DATA saldo   TYPE i.
ENDCLASS.



CLASS ZCL_CUENTA_SEGURA_17 IMPLEMENTATION.


  METHOD ingresar.
    IF iv_importe > 0.
      saldo = saldo + iv_importe.
    ENDIF.
  ENDMETHOD.


  METHOD obtener_saldo.
    rv_saldo = saldo.
  ENDMETHOD.


  METHOD obtener_titular.
    rv_titular = titular.

  ENDMETHOD.


  METHOD retirar.
    IF iv_importe > 0 AND iv_importe <= saldo.
      saldo = saldo - iv_importe.
      rv_ok = abap_true.
    ELSE.
      rv_ok = abap_false.
    ENDIF.
  ENDMETHOD.


 METHOD constructor.
    titular = iv_titular.
    saldo   = iv_saldo.
  ENDMETHOD.
ENDCLASS.
