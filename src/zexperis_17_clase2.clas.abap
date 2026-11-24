CLASS zexperis_17_clase2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZEXPERIS_17_CLASE2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*    " Ejercicio 1
*    TYPES:BEGIN OF ty_producto,
*            codigo     TYPE i,
*            nombre     TYPE string,
*            precio     TYPE i,
*            disponible TYPE abap_bool,
*          END OF ty_producto.
*
*
*    DATA ls_producto1 TYPE ty_producto.
*    ls_producto1-codigo = 12.
*    ls_producto1-nombre = 'zapatillas'.
*    ls_producto1-precio = 45.
*    ls_producto1-disponible = abap_true.
*
*    " rellear con value
*    DATA(ls_producto2) = VALUE ty_producto(
*       codigo = 14 nombre = 'vaso' precio = 10 disponible = abap_false
*     ).
*
*
*    out->write( ls_producto1 ).
*    out->write( ls_producto2 ).


    " ejercicio 2
    "estructura ty_articulos
*    TYPES: BEGIN OF ty_articulos,
*             id       TYPE i,
*             nombre   TYPE string,
*             cantidad TYPE i,
*           END OF ty_articulos.
    " Declara una tabla interna lt_compra cuyas filas sean de tipo ty_articulos
*
*    DATA lt_compra TYPE TABLE OF ty_articulos.
*
*    " tres estructuras con value
*    DATA(lt_compras_1) = VALUE ty_articulos(
*         id = 1 nombre = 'pan' cantidad = 10
*     ).
*
*    DATA(lt_compras_2) = VALUE ty_articulos(
*       id = 4 nombre = 'leche' cantidad = 6
*     ).
*    DATA(lt_compras_3) = VALUE ty_articulos(
*       id = 5 nombre = 'huevos' cantidad = 6
*    ).
*
*    APPEND:
*         lt_compras_1 TO lt_compra.
*         lt_compras_2 TO lt_compra.
*         lt_compras_3 TO lt_compra.
*
*    out->write( lt_compra ).


    " ejercicio 3

    " crear una tabla de golpe con value

*    TYPES: BEGIN OF ty_alumno,
*             id       TYPE i,
*             nombre   TYPE string,
*             ciudad   TYPE string,
*             aprobado TYPE abap_bool,
*
*           END OF ty_alumno.
*
*    TYPES ty_t_alumnos TYPE STANDARD TABLE OF ty_alumno WITH EMPTY KEY.
*
*    DATA(lt_alumno) = VALUE ty_t_alumnos(
*          ( id = 1 nombre = 'laura' ciudad = 'sevilla' aprobado = abap_true )
*          ( id = 2 nombre = 'pablo' ciudad = 'jerez' aprobado = abap_true )
*          ( id = 3 nombre = 'marta' aprobado = abap_true )
*    ).

* ejercicios loop
*definimos la estructura
*    TYPES: BEGIN OF ty_bebida,
*             id       TYPE i,
*             nombre   TYPE string,
*             precio   TYPE i,
*             caliente TYPE abap_boolean,
*           END OF ty_bebida.
*
*
** tabla basada en la estructura
*
*    TYPES ty_t_bebidas TYPE STANDARD TABLE OF ty_bebida WITH EMPTY KEY.
*
** creamos los vectores
*    .DATA(lt_bebidas) = VALUE ty_t_bebidas(
*
*        ( id = 1 nombre = 'cafe' precio = 2 caliente = abap_true )
*        ( id = 2 nombre = 'té'  precio = 3 caliente = abap_true )
*        ( id = 3 nombre = 'zumo' precio = 2 caliente = abap_false )
*        ( id = 4 nombre = 'batido' precio = 3 caliente = abap_false )
*     ).
*
** loop para mostrar nombre y precio
*    LOOP AT lt_bebidas INTO DATA(ls_bebidas_1).
*
*      out->write( ls_bebidas_1-nombre ).
*      out->write( ls_bebidas_1-precio ).
*
*    ENDLOOP.
** loop para mostrar bebidas calientes
*    LOOP AT lt_bebidas INTO DATA(ls_bebidas_2).
*
*      IF ls_bebidas_2-caliente = abap_true.
*        out->write( ls_bebidas_2 ).
*      ENDIF.
*
*    ENDLOOP.



* ejercicio 2

*    " estructura vacia de  alumno
*    TYPES: BEGIN OF ty_alumno,
*             id     TYPE i,
*             nombre TYPE string,
*             nota   TYPE i,
*
*
*           END OF ty_alumno.
*
*    " tabla basada en la estructura
*
*    TYPES ty_t_alumnos TYPE STANDARD TABLE OF ty_alumno WITH EMPTY KEY.
*
*    " Creamos los cinco alumnos
*    DATA(lt_alumnos) = VALUE  ty_t_alumnos(
*         ( id = 1 nombre = 'juan' nota = 7 )
*         ( id = 2 nombre = 'ana' nota = 8 )
*         ( id = 3 nombre = 'antonio' nota = 7 )
*         ( id = 4 nombre = 'luisa' nota = 9 )
*         ( id = 5 nombre = 'francisco' nota = 5 )
*     ).


    " loop para recorrer si la nota es 5 o más , más de 5 :aprobado ,menos suspenso y saber cuantos alumnos han aprobado
    " declaramos una variable contador
*    DATA contador TYPE i.
*    LOOP AT lt_alumnos INTO DATA(ls_alumno_1).
*
*      IF ls_alumno_1-nota >= 5.
*        out->write( 'aprobado' ).
*        contador = contador + 1.
*      ELSE.
*        out->write( 'suspenso' ).
*      ENDIF.
*
*    ENDLOOP.
*    out->write( |Han aprobado { contador } alumnos| ).



    " ejercicio 3


    " creamos la estructura cliente

