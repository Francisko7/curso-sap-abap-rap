CLASS zcl_aero_utilidades_test_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AERO_UTILIDADES_TEST_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  out->write( |=== PLAN DE PRUEBAS 9.2: ZCL_AERO_UTILIDADES ===| ).

    " Paso 1: validar_matricula('EC-ABC') -> Esperado: Verdadero
    DATA(lv_res1) = zcl_aero_utilidades_02=>validar_matricula( 'EC-ABC' ).
    out->write( |Paso 1 - EC-ABC: { lv_res1 }| ). " Verdadero (X)

    " Paso 2: validar_matricula('EC-AB') -> Esperado: Falso, longitud 5
    DATA(lv_res2) = zcl_aero_utilidades_02=>validar_matricula( 'EC-AB' ).
    out->write( |Paso 2 - EC-AB: { lv_res2 }| ). " Falso ( )

    " Paso 3: validar_matricula('XX-ABC') -> Esperado: Falso, prefijo incorrecto
    DATA(lv_res3) = zcl_aero_utilidades_02=>validar_matricula( 'XX-ABC' ).
    out->write( |Paso 3 - XX-ABC: { lv_res3 }| ). " Falso ( )

    " Paso 4: validar_matricula('ECABCD') -> Esperado: Falso, sin guion
    DATA(lv_res4) = zcl_aero_utilidades_02=>validar_matricula( 'ECABCD' ).
    out->write( |Paso 4 - ECABCD: { lv_res4 }| ). " Falso ( )

    " Paso 5: convertir_horas_a_minutos(2) -> Esperado: 120
    DATA(lv_min1) = zcl_aero_utilidades_02=>convertir_horas_a_minutos( 2 ).
    out->write( |Paso 5 - 2 horas a minutos: { lv_min1 }| ). " 120

    " Paso 6: convertir_horas_a_minutos(0) -> Esperado: 0
    DATA(lv_min2) = zcl_aero_utilidades_02=>convertir_horas_a_minutos( 0 ).
    out->write( |Paso 6 - 0 horas a minutos: { lv_min2 }| ). " 0
  ENDMETHOD.
ENDCLASS.
