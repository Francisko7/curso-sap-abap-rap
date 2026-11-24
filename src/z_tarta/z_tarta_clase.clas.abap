CLASS z_tarta_clase DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_TARTA_CLASE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA ls_tarta TYPE ztarta_db.

    ls_tarta-id_pedido = 0001.
    ls_tarta-pastel = 'tarta de chocolate'.
    ls_tarta-sabor = 'Chocolate'.
    ls_tarta-raciones = 12.
    ls_tarta-precio = '38.52' .
    ls_tarta-fecha_entrega = '20261115'.

    INSERT ztarta_db FROM @ls_tarta.


*    IF sy-subrc = 0.
*      out->write( |alumno insertado. filas insertadas { sy-dbcnt }| ).
*
*    ELSE.
*      out->write( |No se pudo insertar. sy-subrc = { sy-subrc }| ).
*
*    ENDIF.

    " parte 2
    DATA lt_pedidos TYPE STANDARD  TABLE OF ztarta_db WITH EMPTY KEY.

    lt_pedidos = VALUE #(

    ( id_pedido = 0002 pastel = 'tarta fresa con nata' sabor = 'fresa' raciones = 10 precio = '28.75' fecha_entrega = '20261105' )
    ( id_pedido = 0003 pastel = 'tarta de zanahoria' sabor = 'zanahoria' raciones = 8 precio = '28.75' fecha_entrega = '20261122' )

     ).

   " INSERT ztarta_db FROM TABLE @lt_pedidos.

*    IF sy-subrc = 0.
*      out->write( |alumno insertado. filas insertadas { sy-dbcnt }| ).
*
*    ELSE.
*      out->write( |No se pudo insertar. sy-subrc = { sy-subrc }| ).
*
*    ENDIF.

    " parte 3


    lt_pedidos = VALUE #(
        ( id_pedido = 0002 pastel = 'tarta fresa con nata' sabor = 'fresa' raciones = 10 precio = '28.75' fecha_entrega = '20261126' )
        ( id_pedido = 0006 pastel = 'tarta infantil ' sabor = 'chocolate' raciones = 20 precio = '55.90' fecha_entrega = '20261115' )


     ).

    INSERT ztarta_db FROM TABLE @lt_pedidos ACCEPTING DUPLICATE KEYS.



    " SELECT
    SELECT * FROM ztarta_db INTO TABLE @DATA(lt_pedidos2).

    SELECT sabor FROM ztarta_db  INTO TABLE @DATA(lt_pedidos3).

    out->write( lt_pedidos3 ).

    IF sy-subrc = 0.
      " PASO B: sy-dbcnt me dice cuántas filas ha leído.
      out->write( |Pedidos leídos: { sy-dbcnt }| ).
      out->write( lt_pedidos ).
    ELSE.
      " sy-subrc = 4: la tabla no tiene filas. No es un error, solo está vacía.
      out->write( 'No hay ningún pedido en la tabla.' ).
    ENDIF.

    " where

    SELECT id_pedido, sabor, pastel
        FROM ztarta_db
        WHERE sabor = 'chocolate'

        INTO TABLE @DATA(lt_chocolate).


        out->write( lt_chocolate ).

  ENDMETHOD.
ENDCLASS.
