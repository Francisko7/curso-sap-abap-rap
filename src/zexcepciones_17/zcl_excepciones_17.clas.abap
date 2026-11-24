CLASS zcl_excepciones_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EXCEPCIONES_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  " Paso 1: Declaramos el texto con un  número válido
  "  DATA lv_texto TYPE string VALUE 'hola'.
"
   " TRY.
        "  intento de conversión, está es la linea peligrosa que dice el enunciado
       " DATA(lv_numero) = CONV i( lv_texto ).

        " Si la conversión es buena
        "out->write( lv_numero ).

     " CATCH cx_sy_conversion_no_number.
        " Si da fallo la conversión,
      "  out->write( 'El valor introducido no es un número' ).

  "  ENDTRY.

    " Paso 3: Mostramos el número
   " out->write( |Resultado de la conversión: { lv_numero }| ).


 " ENDMETHOD.

" =======================================================================================================

  "  DATA lv_palabra TYPE string VALUE 'ABAP'.

    " declaramos y Probar cambiando este valor a 2 o a 10
  "  DATA lv_posicion TYPE i VALUE 1.

  "  TRY.
        " Línea e peligro
      "  DATA(lv_letra) = substring( val = lv_palabra off = lv_posicion len = 1 ).

      "  out->write( lv_letra ).

    "  CATCH cx_sy_range_out_of_bounds.
        " S no existe, se captura la excepcion
    "    out->write( 'Esa posición no existe en la palabra' ).

 "   ENDTRY.

 "    out->write( 'Fin del programa' ).


 " ===================================================================================================
 " paso 1 Variable de entrada

  DATA lv_fecha TYPE string VALUE '-5/12/2000'.


  " comprobamos la longitud exacta de  10

  IF strlen( lv_fecha ) <> 10.
  out->write( 'La fecha debe tener 10 caracteres' ).
      RETURN.
    ENDIF.


  " Fase 2, barras: comprueba que en la posición 2 y en la posición 5 (contando desde 0) hay una /
  IF substring( val = lv_fecha off = 2 len = 1 ) <> '/' OR
         substring( val = lv_fecha off = 5 len = 1 ) <> '/'.
         out->write( 'El formato debe ser DD/MM/AAAA' ).
      RETURN.
    ENDIF.


  " Fase 3 separar: corta el texto en tres variables de tipo texto
       " el dia va de l 0 al 2
    DATA(lv_dia_t)  = substring( val = lv_fecha off = 0 len = 2 ).
    DATA(lv_mes_t)  = substring( val = lv_fecha off = 3 len = 2 ).
    DATA(lv_anio_t) = substring( val = lv_fecha off = 6 len = 4 ).




  " Fase 4 onvertir: dentro de un TRY, convierte las tres variables a número entero con CONV

   " declaracion de las variables
    DATA lv_dia  TYPE i.
    DATA lv_mes  TYPE i.
    DATA lv_anio TYPE i.

    TRY.
        lv_dia  = CONV i( lv_dia_t ).
        lv_mes  = CONV i( lv_mes_t ).
        lv_anio = CONV i( lv_anio_t ).

        " si falla las conversiones anteriores nos saltamos a cx_sy_conversio

        " cogemo la excepcion y la guardamos en lx_error

      CATCH cx_sy_conversion_no_number INTO DATA(lx_error).
        out->write( |Error de conversión: { lx_error->get_text( ) }| ).
        RETURN.
    ENDTRY.


  " Fase 5 rangos: con IF, comprueba que el mes está entre 1 y 12, que el día está entre 1 y 31 y que el año está entre 1900 y 2100

  IF lv_mes < 1 or lv_mes > 12.
    out->write( 'Este mes no es valido debe de estar entre 1 y 12' ).

    ENDIF.

   IF lv_dia < 1 or lv_dia > 31.
     out->write( 'este dia es incorrecto debe de estar entre 1 y 31 ' ).

     ENDIF.

   IF lv_anio < 1900 or lv_anio > 2100.
     out->write( 'este año no es valido  debe de estar entre 1900 y 2100' ).
     ENDIF.


     " Fase 6 mostramos los resultados

     out->write( |Dia: { lv_dia }| ).
     out->write( |Mes: { lv_mes }| ).
     out->write( |Año: { lv_anio }| ).




  ENDMETHOD.
ENDCLASS.
