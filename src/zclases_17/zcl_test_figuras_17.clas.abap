CLASS zcl_test_figuras_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_descriptible_17.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_figuras_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " tabla interna
  DATA figuras TYPE STANDARD TABLE OF REF TO zcl_figura_17 WITH EMPTY KEY.

  " aqui acumulamos todas las medidas
    DATA lv_suma TYPE zcl_figura_17=>ty_medida VALUE 0.


   figuras = VALUE #(
      ( NEW zcl_circulo_17( '2.00' ) )
      ( NEW zcl_triangulo_17( iv_base = '6.00' iv_altura = '3.00' ) )
      ( NEW zcl_cuadrado_17( '4.00' ) )
    ).




    " 3. Recorremos la tabla
    LOOP AT figuras INTO DATA(figura).
      lv_suma = lv_suma + figura->calcular_area( ).
    ENDLOOP.

    " 4. Mostramos
    out->write( |Suma total: { lv_suma }| ).



    " parte interface
    DATA describibles TYPE STANDARD TABLE OF REF TO zif_descriptible_17 WITH EMPTY KEY.

     describibles = VALUE #(
      ( NEW zcl_circulo_17( '2.00' ) )
      ( NEW zcl_triangulo_17( iv_base = '6.00' iv_altura = '3.00' ) )
      ( NEW zcl_cuadrado_17( '4.00' ) )
      ( NEW zcl_cartel_17( 'Prohibido aparcar' ) )

      ).

       LOOP AT describibles INTO DATA(describible).
      out->write( describible->describir( ) ).

      ENDLOOP.
  ENDMETHOD.


ENDCLASS.
