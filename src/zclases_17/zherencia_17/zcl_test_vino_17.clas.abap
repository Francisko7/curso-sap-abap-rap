CLASS zcl_test_vino_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " interface obligatoria para ejecutar en consola
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_VINO_17 IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    " 1. Probamos al padre de forma independiente
    DATA(lo_vino_mesa) = NEW zcl_vino_17( iv_nombre = 'Vino de mesa' iv_crianza = 0 ).
    out->write( |Vino de mesa (padre solo)| ).
    out->write( |crianza 0| ).
    out->write( |obtener_descripcion| ).
    out->write( lo_vino_mesa->obtener_descripcion( ) ).
    out->write( |---------------------------| ).

    " 2. Probamos la hija seca (Fino)
    DATA(lo_fino) = NEW zcl_vino_seco_17( iv_nombre = 'Fino' iv_crianza = 4 ).
    out->write( |Fino (seco)| ).
    out->write( |crianza 4| ).
    out->write( |obtener_descripcion| ).
    out->write( lo_fino->obtener_descripcion( ) ). " ¡Llama al método heredado del padre!
    out->write( |Fino (seco)| ).
    out->write( |crianza 4| ).
    out->write( |servir_frio| ).
    out->write( lo_fino->servir_frio( ) ).
    out->write( |---------------------------| ).

    " 3. Probamos la hija seca (Amontillado)
    DATA(lo_amontillado) = NEW zcl_vino_seco_17( iv_nombre = 'Amontillado' iv_crianza = 12 ).
    out->write( |Amontillado (seco)| ).
    out->write( |crianza 12| ).
    out->write( |servir_frio| ).
    out->write( lo_amontillado->servir_frio( ) ).
    out->write( |---------------------------| ).



  ENDMETHOD.
ENDCLASS.
