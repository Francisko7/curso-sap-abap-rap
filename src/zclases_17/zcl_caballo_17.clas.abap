CLASS zcl_caballo_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING iv_nombre TYPE string.
    METHODS avanzar
      IMPORTING iv_metros TYPE i.

    METHODS obtener_estado
      RETURNING VALUE(texto) TYPE string.

    CONSTANTS c_meta TYPE i VALUE 100.

    CLASS-METHODS obtener_ganador
      RETURNING VALUE(nombre_ganador) TYPE string.

    CLASS-METHODS obtener_inscritos
      RETURNING VALUE(iv_inscritos) TYPE i.

    CLASS-METHODS nueva_carrera.
  PROTECTED SECTION.


  PRIVATE SECTION.
    DATA nombre TYPE string.
    DATA metros TYPE i.
    CLASS-DATA inscritos TYPE i.
    CLASS-DATA ganador   TYPE string.
ENDCLASS.



CLASS ZCL_CABALLO_17 IMPLEMENTATION.


  METHOD avanzar.
    metros = metros + iv_metros.

    IF metros >= c_meta AND ganador IS INITIAL.
      ganador = nombre.
    ENDIF.
  ENDMETHOD.


  METHOD nueva_carrera.
    CLEAR ganador.
    inscritos = 0.
  ENDMETHOD.


  METHOD obtener_estado.
    texto = |{ nombre }: { metros }|.
  ENDMETHOD.


  METHOD obtener_ganador.
    IF ganador IS NOT INITIAL.
      nombre_ganador = ganador.
      " Hay ganador: se reinicia la carrera
      nueva_carrera( ).
    ELSE.
      nombre_ganador = 'Todavía no hay ganador'.
    ENDIF.
  ENDMETHOD.


  METHOD obtener_inscritos.
    iv_inscritos = inscritos.
  ENDMETHOD.


  METHOD constructor.
    nombre = iv_nombre.
    inscritos = inscritos + 1.
  ENDMETHOD.
ENDCLASS.
