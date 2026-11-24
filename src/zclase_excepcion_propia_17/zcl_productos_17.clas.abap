CLASS zcl_productos_17 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_precio TYPE p LENGTH 8 DECIMALS 2,
           ty_peso   TYPE p LENGTH 6 DECIMALS 2.

    METHODS constructor
      IMPORTING
        iv_nombre TYPE string
        iv_precio TYPE ty_precio
        iv_stock  TYPE ty_peso.

    METHODS obtener_nombre
      RETURNING
        VALUE(rv_nombre) TYPE string.

    METHODS obtener_stock
      RETURNING
        VALUE(rv_stock) TYPE ty_peso.

    METHODS descontar_stock
      IMPORTING
        iv_kilos TYPE ty_peso.

    METHODS calcular_precio
      IMPORTING
        iv_peso          TYPE ty_peso
      RETURNING
        VALUE(rv_precio) TYPE ty_precio.

    METHODS obtener_descripcion
      RETURNING
        VALUE(rv_desc) TYPE string.

  PROTECTED SECTION.
    DATA nombre TYPE string.
    DATA precio TYPE ty_precio.

  PRIVATE SECTION.
    DATA stock TYPE ty_peso.

ENDCLASS.



CLASS ZCL_PRODUCTOS_17 IMPLEMENTATION.


  METHOD constructor.
    me->nombre = iv_nombre.
    me->precio = iv_precio.
    me->stock  = iv_stock.
  ENDMETHOD.


  METHOD obtener_stock.
    rv_stock = me->stock.
  ENDMETHOD.


  METHOD obtener_descripcion.
    rv_desc = |{ me->nombre } ({ me->precio } €/kg)|.
  ENDMETHOD.


  METHOD descontar_stock.
    me->stock = me->stock - iv_kilos.
  ENDMETHOD.


  METHOD obtener_nombre.
    rv_nombre = me->nombre.
  ENDMETHOD.


  METHOD calcular_precio.
    rv_precio = iv_peso * me->precio.
  ENDMETHOD.
ENDCLASS.
