CLASS zcl_test_exc_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_EXC_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Crea una cuenta con 100, retira 30 y muestra el saldo. Debe salir 70,00.
    DATA(lo_cuenta) = NEW zcl_cuenta_exc_00( iv_titular = 'LuisCa'
                                             iv_saldo = 100 ).

    TRY.
        lo_cuenta->retirar( iv_importe = 30 ).
        out->write( lo_cuenta->obtener_saldo(  ) ).
        lo_cuenta->retirar( iv_importe = -500 ).
        out->write( lo_cuenta->obtener_saldo(  ) ).
      CATCH zcx_saldo_insuficiente_00 INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
