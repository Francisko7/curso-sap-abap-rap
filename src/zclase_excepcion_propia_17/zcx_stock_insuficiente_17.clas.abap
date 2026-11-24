CLASS zcx_stock_insuficiente_17 DEFINITION
  PUBLIC
  INHERITING FROM zcx_chicharroneria_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES ty_kilos TYPE p LENGTH 6 DECIMALS 2.

    " datos de entrada solo lectura
    DATA:
         stock_disponible TYPE ty_kilos READ-ONLY,
         kilos_pedidos TYPE ty_kilos READ-ONLY.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !kilos_pedidos TYPE ty_kilos OPTIONAL
        !stock_disponible TYPE ty_kilos OPTIONAL.

  "  Redefinición para que el objeto redacte su propio mensaje
    METHODS if_message~get_text REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_STOCK_INSUFICIENTE_17 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    me->stock_disponible = stock_disponible.
    me->kilos_pedidos    = kilos_pedidos.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.


  METHOD if_message~get_text.
    " Mensaje claro que usa los dos datos
    result = |Stock insuficiente: pides { me->kilos_pedidos } kg y solo quedan { me->stock_disponible } kg.|.
  ENDMETHOD.
ENDCLASS.
