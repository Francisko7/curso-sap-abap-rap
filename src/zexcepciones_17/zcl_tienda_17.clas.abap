CLASS zcl_tienda_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   METHODS constructor.

   METHODS obtener_producto
       IMPORTING iv_posicion TYPE i
       RETURNING VALUE(rv_producto) TYPE striNg
       RAISING cx_sy_itab_line_not_found.


   METHODS calcular_precio_unidad
       IMPORTING
                  iv_total TYPE decfloat16
                  iv_unidades TYPE i

        RETURNING VALUE(rv_precio) TYPE decfloat16
        RAISING cx_sy_zerodivide.
  PROTECTED SECTION.
  PRIVATE SECTION.

  " Atributo interno, solo accesible dentro de ZCL_TIENDA
    DATA mt_catalogo TYPE string_table.
ENDCLASS.



CLASS ZCL_TIENDA_17 IMPLEMENTATION.


METHOD constructor.
    " Carga inicial de datos al instanciar el objeto
     mt_catalogo = VALUE #( ( `Portátil` ) ( `Ratón` ) ( `Teclado` ) ).
ENDMETHOD.


METHOD obtener_producto.

    rv_producto = mt_catalogo[ iv_posicion ].

ENDMETHOD.


METHOD calcular_precio_unidad.
     " si es 0 las unidades lanzamos la excepcion
     IF iv_unidades = 0.
        RAISE EXCEPTION TYPE cx_sy_zerodivide.
        ENDIF.

      rv_precio = iv_total / iv_unidades.

      ENDMETHOD.
ENDCLASS.
