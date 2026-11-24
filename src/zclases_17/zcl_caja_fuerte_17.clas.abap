CLASS zcl_caja_fuerte_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  " Constructor de la caja fuerte empezamos con la caja fuerte con un pin secreto y 0 intentos
  METHODS constructor IMPORTING iv_pin TYPE i.


  " Método para abrir la caja
  METHODS abrir IMPORTING iv_pin TYPE i RETURNING VALUE(rv_ok) TYPE abap_bool.


  " Método para saber cuantos intentos fallados llevamos
  METHODS esta_bloqueada RETURNING VALUE(rv_bloqueada) TYPE i.

  " método para consultar los intentos
  METHODS obtener_intentos_fallidos RETURNING VALUE(rv_intentos) TYPE i.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

  " sección private los atributos protegidos
  DATA pin TYPE i.
  DATA intentos_fallidos TYPE i.
ENDCLASS.



CLASS ZCL_CAJA_FUERTE_17 IMPLEMENTATION.


  METHOD constructor.
   pin = iv_pin.
   intentos_fallidos = 0.
   ENDMETHOD.


   METHOD esta_bloqueada.
       if intentos_fallidos >= 3.
         rv_bloqueada = abap_true.
        else.
          rv_bloqueada = abap_false.
          ENDIF.
   ENDMETHOD.


   METHOD abrir.
      IF esta_bloqueada( ) = abap_true. " primero preguntar si esta bloqueada
      rv_ok = abap_false.  " asignamos false a la variable para indicar que es denegada
      RETURN.
      ENDIF.

      " si no está bloqueada comparamos el pin introducido
      IF iv_pin = pin. " pin insertado por el usuario
         intentos_fallidos = 0.
         rv_ok = abap_true.
         ELSE.
          intentos_fallidos = intentos_fallidos + 1.
          rv_ok = abap_false.

          ENDIF.
       ENDMETHOD.


          METHOD  obtener_intentos_fallidos.
          rv_intentos = intentos_fallidos.

   ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.
ENDCLASS.
