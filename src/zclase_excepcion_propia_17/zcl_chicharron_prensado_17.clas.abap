CLASS zcl_chicharron_prensado_17 DEFINITION
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
    METHODS calcular_precio REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CHICHARRON_PRENSADO_17 IMPLEMENTATION.


METHOD constructor.
    super->constructor(
      iv_nombre = iv_nombre
      iv_precio = iv_precio
      iv_stock  = iv_stock
    ).
  ENDMETHOD.


  METHOD obtener_descripcion.
    rv_desc = |{ me->nombre } prensado ({ me->precio } €/kg)|.
  ENDMETHOD.


  METHOD calcular_precio.
    DATA(lv_precio_base) = super->calcular_precio( iv_peso ).

    " Si se pide 1 kg o más se aplica el 10 % de descuento (pago del 90 %)
    IF iv_peso >= 1.
      rv_precio = lv_precio_base * '0.90'.
    ELSE.
      rv_precio = lv_precio_base.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
