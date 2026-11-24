CLASS zcl_cartel_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES zif_descriptible_17.

  METHODS constructor
      IMPORTING iv_texto TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.

  DATA texto TYPE string.
ENDCLASS.



CLASS zcl_cartel_17 IMPLEMENTATION.

   METHOD constructor.
   texto = iv_texto.
   ENDMETHOD.


   METHOD zif_descriptible_17~describir.
    rv_texto = |Cartel: { texto }|.
    ENDMETHOD.
ENDCLASS.
