CLASS zcl_test_dias_semana_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_DIAS_SEMANA_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " creamos una instancia de la clase
  DATA(lo_semana) = NEW zcl_dias_semana_17( ).

  " Prueba 1: Llamada válida con el día 1
    TRY.
        " Llama al método con 1 y guarda el día ('Lunes')
        DATA(lv_dia1) = lo_semana->obtener_nombre( 1 ).
        out->write( |Día 1: { lv_dia1 }| ).
      CATCH cx_sy_range_out_of_bounds.
        out->write( 'El número de día no es válido' ).
    ENDTRY.


    " Prueba 2: Llamada válida con el día 7
    TRY.
        DATA(lv_dia7) = lo_semana->obtener_nombre( 7 ).
        out->write( |Día 7: { lv_dia7 }| ).
      CATCH cx_sy_range_out_of_bounds.
        out->write( 'El número de día no es válido' ).
    ENDTRY.


    " Prueba 3: llamada fuera de rango con el número 9
    TRY.
      DATA(lv_dia9) = lo_semana->obtener_nombre( 9 ).
      out->write( |Dia 9: { lv_dia9 }| ).
      CATCH cx_sy_range_out_of_bounds.
        out->write( 'El número de día no es válido' ).
    ENDTRY.
   " Prueba 4: llamda de rango con el 0
  ENDMETHOD.
ENDCLASS.
