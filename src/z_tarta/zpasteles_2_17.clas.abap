CLASS zpasteles_2_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPASTELES_2_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA lt_pedidos TYPE STANDARD TABLE OF ztarta_db WITH EMPTY KEY.


    lt_pedidos = VALUE #(
        ( id_pedido = '0001' pastel = 'Tarta de cumpleaños de chocolate' sabor = 'Chocolate' raciones = 12 precio = '38.50' fecha_entrega = '20261115' )
        ( id_pedido = '0002' pastel = 'Tarta de fresa con nata'          sabor = 'Fresa'     raciones = 10 precio = '32.00' fecha_entrega = '20261120' )
        ( id_pedido = '0003' pastel = 'Tarta de zanahoria'               sabor = 'Zanahoria' raciones = 8  precio = '28.75' fecha_entrega = '20261122' )
        ( id_pedido = '0004' pastel = 'Tarta de queso con arándanos'     sabor = 'Queso'     raciones = 16 precio = '45.00' fecha_entrega = '20261128' )
        ( id_pedido = '0005' pastel = 'Tarta infantil de Lacasitos'      sabor = 'Chocolate' raciones = 20 precio = '55.90' fecha_entrega = '20261205' )
        ( id_pedido = '0006' pastel = 'Tarta de tres chocolates'         sabor = 'Chocolate' raciones = 14 precio = '41.00' fecha_entrega = '20261210' )
        ( id_pedido = '0007' pastel = 'Tarta de limón y merengue'        sabor = 'Limón'     raciones = 12 precio = '36.50' fecha_entrega = '20261212' )
        ( id_pedido = '0008' pastel = 'Tarta de cumpleaños de unicornio' sabor = 'Vainilla'  raciones = 24 precio = '62.00' fecha_entrega = '20261219' ) ).


    " 1. Vaciamos la tabla de la base de datos para borrar restos viejos
    DELETE FROM ztarta_db.

    " 2. Insertamos los 8 pedidos limpios
    INSERT ztarta_db FROM TABLE @lt_pedidos.


    out->write( lt_pedidos ).



    " RETOS
*
*    "1 Muestra solo el pastel y el sabor
*
*    SELECT pastel, sabor FROM ztarta_db INTO  TABLE  @DATA(lt_pastel_sabores).
*
*    out->write( lt_pastel_sabores ).
*
*
*    " 2 Muestra precio, raciones y pastel
*
*    SELECT precio, raciones, pastel FROM ztarta_db  INTO TABLE @DATA(lt_precio).
*
*
*
*    " 3 Muestra el id_pedido y la fecha_entrega de los pedidos de sabor Fresa
*
*    SELECT id_pedido, fecha_entrega FROM ztarta_db WHERE sabor = 'Fresa'  INTO TABLE  @DATA(lt_pedido).
*
*    out->write( lt_pedido ).
*
*
*    " 4 Muestra el pastel y las raciones de las tartas con 16 raciones o más
*
*    SELECT pastel, raciones FROM ztarta_db WHERE raciones >= 16 INTO TABLE @DATA(lt_raciones).
*
*    out->write( lt_raciones ).
*
*    " 5 Muestra el pastel y el precio de las tartas que cuestan más de 40 euros
*
*    SELECT pastel, precio FROM ztarta_db WHERE precio > 40 INTO TABLE @DATA(lt_pastel).
*    out->write( lt_pastel ).
*
*    " RETO 6 sabor chocolate AND precio menor 40 euros
*    SELECT sabor, precio FROM ztarta_db WHERE sabor = 'Chocolate' AND precio < 40 INTO TABLE @DATA(lt_chocolate_barata).
*    out->write( lt_chocolate_barata ).
*
*
*    " RETO 7 Sabor Limón O Vainilla
*    SELECT sabor FROM ztarta_db WHERE sabor = 'Limón' OR sabor = 'Vainilla' INTO TABLE @DATA(lt_limon_vainilla).
*    out->write( lt_limon_vainilla ).
*
*
*    " Reto 8: Fecha a partir del 1 de diciembre de 2026
*    SELECT fecha_entrega FROM ztarta_db WHERE fecha_entrega >= '20261201' INTO TABLE @DATA(lt_entrega_diciembre).
*    out->write( lt_entrega_diciembre ).
*
*
*
*    " Sabores que no existan
*    SELECT * FROM ztarta_db WHERE sabor = 'Pistacho' INTO TABLE @DATA(lt_pistacho).
*    IF sy-subrc = 4.
*      out->write( |Reto 9: No se encontró ninguna tarta con ese sabor (sy-subrc = { sy-subrc })| ).
*    ENDIF.
*
*
*
*    " RETO 10: Usar una variable local con @ en el WHERE
*    DATA lv_sabor TYPE ztarta_db-sabor VALUE 'Queso'.
*
*    SELECT *  FROM ztarta_db   WHERE sabor = @lv_sabor  INTO TABLE @DATA(lt_por_variable).
*    out->write( lt_por_variable ).
*
*    " Reto 11. Busca los pedidos de sabor 'chocolate' en minúscula.
*
*    SELECT *   FROM ztarta_db   WHERE sabor = 'chocolate'  INTO TABLE @DATA(lt_trampa).
*    out->write( |Filas encontradas con chocolate en minúsculas: { lines( lt_trampa ) }| ).
*
*    " Reto 12: Operador BETWEEN (entre 30 y 40 euros)
*    SELECT *   FROM ztarta_db   WHERE precio BETWEEN 30 AND 40  INTO TABLE @DATA(lt_between).
*    out->write( lt_between ).
*
*
*    " Reto 13: Operador IN (lista de valores)
*    SELECT *  FROM ztarta_db  WHERE sabor IN ( 'Fresa', 'Queso', 'Zanahoria' ) INTO TABLE @DATA(lt_sabores_seleccionados).
*    out->write( lt_sabores_seleccionados ).
*
*    " Reto 14. Usa LIKE para mostrar los pedidos cuyo nombre de pastel contenga la palabra chocolate.
*    SELECT * FROM ztarta_db  WHERE pastel LIKE '%chocolate%'  INTO TABLE @DATA(lt_tartas_chocolate).
*    out->write( lt_tartas_chocolate ).
*
*

    " Reto 1. Lee todas las columnas del pedido 0003 y muéstralas por consola.
    " → Resultado: una fila, la Tarta de zanahoria.
