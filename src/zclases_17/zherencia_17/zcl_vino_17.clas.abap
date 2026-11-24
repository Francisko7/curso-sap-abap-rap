CLASS zcl_vino_17 DEFINITION
  PUBLIC
  " 1. Eliminamos FINAL para permitir la herencia
  CREATE PUBLIC .

  PUBLIC SECTION.
  " 2. Constructor  recibe los datos comunes a todos los vinos (instancias)
    METHODS constructor
      IMPORTING
        iv_nombre  TYPE string
        iv_crianza TYPE i.

    " 3. Método común que heredaran todos los hijos
    METHODS obtener_descripcion
      RETURNING VALUE(rv_desc) TYPE string.
  PROTECTED SECTION.

   " 4. PROTECTED: Accesible para el padre y para cualquier clase hija
    DATA nombre  TYPE string.
    DATA crianza TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VINO_17 IMPLEMENTATION.


 METHOD constructor.
    " Guardamos los parámetros de entrada en los atributos protegidos
    " Usamos me-> para especificar que guardamos el parámetro temporal de entrada dentro del atributo permanente del propio objeto.
    me->nombre  = iv_nombre.
    me->crianza = iv_crianza.
  ENDMETHOD.


  METHOD obtener_descripcion.
    " 5. Uso de string templates para una concatenación limpia
    rv_desc = |{ me->nombre } ({ me->crianza } años)|.
  ENDMETHOD.
ENDCLASS.
