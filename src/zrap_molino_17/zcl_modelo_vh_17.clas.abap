CLASS zcl_modelo_vh_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
ENDCLASS.



CLASS ZCL_MODELO_VH_17 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA lt_modelos TYPE STANDARD TABLE OF zi_modelo_vh_17.

    lt_modelos = VALUE #(
      ( Codigo = 'V150'  Descripcion = 'Vestas V150 (4.2 MW)' )
      ( Codigo = 'SG145' Descripcion = 'Siemens Gamesa SG 5.0-145' )
      ( Codigo = 'N163'  Descripcion = 'Nordex N163 (5.X)' )
      ( Codigo = 'GE158' Descripcion = 'GE Cypress 158' )
    ).

    " Leer paginación, ordenación y filtros de OData V4
    DATA(lo_paging) = io_request->get_paging( ).
    DATA(lv_top)    = lo_paging->get_page_size( ).
    DATA(lv_skip)   = lo_paging->get_offset( ).
    DATA(lt_sort)   = io_request->get_sort_elements( ).
    TRY.
        DATA(lt_filter) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
    ENDTRY.

    IF lv_skip IS NOT INITIAL.
      CLEAR lt_modelos.
    ENDIF.

    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( lt_modelos ) ).
    ENDIF.

    IF io_request->is_data_requested( ).
      io_response->set_data( lt_modelos ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