*    SELECT SINGLE *
*      FROM ztarta_db
*      WHERE id_pedido = '0003'
*      INTO @DATA(ls_pedido).
*
*    IF sy-subrc = 0.
*      out->write( ls_pedido ).
*    ELSE.
*      out->write( 'El pedido no existe' ).
*
*    ENDIF.
*
*
*    "  Reto 2. Del pedido 0005, lee solo el pastel y la fecha de entrega y muéstralos en un mensaje.
*
*    SELECT SINGLE pastel, fecha_entrega
*  FROM ztarta_db
*  WHERE id_pedido = '0005'
*  INTO @DATA(ls_pastel5).
*
*    IF sy-subrc = 0.
*      out->write( |Pastel : { ls_pastel5-pastel } - Fecha: { ls_pastel5-fecha_entrega }| ).
*    ELSE.
*      out->write( |No existe el pedido 0005. sy-subrc = { sy-subrc }| ).
*    ENDIF.
*
*
*    " Reto 3. Lee el precio del pedido 0007 en una variable simple y muestra el mensaje "El pedido 0007 cuesta ... euros".
*
*    SELECT SINGLE precio
*     FROM ztarta_db
*     WHERE id_pedido = '0007'
*     INTO @DATA(lv_precio7).
*
*    IF sy-subrc = 0.
*      out->write( |El pedido 0007 cuesta { lv_precio7 }| ).
*    ELSE.
*      out->write( |No existe el pedido 0007 { lv_precio7 }| ).
*    ENDIF.
*
*
*    " Reto 4. Busca el pedido 0020, que no existe, y muestra un mensaje en lenguaje normal usando sy-subrc.
*
*    SELECT SINGLE *
*    FROM ztarta_db
*    WHERE id_pedido = '0020'
*    INTO @DATA(ls_error).
*
*    IF sy-subrc = 0.
*      out->write( 'El pedido existe' ).
*    ELSE.
*      out->write( 'El pedido no existe' ).
*    ENDIF.


    " Reto 5. Guarda '0006' en una variable y úsala en el WHERE para mostrar las raciones de ese pedido.

*    SELECT SINGLE raciones
*     FROM ztarta_db
*     WHERE id_pedido = @lv_r5_id.
*      into @DATA(ls_raciones).

    " Reto 6. Lee el pedido 0004 y muestra una frase que junte tres campos: "El pedido 0004 es una [pastel] de [raciones] raciones".

*      SELECT SINGLE id_pedido, pastel, raciones
*      FROM  ztarta_db
*      WHERE


    " DELETE
    " Reto 1. Borra el pedido 0003 y muestra cuántas filas se han borrado.

