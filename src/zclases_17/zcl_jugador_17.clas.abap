CLASS zcl_jugador_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  " instancia que pertenece a cada jugador
  DATA goles TYPE i.
  "atributo de la clase compartido por todas las instancias
  CLASS-DATA goles_equipo TYPE i.

  " 3. Método de instancia: Se invoca con flecha simple -> sobre un jugador concreto
    METHODS marcar  RETURNING  VALUE(rv_goles) TYPE i.

   " 4. Método de clase: Se invoca con flecha doble => directamente sobre la clase
    CLASS-METHODS obtener_goles_equipo
      RETURNING
        VALUE(rv_goles) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_JUGADOR_17 IMPLEMENTATION.


   METHOD marcar.
    " Sumar 1 al gol del jugador actual
    goles = goles + 1.

    " Sumar 1 al total de goles del equipo
    goles_equipo = goles_equipo + 1.

    " Copiar los goles del jugador a la variable de retorno
    rv_goles = goles.
  ENDMETHOD.


  METHOD obtener_goles_equipo.
    " Devuelve el contador global del equipo
    rv_goles = goles_equipo.
  ENDMETHOD.
ENDCLASS.
