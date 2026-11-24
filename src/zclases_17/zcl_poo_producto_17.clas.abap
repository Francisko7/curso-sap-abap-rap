CLASS zcl_poo_producto_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_POO_PRODUCTO_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " 1. Instanciamos el objeto de la clase producto
    DATA(lo_producto) = NEW zcl_producto_17( ).

    " 2.  valores a los atributos
    lo_producto->nombre = 'Portatil Gaming'.
    lo_producto->precio = 1000.

    out->write( |Producto: { lo_producto->nombre }| ).
    out->write( |Precio original: { lo_producto->obtener_precio( ) } EUR| ).

    " 3. Aplicamos un descuento del 10%
    lo_producto->aplicar_descuento( 10 ).

    " 4. Mostramos el resultado
    out->write( |Precio con descuento: { lo_producto->obtener_precio( ) } EUR| ).

  ENDMETHOD.
ENDCLASS.
