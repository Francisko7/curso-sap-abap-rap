CLASS zcl_poo_17 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_POO_17 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Instanciamos el primer objeto de la clase cuenta
    DATA(lo_cuenta1) = NEW zcl_cuenta_17( ).

    " atributos del objeto heredado de la clase cuenta
    lo_cuenta1->titular = 'francisco'.
    lo_cuenta1->saldo   = 500.

    out->write( |Titular: { lo_cuenta1->titular }| ).
    out->write( |Saldo de la cuenta: { lo_cuenta1->saldo }| ).


    " metodos

  ENDMETHOD.
ENDCLASS.
