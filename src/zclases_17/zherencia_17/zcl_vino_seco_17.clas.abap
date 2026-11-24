CLASS zcl_vino_seco_17 DEFINITION
  PUBLIC
  INHERITING FROM zcl_vino_17
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   " Constructor recibe los mismos datos
    METHODS constructor
      IMPORTING
        iv_nombre  TYPE string
        iv_crianza TYPE i.

    METHODS servir_frio
      RETURNING VALUE(rv_servir) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VINO_SECO_17 IMPLEMENTATION.


 METHOD constructor.
    " Llamamos al padre
    super->constructor(
      iv_nombre  = iv_nombre
      iv_crianza = iv_crianza
    ).
  ENDMETHOD.


  METHOD servir_frio.
    " Accedemos directamente a los atributos protegidos heredados
    IF me->crianza < 5.
      rv_servir = |{ me->nombre }: sírvelo a 7 grados|.
    ELSE.
      rv_servir = |{ me->nombre }: sírvelo a 12 grados|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
