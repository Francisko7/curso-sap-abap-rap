CLASS zcl_libro_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_documento_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS constructor
    IMPORTING
      iv_titulo TYPE string
      iv_anio TYPE i
      iv_paginas TYPE i.

   METHODS es_extenso
     RETURNING VALUE(rv_extenso) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.

    " Atributo exclusivo
    DATA pagina TYPE i.
ENDCLASS.



CLASS ZCL_LIBRO_17 IMPLEMENTATION.


  METHOD constructor.
    super->constructor(
       iv_titulo = iv_titulo
       iv_anio = iv_anio
    ).
  ENDMETHOD.


  METHOD es_extenso.
     IF pagina >= 500.
      rv_extenso = abap_true.
      ELSE.
       rv_extenso = abap_false.
      ENDIF.

  ENDMETHOD.
ENDCLASS.
