CLASS zcx_peso_excedido_17 DEFINITION
  PUBLIC
  " hereda porque al pasarse de peso es un fallo previsible
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   TYPES ty_peso TYPE p LENGTH 5 DECIMALS 1.

  " datos solo lectua
  DATA:
         mv_peso   TYPE ty_peso READ-ONLY,
         mv_limite TYPE ty_peso READ-ONLY.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .


    METHODS constructor
      IMPORTING
        !textid    LIKE if_t100_message=>t100key OPTIONAL
        !previous  LIKE previous OPTIONAL
        !iv_peso   TYPE ty_peso OPTIONAL
        !iv_limite TYPE ty_peso OPTIONAL.

    METHODS if_message~get_text REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_PESO_EXCEDIDO_17 IMPLEMENTATION.


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
  ENDMETHOD.


  METHOD if_message~get_text.
    " Devolvemos la frase con los atributos de la excepción
    result = |Peso { me->mv_peso } kg: supera el límite de { me->mv_limite } kg|.
  ENDMETHOD.
ENDCLASS.
