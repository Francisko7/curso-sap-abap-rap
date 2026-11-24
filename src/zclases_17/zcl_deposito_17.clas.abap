CLASS zcl_deposito_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  " Atributos o propiedades
  DATA capacidad TYPE i.
  DATA litros TYPE i.


  " Metodos o acciones

  " Método llenar
    METHODS llenar IMPORTING iv_litros TYPE i.

  " Método vaciar
    METHODS vaciar IMPORTING iv_litros TYPE i.

   "Método devolver los litros actuales
    METHODS devolver RETURNING VALUE(rv_litros) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DEPOSITO_17 IMPLEMENTATION.


  METHOD llenar.
  " método llenar sumamos los litros actuales más los litros que queremos meter y lo igualamos a la capacidad
    if litros + iv_litros <= capacidad.
       litros = litros + iv_litros.
     ENDIF.
     ENDMETHOD.


  METHOD vaciar.
   " Método vaciar si hay litros
    IF iv_litros <= litros.
      litros = litros - iv_litros.
    ENDIF.
  ENDMETHOD.


   METHOD devolver.
    " Método devolver los litros que hay
     rv_litros = litros.
   ENDMETHOD.
ENDCLASS.
