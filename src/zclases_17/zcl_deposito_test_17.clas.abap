CLASS zcl_deposito_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " Interfaz necesaria para ejecutar
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DEPOSITO_TEST_17 IMPLEMENTATION.


   METHOD if_oo_adt_classrun~main.



    " 1. Depósito de capacidad 100 (empieza vacío en 0)
    " Instanciamos con NEW
    DATA(lo_deposito) = NEW zcl_deposito_17( ).

    " atributos
    lo_deposito->capacidad = 100.
    lo_deposito->litros    = 0.
    out->write( |1. Depósito creado (Capacidad: { lo_deposito->capacidad } L, Inicio: { lo_deposito->devolver( ) } L)| ).

    " utilizamos los métodos
    " 2. llenamos 60 litros entran porque 60<100
    lo_deposito->llenar( 60 ).
    out->write( |2. Llenamos 60 L -> Litros actuales: { lo_deposito->devolver( ) } L| ).


    " 3. vaciamos 20 litros, se puede porque 20 < 60.
    lo_deposito->vaciar( 20 ).
    out->write( |3. Vaciamos 20 L -> Litros actuales: { lo_deposito->devolver( ) } L| ).


    " 4.mostramos los litros debe de mostrar 40
    out->write( |4. Comprobación del enunciado: { lo_deposito->devolver( ) } L (Debe ser 40)| ).

    " 5.intentamos llenar con 80
    lo_deposito->llenar( 80 ).
    out->write( |5. Intentamos llenar 80 L (no caben) -> Litros actuales: { lo_deposito->devolver( ) } L| ).

    ENDMETHOD.
ENDCLASS.
