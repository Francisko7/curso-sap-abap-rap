CLASS zcl_producto_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES ty_precio TYPE p LENGTH 8 DECIMALS 2.


    DATA nombre TYPE string.
    DATA precio TYPE ty_precio.

      METHODS aplicar_descuento
      IMPORTING
        iv_porcentaje TYPE i.

      METHODS obtener_precio
      RETURNING
        VALUE(rv_precio) TYPE ty_precio.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PRODUCTO_17 IMPLEMENTATION.


    METHOD aplicar_descuento.
        precio = precio - ( precio * iv_porcentaje / 100 ).
     ENDMETHOD.


     METHOD obtener_precio.
     rv_precio = precio.
     ENDMETHOD.
ENDCLASS.
