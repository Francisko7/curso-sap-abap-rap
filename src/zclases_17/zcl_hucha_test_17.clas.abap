CLASS zcl_hucha_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_HUCHA_TEST_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  " Creamos dos huchas distintas
    DATA(ana)  = NEW zcl_hucha_17( ).
    DATA(luis) = NEW zcl_hucha_17( ).

    " Cada uno ahorra lo suyo (flecha simple: hablamos con UN objeto)
    ana->ahorrar( 10 ).
    luis->ahorrar( 20 ).
    ana->ahorrar( 5 ).

    out->write( |Ana tiene { ana->obtener_ahorro( ) }| ).
    out->write( |Luis tiene { luis->obtener_ahorro( ) }| ).

    " Flecha doble: hablamos con la CLASE, sin necesidad de ningún objeto
    out->write( |Bote común: { zcl_hucha_17=>obtener_bote_comun( ) }| ).
  ENDMETHOD.
ENDCLASS.
