CLASS zcx_mil_error_17 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  " catalogo de errores
  CONSTANTS:
      gc_campo_obligatorio   TYPE string VALUE 'E001',
      gc_clave_duplicada     TYPE string VALUE 'E002',
      gc_no_existe           TYPE string VALUE 'E003',
      gc_valor_no_permitido  TYPE string VALUE 'E004',
      gc_fecha_futura        TYPE string VALUE 'E005',
      gc_importe_invalido    TYPE string VALUE 'E006',
      gc_unidad_no_disponible TYPE string VALUE 'E007',
      gc_unidad_llena        TYPE string VALUE 'E008',
      gc_unidad_con_efectivos TYPE string VALUE 'E009',
      gc_efectivo_en_mision  TYPE string VALUE 'E010'.



   " atributos publicos
    DATA mv_codigo TYPE string READ-ONLY.
    DATA mv_texto  TYPE string READ-ONLY.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !iv_codigo TYPE string OPTIONAL
        !iv_texto  TYPE string OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_MIL_ERROR_17 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    mv_codigo = iv_codigo.
    mv_texto  = iv_texto.
  ENDMETHOD.
ENDCLASS.
