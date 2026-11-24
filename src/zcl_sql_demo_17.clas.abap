CLASS zcl_sql_demo_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_DEMO_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA ls_alumno TYPE zexperis_sql_17.

    ls_alumno-id = '0001'.
    ls_alumno-nombre = 'Ana'.
    ls_alumno-ciudad = 'jerez'.
    ls_alumno-nota = 8.

    INSERT zexperis_sql_17 FROM @ls_alumno.

    IF sy-subrc = 0.
      out->write( |alumno insertado. filas insertadas { sy-dbcnt }| ).

    ELSE.
      out->write( |No se pudo insertar. sy-subrc = { sy-subrc }| ).

      ENDIF.




    ENDMETHOD.
ENDCLASS.
