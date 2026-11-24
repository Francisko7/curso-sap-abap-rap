CLASS zcl_triangulo_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_figura_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES zif_descriptible_17.

     METHODS constructor
      IMPORTING
        iv_base   TYPE ty_medida
        iv_altura TYPE ty_medida.

      METHODS calcular_area REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.

  DATA base   TYPE ty_medida.
    DATA altura TYPE ty_medida.
ENDCLASS.



CLASS zcl_triangulo_17 IMPLEMENTATION.

    METHOD constructor.
    super->constructor( ).
    base   = iv_base.
    altura = iv_altura.
  ENDMETHOD.

  METHOD calcular_area.
    rv_area = ( base * altura ) / 2.
  ENDMETHOD.

   METHOD zif_descriptible_17~describir.
    rv_texto = |Triángulo de base { base } y altura { altura } con área { calcular_area( ) }|.

  ENDMETHOD.
ENDCLASS.
