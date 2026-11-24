CLASS zcl_hucha_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   " Método de INSTANCIA: lo llama cada hucha, con ->
    METHODS ahorrar IMPORTING iv_importe TYPE i.

    " Método de INSTANCIA: devuelve lo que tiene ESA hucha
    METHODS obtener_ahorro RETURNING VALUE(rv_ahorro) TYPE i.

    " Método ESTÁTICO (CLASS-METHODS): se llama con la clase, con =>
    CLASS-METHODS obtener_bote_comun RETURNING VALUE(rv_bote) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
  " Atributo de INSTANCIA: cada hucha tiene el suyo
    DATA ahorro TYPE i.

    " Atributo ESTÁTICO (CLASS-DATA): uno solo para todas las huchas
    CLASS-DATA bote_comun TYPE i.

ENDCLASS.



CLASS ZCL_HUCHA_17 IMPLEMENTATION.


   METHOD ahorrar.
    ahorro     = ahorro + iv_importe.       " sube MI hucha
    bote_comun = bote_comun + iv_importe.   " sube el bote de TODOS
  ENDMETHOD.


  METHOD obtener_ahorro.
    rv_ahorro = ahorro.
  ENDMETHOD.


  METHOD obtener_bote_comun.
    rv_bote = bote_comun.
  ENDMETHOD.
ENDCLASS.
