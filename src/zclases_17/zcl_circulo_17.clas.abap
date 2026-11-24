CLASS zcl_circulo_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_figura_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_descriptible_17.

    METHODS constructor IMPORTING iv_radio TYPE ty_medida.
    METHODS calcular_area REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA radio TYPE ty_medida.
ENDCLASS.



CLASS zcl_circulo_17 IMPLEMENTATION.

   METHOD constructor.
    super->constructor( ).
    me->radio = iv_radio.
  ENDMETHOD.

  METHOD calcular_area.
    rv_area = radio * radio * '3.14'.
  ENDMETHOD.


  METHOD zif_descriptible_17~describir.
  rv_texto = |Círculo de radio { radio } con área { calcular_area( ) }|.
  ENDMETHOD.
ENDCLASS.
