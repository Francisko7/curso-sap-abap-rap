CLASS zcl_cuenta_exc_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_decimal TYPE p LENGTH 10 DECIMALS 2.

    DATA titular TYPE string.

    METHODS constructor IMPORTING
                          iv_titular TYPE string
                          iv_saldo   TYPE ty_decimal.

    METHODS ingresar      IMPORTING iv_importe TYPE ty_decimal.
    METHODS retirar       IMPORTING iv_importe TYPE ty_decimal
                          RAISING   "  zcx_saldo_insuficiente_17.
                                       zcx_importe_invalido_17.
    METHODS obtener_saldo RETURNING VALUE(rv_saldo) TYPE ty_decimal.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA saldo   TYPE ty_decimal.
ENDCLASS.



CLASS ZCL_CUENTA_EXC_17 IMPLEMENTATION.


  METHOD constructor.
    titular = iv_titular.
    saldo = iv_saldo.
  ENDMETHOD.


  METHOD ingresar.
    saldo = saldo + iv_importe.
  ENDMETHOD.


 METHOD retirar.

    " 1. Guardia de validación: Importe no positivo
    IF iv_importe <= 0.
      RAISE EXCEPTION NEW zcx_importe_invalido_17(
        iv_motivo = 'El importe a retirar debe ser estrictamente mayor que cero.'
      ).
    ENDIF.

    " 2. Guardia de saldo: Saldo insuficiente
   " IF iv_importe > saldo.
    "  RAISE EXCEPTION NEW zcx_saldo_insuficiente_17(
      "  iv_importe = iv_importe
       "iv_saldo   = saldo
    "  ).
   " ENDIF.

    " 3. Si todo es correcto, descontamos el saldo
    saldo = saldo - iv_importe.

  ENDMETHOD.


  METHOD obtener_saldo.
    rv_saldo = saldo.
  ENDMETHOD.
ENDCLASS.
