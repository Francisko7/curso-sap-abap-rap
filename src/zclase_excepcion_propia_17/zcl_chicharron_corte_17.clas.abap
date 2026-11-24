CLASS zcl_chicharron_corte_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_productos_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  METHODS constructor
      IMPORTING
        iv_nombre TYPE string
        iv_precio TYPE ty_precio
        iv_stock  TYPE ty_peso.


   METHODS obtener_descripcion REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CHICHARRON_CORTE_17 IMPLEMENTATION.


METHOD constructor.
    super->constructor(
      iv_nombre = iv_nombre
      iv_precio = iv_precio
      iv_stock  = iv_stock
    ).
  ENDMETHOD.


METHOD obtener_descripcion.
    rv_desc = |{ me->nombre } al corte ({ me->precio } €/kg)|.
  ENDMETHOD.
ENDCLASS.
