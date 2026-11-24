CLASS zcl_tienda_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TIENDA_TEST_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA(lo_tienda) = NEW zcl_tienda_17( ).

    " 1. Producto válido (Posición 2)
    DATA(lv_prod) = lo_tienda->obtener_producto( 2 ).
    out->write( |Producto posición 2: { lv_prod }| ).

    " 2. Cálculo válido (100 entre 4)
    DATA(lv_precio) = lo_tienda->calcular_precio_unidad( iv_total = 100 iv_unidades = 4 ).
    out->write( |Precio por unidad: { lv_precio }| ).



    " PASO 9
    " lo_tienda->obtener_producto( 10 ).------> Exception   CX_SY_ITAB_LINE_NOT_FOUND






   " PASO 10
    TRY.
        "  probamos posición 10:
        DATA(lv_p) = lo_tienda->obtener_producto( 10 ).
        out->write( lv_p ).



      CATCH cx_sy_itab_line_not_found.
        out->write( 'Error: El producto solicitado no existe en el catálogo.' ).

    ENDTRY.


    TRY.
          "  probamos división por 0:
        DATA(lv_pr) = lo_tienda->calcular_precio_unidad( iv_total = 100 iv_unidades = 0 ).
        out->write( lv_pr ).

        CATCH cx_sy_zerodivide.
        out->write( 'Error: El número de unidades no puede ser cero.' ).

      ENDTRY.



  " PASO 11  CATCH con cx_root.
      TRY.

         DATA(lv_p2) = lo_tienda->obtener_producto( 14 ).
        out->write( lv_p2 ).

       CATCH cx_root INTO DATA(lx_error).
        out->write( |Error inesperado: { lx_error->get_text( ) }| ).


      ENDTRY.

  ENDMETHOD.
ENDCLASS.
