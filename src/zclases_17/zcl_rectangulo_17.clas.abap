CLASS zcl_rectangulo_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  " atributos
  DATA ancho TYPE i.
  DATA alto TYPE i.

  METHODS constructor
     IMPORTING
         iv_ancho TYPE i
         iv_alto  TYPE i.

   METHODS calcular_area RETURNING VALUE(rv_area) TYPE i.

   METHODS calcular_perimetro RETURNING VALUE(rv_perimetro) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RECTANGULO_17 IMPLEMENTATION.


  METHOD calcular_perimetro.
      rv_perimetro = 2 * ( ancho + alto ).

    ENDMETHOD.


METHOD constructor.
  ancho = iv_ancho.
  alto = iv_alto.
  ENDMETHOD.


 METHOD calcular_area .
    rv_area = ancho * alto.
    ENDMETHOD.
ENDCLASS.
