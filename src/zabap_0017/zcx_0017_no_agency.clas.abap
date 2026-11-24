CLASS zcx_0017_no_agency DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    " QUÉ: mensaje ZC_ABAPD/002, cuyo &1 se rellena con el atributo AGENCY_ID
    " POR QUÉ: así el texto de error muestra la agencia que no se encontró
    " SI FALLA: si &1 sale vacío → attr1 en MAYÚSCULAS y igual que el nombre del atributo
    CONSTANTS:
      BEGIN OF no_agency,
        msgid TYPE symsgid VALUE 'ZC_ABAPD',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'AGENCY_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_agency.

    DATA agency_id TYPE /dmo/agency_id READ-ONLY.

    METHODS constructor
      IMPORTING
        textid    LIKE if_t100_message=>t100key OPTIONAL
        previous  LIKE previous OPTIONAL
        agency_id TYPE /dmo/agency_id OPTIONAL.
ENDCLASS.

CLASS zcx_0017_no_agency IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    " QUÉ: guarda la agencia recibida y fija el mensaje T100
    " POR QUÉ: sin me->agency_id = agency_id el placeholder &1 queda vacío
    " SI FALLA: error en super->constructor → comprueba que la superclase es CX_STATIC_CHECK
    super->constructor( previous = previous ).
    me->agency_id = agency_id.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
