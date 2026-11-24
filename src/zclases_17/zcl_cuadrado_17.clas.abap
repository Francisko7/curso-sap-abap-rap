CLASS zcl_cuadrado_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_figura_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_lado TYPE ty_medida.

      METHODS calcular_area REDEFINITION.

       INTERFACES zif_descriptible_17.
  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA lado TYPE ty_medida.
ENDCLASS.



CLASS zcl_cuadrado_17 IMPLEMENTATION.

    METHOD constructor.
    super->constructor( ).
    lado = iv_lado.
  ENDMETHOD.

  METHOD calcular_area.
    rv_area = lado * lado.
  ENDMETHOD.

  METHOD zif_descriptible_17~describir.
    rv_texto = |Cuadrado de lado { lado } con área { calcular_area( ) }|.

  ENDMETHOD.
ENDCLASS.
