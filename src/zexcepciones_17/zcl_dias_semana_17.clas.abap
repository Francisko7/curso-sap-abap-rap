CLASS zcl_dias_semana_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
 "   Paso 2: Definimos el método obtener_nombre
    METHODS obtener_nombre
      " parametro de entrada
      IMPORTING
        iv_numero        TYPE i
        "parametro de retorno
      RETURNING
        VALUE(rv_nombre) TYPE string
        " declaración de raising
      RAISING
        cx_sy_range_out_of_bounds.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DIAS_SEMANA_17 IMPLEMENTATION.


METHOD obtener_nombre.
  IF iv_numero < 1 OR iv_numero > 7.
    " si esta fuera del rango dispara la excepción
      RAISE EXCEPTION TYPE cx_sy_range_out_of_bounds.
    ENDIF.

    " Paso 4:  número a nombre de día
    CASE iv_numero.
      WHEN 1.
        rv_nombre = 'Lunes'.
      WHEN 2.
        rv_nombre = 'Martes'.
      WHEN 3.
        rv_nombre = 'Miércoles'.
      WHEN 4.
        rv_nombre = 'Jueves'.
      WHEN 5.
        rv_nombre = 'Viernes'.
      WHEN 6.
        rv_nombre = 'Sábado'.
      WHEN 7.
        rv_nombre = 'Domingo'.
    ENDCASE.

    ENDMETHOD.
ENDCLASS.
