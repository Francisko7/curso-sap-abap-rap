CLASS zcl_jugador_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_JUGADOR_TEST_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "acción 1. creamos el jugador1 y el jugador2
  DATA(jugador1) = NEW zcl_jugador_17(  ).
  DATA(jugador2) = NEW zcl_jugador_17(  ).

  " acción 2. jugador1->marcar( )
    DATA(lv_goles) = jugador1->marcar(  ).
    out->write( |jugador1->marca() ->{ lv_goles }| ).

    " acción 3. jugador1->marcar( )
    lv_goles = jugador1->marcar(  ).
    out->write( |jugador1->marca() ->{ lv_goles }| ).

   " acción 4. jugador2->marcar( ) -> Devuelve 1
   lv_goles = jugador2->marcar(  ).
    out->write( |jugador2->marca() ->{ lv_goles }| ).

    " 5. zcl_jugador=>obtener_goles_equipo( ) -> Devuelve 3 (sin instanciar ningún jugador nuevo)
    DATA(lv_goles_equipo) = zcl_jugador_17=>obtener_goles_equipo( ).
    out->write( |zcl_jugador=>obtener_goles_equipo( ) -> { lv_goles_equipo }| ).
  ENDMETHOD.
ENDCLASS.