*    TYPES: BEGIN OF ty_pedido,
*             id       TYPE i,
*             cliente  TYPE string,
*             cantidad TYPE i,
*             estado   TYPE c LENGTH 1, " 'p', 'e' o 'c'.
*
*
*           END OF ty_pedido.
*    " creamos la tabla
*    TYPES ty_t_pedidos TYPE STANDARD TABLE OF ty_pedido WITH EMPTY KEY.
*
*    " creamos y rellenamos la tabla
*
*    DATA(lt_pedidos) = VALUE ty_t_pedidos(
*      ( id = 1 cliente = 'uFRwww' cantidad = 5 estado = 'e' )
*      ( id = 2 cliente = 'edsrtt' cantidad = 10 estado = 'p' )
*      ( id = 3 cliente = 'esffdws' cantidad = 12 estado = 'c' )
*      ( id = 4 cliente = 'esdeopp' cantidad = 11 estado = 'p' )
*      ( id = 5 cliente = 'esawdf' cantidad = 6 estado = 'e' )
*      ( id = 6 cliente = 'esdfw3' cantidad = 7 estado = 'e' )
*    ).
*    " creamos los contadores para los estados
*    DATA contador_e TYPE i.
*    DATA contador_p TYPE i.
*    DATA contador_c TYPE i.
*    DATA estado_desconocido TYPE i.
*
*
*    " loop
*    LOOP AT lt_pedidos INTO DATA(ls_pedido).
*
*      CASE ls_pedido-estado.
*        WHEN 'p'.
*
*        WHEN 'e'.
*
*        WHEN 'c'.
*
*        WHEN estado_desconocido.
*           out->write( 'estado desconocido' ).
*
*      ENDCASE.
*
*    ENDLOOP.


* EJERCICIO 4

    " estructura empleado
    TYPES: BEGIN OF ty_empleado,
             id           TYPE i,
             nombre       TYPE string,
             departamento TYPE string,
             salario      TYPE i,
             activo       TYPE abap_bool,


           END OF ty_empleado.
    "estructura resumen
    TYPES: BEGIN OF ty_resumen,

             nombre        TYPE string,
             salario_final TYPE i,
             categoria     TYPE string,

           END OF ty_resumen.

    " iniciamos las tablas
    TYPES ty_t_empleado TYPE STANDARD TABLE OF ty_empleado WITH EMPTY KEY.

    TYPES ty_t_resumen TYPE STANDARD TABLE OF ty_resumen WITH EMPTY KEY.


    " creamos los empleados en la tabla
    DATA(lt_empleado) = VALUE ty_t_empleado(

       ( id = 01 nombre = 'Antonio' departamento = 'IT' salario = 2300 activo = abap_true )
       ( id = 02 nombre = 'Ana' departamento = 'RRHH' salario = 2000 activo = abap_true )
       ( id = 03 nombre = 'Maria' departamento = 'IT' salario = 2300 activo = abap_false )
       ( id = 04 nombre = 'Luis' departamento = 'VENTAS' salario = 1900 activo = abap_false )
       ( id = 05 nombre = 'Francisco' departamento = 'IT' salario = 2200 activo = abap_true )
       ( id = 06 nombre = 'Luisa' departamento = 'RRHH' salario = 1900 activo = abap_true )
       ( id = 07 nombre = 'Antonio' departamento = 'VENTAS' salario = 2100 activo = abap_false  )

     ).

    DATA(lt_resumen) = VALUE ty_t_resumen(  ).

    " declaramos los contadores

    DATA Suma_total_salario TYPE i.
    DATA empleados_procesados TYPE i.


    " LOOP

    LOOP AT lt_empleado INTO DATA(ls_empleado).

      IF ls_empleado-activo = abap_false.
        CONTINUE.
      ENDIF.

      " declaramos la variable paras sumar el salario más el plus
      DATA(salario_final) = 0.


      CASE ls_empleado-departamento.

        WHEN 'IT'.
          salario_final = ls_empleado-salario + 200.
        WHEN 'VENTAS'.
          salario_final = ls_empleado-salario + 100.
        WHEN OTHERS.
          salario_final = ls_empleado-salario.

      ENDCASE.


      " calculamos la categoria
      DATA categoria TYPE string.
      IF salario_final  > 2500.
        categoria = 'ALTA'.
      ELSE.
        categoria = 'NORMAL'.

      ENDIF.


      " añadimos a la tabla resumen los datos

      APPEND VALUE #(
           nombre = ls_empleado-nombre
           salario_final = salario_final
           categoria = categoria ) TO lt_resumen.


      " actualizamos los contadores
      empleados_procesados = empleados_procesados + 1.
      Suma_total_salario = Suma_total_salario + salario_final.


    ENDLOOP.


    " segundo loop para mostrar los resultados
    out->write( '--- RESUMEN DE NÓMINAS ---' ).

    LOOP AT lt_resumen INTO DATA(ls_resumen).
      out->write( |Empleado: { ls_resumen-nombre } | &&
                  |Salario Final: { ls_resumen-salario_final } | &&
                  |Categoría: { ls_resumen-categoria }| ).
    ENDLOOP.

    " resultados globales

    out->write( '----------------------------' ).
    out->write( |Empleados procesados: { empleados_procesados }| ).
    out->write( |Total salarios pagados: { Suma_total_salario }| ).



    " ---------------Ejercicio 5-----------------------------



  ENDMETHOD.
ENDCLASS.
