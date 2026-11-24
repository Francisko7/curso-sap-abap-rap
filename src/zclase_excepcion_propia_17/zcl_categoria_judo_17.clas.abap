CLASS zcl_categoria_judo_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
  TYPES ty_peso TYPE p LENGTH 5 DECIMALS 1.

  METHODS constructor
            IMPORTING
             iv_limite  TYPE ty_peso.

  METHODS obtener_inscritos
             RETURNING VALUE(rv_inscritos) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

  " Paso 7: Atributos privado
    DATA mv_limite    TYPE ty_peso.
    DATA mv_inscritos TYPE i.
ENDCLASS.



CLASS ZCL_CATEGORIA_JUDO_17 IMPLEMENTATION.


   METHOD constructor.

   ENDMETHOD.


   METHOD obtener_inscritos.
         rv_inscritos = mv_inscritos.
   ENDMETHOD.
ENDCLASS.
