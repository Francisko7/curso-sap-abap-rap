CLASS zcx_importe_invalido_17 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA mv_motivo TYPE string READ-ONLY.

    " Se tipa previous con TYPE REF TO cx_root
    METHODS constructor
      IMPORTING
        !previous  TYPE REF TO cx_root OPTIONAL
        !iv_motivo TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_IMPORTE_INVALIDO_17 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    " 1. Delegamos en el constructor de cx_static_check pasando el previous tipado
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    " 2. Guardamos el motivo en el atributo de instancia
    me->mv_motivo = iv_motivo.
  ENDMETHOD.
ENDCLASS.
