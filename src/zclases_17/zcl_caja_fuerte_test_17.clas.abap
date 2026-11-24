CLASS zcl_caja_fuerte_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CAJA_FUERTE_TEST_17 IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

    " Instanciamos la caja fuerte
    DATA(caja) = NEW zcl_caja_fuerte_17( iv_pin = 1234 ).


    " intento 1
    DATA(lv_ok) = caja->abrir( 1111 ).
    IF lv_ok = abap_true.
      out->write( |Intento 1 (1111): Abierta| ).
    ELSE.
      out->write( |Intento 1 (1111): Cerrada (Intentos fallidos: { caja->obtener_intentos_fallidos( ) })| ).
    ENDIF.

 ENDMETHOD.
ENDCLASS.
