CLASS zexperis_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZEXPERIS_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*
**    primer ejercicio
*    DATA nota TYPE i.
*    DATA aprobado TYPE i.
*    DATA suspenso TYPE i.
*    DATA suma TYPE i.
*
*    nota = 0.
*    aprobado = 0.
*    suspenso = 0.
*
*    DO 10 TIMES.
*      suma = suma + 1.
*      IF nota >= 5.
*        aprobado = aprobado + 1.
*      ELSE.
*        suspenso = suspenso + 1.
*      ENDIF.
*    ENDDO.
*    out->write( aprobado ).
**    out->write( suspenso ).
*
*
**    segundo ejercicio
*
*    DATA hace_sol TYPE abap_bool.
*    DATA dia TYPE i.
*    dia = 0.
*
*
*
*    DO 7 TIMES.
*      dia = dia + 1.
*
*      CASE dia.
*        WHEN 1.
*          out->write( 'Pesas' ).
*        WHEN 2.
*          out->write( 'Cardio' ).
*        WHEN 3.
*          out->write( 'Pesas' ).
*        WHEN 4.
*          out->write( 'Cardio' ).
*        WHEN 5.
*          out->write( 'Pesas' ).
*        WHEN 6.
*          IF hace_sol = abap_true.
*            out->write( 'Cardio' ).
*          ELSE.
*            out->write( 'Excursión' ).
*
*            out->write( 'cine' ).
*          ENDIF.
*        WHEN 7.
*          out->write( 'descanso' ).
*
*      ENDCASE.
*
*    ENDDO.
*
**    tercer ejercicio
*
*    DATA butacas TYPE i.
*    DATA fila TYPE i.
*    DATA total TYPE i.

*    DO 4 TIMES.
*      fila += 1.
*
*      DO 5 TIMES.
*
*        CASE fila.
*          WHEN 1.
*            butacas  += 10.
*
*         WHEN OTHERS.
*            total += 12.
*        ENDCASE.
*      WHEN 2 OR
*           when 1 OR 5.
*       total += 1.

* ejercicio 4

*    DATA(botas) = 0.
*
*    WHILE botas < 5.
*      botas += 1.
*      out->write( botas ).
*    ENDWHILE.
*
*
*
** Ejercicio 1 WHILe
*
*    DATA contador TYPE i.
*
*    contador = 0.
*
*    WHILE contador <= 10.
*      out->write( contador ).
*      contador = contador + 1.
*      IF contador = 10.
*        out->write( 'Despegue' ).
*      ENDIF.
*    ENDWHILE.


* ejercicio 2 WHILe

*    DATA contador1 TYPE i.
*
*
*    WHILE contador1 <= 20.
*      contador1 = contador1 + 1.
*      IF ( contador1 MOD 3 ) = 0.
*        CONTINUE.
*      ELSE.
*        IF contador1 > 15.
*          EXIT.
*        ENDIF.
*      ENDIF.
*      out->write( contador1 ).
*
*    ENDWHILE.

*  ejercicio 3 WHILE

    DATA litros TYPE i.
    DATA dias TYPE i.

    litros = 500.
    dias = 1.


    DO.
      WHILE litros >= 100.
        IF dias MOD 7 = 0.
          out->write( 'no se saca vino es domingo' ).
          dias = dias + 1.
          CONTINUE.
        ELSE.
          litros = litros - 30.
          out->write( 'quedan {litros} litros' ).

         if litros > 100.
         out->write( 'quedan 100 litros' ).
         EXIT.
         ENDIF.
        ENDIF.
        dias = dias + 1.
        ENDWHILE.
      ENDDO.


    ENDMETHOD.
ENDCLASS.
