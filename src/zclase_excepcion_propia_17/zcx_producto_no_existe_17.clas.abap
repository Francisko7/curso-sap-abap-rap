CLASS zcx_producto_no_existe_17 DEFINITION
  PUBLIC
  INHERITING FROM zcx_chicharroneria_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  DATA nombre_buscado TYPE string READ-ONLY.

  METHODS constructor
              IMPORTING
                      !previous       TYPE REF TO cx_root OPTIONAL
                      !nombre_buscado TYPE string OPTIONAL.
  METHODS if_message~get_text REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_PRODUCTO_NO_EXISTE_17 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->nombre_buscado = nombre_buscado.
  ENDMETHOD.


  METHOD if_message~get_text.
    result = |El producto '{ me->nombre_buscado }' no existe en el catálogo.|.
  ENDMETHOD.
ENDCLASS.
