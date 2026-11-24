CLASS zcl_vino_dulce_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_vino_17 " hereda de vino
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   " Constructor recibe los datos del padre + el suyo propio
    METHODS constructor
      IMPORTING
        iv_nombre  TYPE string
        iv_crianza TYPE i
        iv_azucar  TYPE i.

    METHODS es_muy_dulce
      RETURNING VALUE(rv_dulce) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    " Atributo exclusivo de la hija que el padre no conoce
    DATA azucar TYPE i.
ENDCLASS.



CLASS ZCL_VINO_DULCE_17 IMPLEMENTATION.


   METHOD constructor.
    " 1. Llamada obligatoria al padre para que inicialice la herencia
    super->constructor(
      iv_nombre  = iv_nombre
      iv_crianza = iv_crianza
    ).

    " 2. Asignación del atributo exclusivo de esta clase
    me->azucar = iv_azucar.
  ENDMETHOD.


  METHOD es_muy_dulce.
    " Devuelve verdadero si el azúcar es 100 o mayor
    IF me->azucar >= 100.
      rv_dulce = abap_true.
    ELSE.
      rv_dulce = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
