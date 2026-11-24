CLASS zcl_documento_17 DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.

  " metodo constructor recibe titulo y año
  METHODS constructor
   IMPORTING
     iv_titulo TYPE string
     iv_anio TYPE i.

   METHODS obtener_ficha
    RETURNING VALUE(rv_ficha) TYPE string.

  PROTECTED SECTION.
  " atributos protegidos
  DATA titulo TYPE string.
  DATA anio TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DOCUMENTO_17 IMPLEMENTATION.


  METHOD constructor.
    titulo = iv_titulo.
    anio = iv_anio.
  ENDMETHOD.


  METHOD obtener_ficha.
    rv_ficha = |¨{ titulo } { anio }|.
  ENDMETHOD.
ENDCLASS.
