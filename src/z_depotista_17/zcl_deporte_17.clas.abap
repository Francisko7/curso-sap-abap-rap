CLASS zcl_deporte_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DEPORTE_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_usuarios TYPE STANDARD TABLE OF zdeporte_db.

    lt_usuarios = VALUE #(
      ( id_usuario = '1'  nombre = 'Lucía' deporte = 'Pádel' edad = 14 puntos = 120 federado = 'X' )
      ( id_usuario = '2'  nombre = 'Pablo' deporte = 'Fútbol' edad = 9 puntos = 120 federado = 'X' )
      ( id_usuario = '3'  nombre = 'Marta' deporte = 'Baloncesto' edad = 16 puntos = 120 federado = 'X' )
      ( id_usuario = '4'  nombre = 'Carlos' deporte = 'Fútbol' edad = 22 puntos = 120 federado = '0' )
      ( id_usuario = '5'  nombre = 'Rocío' deporte = 'Pádel' edad = 11 puntos = 120 federado = '0' )
      ( id_usuario = '6'  nombre = 'Antonio' deporte = 'Baloncesto' edad = 35 puntos = 120 federado = 'X' )
      ( id_usuario = '7'  nombre = 'Inma' deporte = 'Natación' edad = 12 puntos = 120 federado = 'X' )
      ( id_usuario = '8'  nombre = 'Jesús' deporte = 'Fútbol' edad = 17 puntos = 120 federado = '0' )


     ).


    " APARTADO 1

    " Guarda el marcador de un partido: Los Halcones 4 goles,
    " Los Delfines 2. Muestra el resultado y la diferencia de goles.

    DATA: lv_equipo_local     TYPE string VALUE 'Los Halcones',
          lv_equipo_visitante TYPE string VALUE 'Los Delfines',
          lv_goles_locales    TYPE i VALUE 4,
          lv_goles_visitantes TYPE i VALUE 2.

    " diferencia de goles
    DATA(lv_diferencia_goles) = lv_goles_locales - lv_goles_visitantes.

    out->write( |El resultado del partido es { lv_equipo_local }: { lv_goles_locales } - { lv_equipo_visitante }: { lv_goles_visitantes }| ).
    out->write( |Y la diferencia de goles es { lv_diferencia_goles }| ).


    " Lucía ha jugado 6 partidos y ha sumado 120 puntos. Calcula y muestra su media de puntos por partido.
    DATA: lv_partidos TYPE i VALUE 6,
          lv_puntos   TYPE i VALUE 120.

    " calculamos la media
    DATA(lv_media_puntos) = lv_puntos / lv_partidos.

    out->write( |La media de puntos por partido es { lv_media_puntos }| ).


    " La cuota mensual del club es de 25 €. Calcula cuánto paga un socio al año.

    DATA : lv_cuota TYPE i VALUE 25,
           lv_meses TYPE i VALUE 12.

    " calculamos el precio al año

    DATA(lv_cuota_anual) = lv_cuota * lv_meses.

    out->write( |La cuota anual es de { lv_cuota_anual }| ).



    " Apartado 2: ¿En qué categoría juegas?

    " Dada una edad, muestra su categoría:
    " hasta 7 años: Prebenjamín
    " 8 y 9: Benjamín
    " 10 y 11: Alevín
    " 12 y 13: Infantil
    " 14 y 15: Cadete
    " 16 a 18: Juvenil
    " 19 o más: Senior


    DATA lv_edad TYPE i VALUE 22.
    DATA lv_categoria TYPE string.


    IF lv_edad <= 7.
      lv_categoria = 'Prebenjamin' .
    ELSEIF lv_edad  <= 9 .
      lv_categoria =  'Benjamin'.
    ELSEIF lv_edad  <= 11.
      lv_categoria =  'Alevin' .
    ELSEIF lv_edad  <= 13.
      lv_categoria = 'Infantil' .
    ELSEIF lv_edad  <= 15.
      lv_categoria =  'Cadete' .
    ELSEIF lv_edad  <= 18.
      lv_categoria =  'Juvenil' .
    ELSEIF lv_edad > 18.
      lv_categoria =  'Senior' .

    ENDIF.


    out->write( |Si tienes { lv_edad } tu categria es { lv_categoria }| ).


    " Calcula la cuota de un socio con una variable de edad y otra de "federado" (verdadero o falso):
    " federado y menor de 18: 15 €
    " federado y adulto: 25 €
    " no federado: 30 €

    DATA : lv_edad_prueba TYPE i VALUE 19,
           lv_federado    TYPE c VALUE 'X',
           lv_precio      TYPE i VALUE 0.

    IF lv_federado = 'X' AND lv_edad_prueba < 18.
      lv_precio = 15.
    ELSEIF lv_federado = 'X'.
      lv_precio = 25.
    ELSE.
      lv_precio = 30.

    ENDIF.

    out->write( |EL precio de la cuota es: { lv_precio }| ).


    " según el nombre del deporte, muestra cuántos jugadores forman equipo y qué material hace falta:

    " Fútbol: 11 jugadores, balón
    " Baloncesto: 5 jugadores, balón y canasta
    " Pádel: 2 jugadores, pala y pelotas
    " Natación: 1 jugador, gorro y gafas
    " Cualquier otro: mensaje de "deporte no reconocido"


    " declaramos una variable para el deporte

    DATA lv_deporte TYPE string VALUE 'Pádel'.

    CASE lv_deporte.
      WHEN 'Fútbol'.
        out->write( 'Fútbol: 11 jugadores, balón' ).

      WHEN 'Baloncesto'.
        out->write( 'Baloncesto: 5 jugadores, balón y canasta' ).

      WHEN 'Pádel'.
        out->write( 'Pádel: 2 jugadores, pala y pelotas' ).

      WHEN 'Natación'.
        out->write( 'Natación: 1 jugador, gorro y gafas' ).

      WHEN OTHERS.
        out->write( 'deporte no reconocido' ).

    ENDCASE.

    " APARTADO 4

    " variables
    DATA: lv_vueltas TYPE i VALUE 0,
          lv_metros  TYPE i VALUE 0.


    DO 6 TIMES.
      lv_vueltas = lv_vueltas + 1.
      lv_metros = lv_metros + 400.

      out->write( |llevamos { lv_vueltas } vueltas y { lv_metros } metros| ).

    ENDDO.

    " apartado 4 B
    DATA: lv_vueltas_b TYPE i VALUE 0,
          lv_metros_b  TYPE i VALUE 0.

    WHILE lv_vueltas_b < 8.
      lv_vueltas_b = lv_vueltas_b + 1.

      IF lv_vueltas_b = 5.
        CONTINUE.
      ENDIF.
      lv_metros_b = lv_metros_b + 400.

    ENDWHILE.

    out->write( |El número de vuelta es { lv_vueltas_b } y el número de metros es { lv_metros_b }| ).


    " APARTADO C
    DATA: lv_vueltas_c TYPE i VALUE 0,
          lv_metros_c  TYPE i VALUE 0.


    WHILE lv_vueltas_c < 10.

      lv_vueltas_c = lv_vueltas_c + 1.

      IF lv_vueltas_c = 7.
        lv_vueltas_c = lv_vueltas_c - 1.
        EXIT.

      ENDIF.

      lv_metros_c = lv_metros_c + 400.

    ENDWHILE.


    out->write( | Completo { lv_vueltas_c } vueltas y { lv_metros_c } metros| ).



    " APARTADO 5

    "  El molde de la ficha
    TYPES: BEGIN OF ty_deportista,
             nombre  TYPE string,
             deporte TYPE string,
             edad    TYPE i,
             puntos  TYPE i,
           END OF ty_deportista.


    " creamos la ficha

    DATA ls_deportista TYPE ty_deportista.

    " rellenamos con lucia
    ls_deportista = VALUE #(
        nombre  = 'Lucía'
        deporte = 'Pádel'
        edad    = 14
        puntos  = 120
      ).


      " mostramso la ficha
      out->write( ls_deportista ).













  ENDMETHOD.
ENDCLASS.
