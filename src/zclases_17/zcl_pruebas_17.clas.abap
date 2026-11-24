CLASS zcl_pruebas_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PRUEBAS_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "  DATA(lo_rectangulo1) = NEW ZCL_RECTANGULO_17( iv_ancho = 5 iv_alto = 3 ).



  "  out->write( |el rectangulo tiene area { lo_rectangulo1->calcular_area( ) }| ).
  " out->write( |el rectangulo tiene perimetro { lo_rectangulo1->calcular_perimetro(  ) }| ).
  " ENDMETHOD.
   DATA(cuenta) = NEW zcl_cuenta_segura_17( iv_titular = 'Ana' iv_saldo = 100 ).

    cuenta->ingresar( -50 ).     " negativo: se ignora
    cuenta->ingresar( 50 ).      " saldo 150

    DATA(lv_ok) = cuenta->retirar( 500 ).   " no hay saldo: devuelve falso
    IF lv_ok = abap_true.
      out->write( 'Retirada realizada' ).
    ELSE.
      out->write( 'Retirada rechazada' ).    " sale esto
    ENDIF.

    out->write( |{ cuenta->obtener_titular( ) }: { cuenta->obtener_saldo( ) }| ).
    " Ana: 150

    " Descomenta esta línea y mira qué pasa:
    " cuenta->saldo = 1000000.

  ENDMETHOD.
ENDCLASS.
