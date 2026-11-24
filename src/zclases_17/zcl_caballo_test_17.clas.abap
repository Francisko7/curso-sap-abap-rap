CLASS zcl_caballo_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CABALLO_TEST_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(caballo1) = NEW zcl_caballo_03( 'Paco' ).
    caballo1->avanzar( 30 ).

    out->write( caballo1->obtener_estado( ) ).

    DATA(caballo2) = NEW zcl_caballo_03( 'Francisco' ).
    caballo2->avanzar( 50 ).
    out->write( caballo2->obtener_estado( ) ).

    out->write( zcl_caballo_03=>obtener_ganador( ) ).
    DATA(caballo3) = NEW zcl_caballo_03( 'Rempalago' ).
    caballo3->avanzar( 60 ).
    out->write( caballo3->obtener_estado( ) ).

    caballo3->avanzar( 50 ).
    out->write( caballo3->obtener_estado( ) ).

    out->write( zcl_caballo_03=>obtener_ganador( ) ).



  ENDMETHOD.
ENDCLASS.