*    DELETE FROM ztarta_db
*     WHERE id_pedido = '0003'.
*
*    IF sy-subrc = 0.
*      out->write( |Pedidod eliminado. fila borrada { sy-dbcnt }| ).
*    ELSE.
*      out->write( |No se encontro| ).
*    ENDIF.
*
*
*
*    " Reto 2. Intenta borrar el pedido 0050 y muestra un mensaje distinto según sy-subrc
*
*    DELETE FROM ztarta_db
*    WHERE id_pedido = '0050'.
*
*    IF sy-subrc = 0.
*      out->write( |El pedido 0050 fue borrado| ).
*    ELSE.
*      out->write( |El pedido no existe| ).
*    ENDIF.
*
*    " Reto 3. Borra lots pedidos de sabor Fresa.
*    DELETE FROM ztarta_db
*    WHERE sabor = 'Fresa'.
*
*    IF sy-subrc = 0.
*      out->write( |Se han borrado los sabores fresas| ).
*    ELSE.
*      out->write( |El sabor no existe| ).
*    ENDIF.
*
*
*    " Reto 4. Borra los pedidos que cuesten más de 40 euros.
*
*    DELETE FROM ztarta_db
*    WHERE precio > 40.
*
*    IF sy-subrc = 0.
*    out->write( |Se han borrado los pedidos mayores a 40| ).
*    ELSE.
*    out->write( |Los pedidos no existen| ).
*    ENDIF.
*
*
*
*    " Reto 5. Borra los de sabor Chocolate con menos de 14 raciones.
*    DELETE FROM ztarta_db
*    WHERE sabor = 'Chocolate'
*    AND raciones < 14.
*
*     IF sy-subrc = 0.
*    out->write( |Se han borrado los sabores de chocolate con menor de 14 raciones| ).
*    ELSE.
*    out->write( |Los pedidos no existen| ).
*    ENDIF.
*
*    " Reto 6. Borra los pedidos que se entregan antes del 25 de noviembre de 2026.
*    DELETE FROM ztarta_db
*    WHERE fecha_entrega < '20261125'.
*
*    IF sy-subrc = 0.
*    out->write( |Se han borrado los pedidos antes de 25 noviembre 2026| ).
*    ELSE.
*    out->write( |Los pedidos no existen| ).
*    ENDIF.
*
*    " Reto 7. Borra los de sabor Limón o Vainilla en un solo DELETE.
*    DELETE FROM ztarta_db
*    WHERE sabor = 'Limón' OR sabor = 'Vainilla'.
*
*     IF sy-subrc = 0.
*    out->write( |Se han borrado los pedidos de sabor limón o vainilla| ).
*    ELSE.
*    out->write( |Los pedidos no existen| ).
*    ENDIF.
*
    " Reto 8. Guarda 'Zanahoria' en una variable y úsala en el WHERE para borrar.

    " DELETE

    " UPDATE y MODIFY

    " Reto 1: cambiar varios campos.
    " Al pedido 0002 ponle precio 35 y 12 raciones, en un solo UPDATE. Después léelo y
    " comprueba que el resto de campos no ha cambiado.

    UPDATE ztarta_db
    SET precio = 35 , raciones = 12
    WHERE id_pedido = '0002'.

    IF sy-subrc = 0.
      out->write( |Pedido 0002 actualizado, se han cambiado ,filas afectadas: { sy-dbcnt }| ).
    ELSE.
      out->write( |El pedido no existe| ).
    ENDIF.

    " Reto 2: calcular sobre el valor actual.
    " Rebaja 5 euros a todos los pedidos que cuesten más de 40 euro

    UPDATE ztarta_db
    SET precio = precio - '5.00'
    WHERE precio > 40.

    IF sy-subrc = 0.
      out->write( |Se han rebajado 5 euros a los mayores de 40,son  { sy-dbcnt } filas| ).
    ELSE.
      out->write( |El pedido no existe| ).
    ENDIF.


    " Reto 3: cambiar un campo usando una estructura.
    " Cambia la fecha de entrega del pedido 0007 al 14 de diciembre de 2026, pero usando UPDATE ...
    " FROM con una estructura, sin perder ningún otro dato de la fila
    UPDATE ztarta_db
    SET fecha_entrega = '20261214'
    WHERE id_pedido = '0007'.

    IF sy-subrc = 0.
      out->write( |Se ha cambiado la fecha del pedido 7  { sy-dbcnt } | ).
    ELSE.
      out->write( |El pedido no existe| ).
    ENDIF.

    " Reto 4: MODIFY con una fila existente y otra nueva.
    " Con una tabla interna de dos filas completas, haz un solo MODIFY:

    " el pedido 0003, con el precio cambiado a 30,
    " un pedido 0011 que no existe, con los datos que quieras.

    " declaramos la tabla interna
    DATA lt_modificado TYPE STANDARD TABLE OF ztarta_db WITH EMPTY KEY.

    lt_modificado = VALUE #(
      ( id_pedido = '0003' pastel = 'Tarta de zanahoria' sabor = 'Zanahoria' raciones = 8  precio = '30.00' fecha_entrega = '20261122' )
  " Esta clave es NUEVA: se inserta.
  ( id_pedido = '0010' pastel = 'Tarta de chocolate blanco' sabor = 'Chocolate'
    raciones = 12 precio = '39.00' fecha_entrega = '20261230' ) ).

    MODIFY ztarta_db FROM TABLE @lt_modificado.

    out->write( |sy-subrc = { sy-subrc }, filas procesadas = { sy-dbcnt }| ).

    SELECT * FROM ztarta_db INTO TABLE @DATA(lt_todo).
    out->write( |Filas en la tabla: { lines( lt_todo ) }| ).

  ENDMETHOD.
ENDCLASS.
