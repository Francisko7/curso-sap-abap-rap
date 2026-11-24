CLASS LHC_ZR_Z0017TRAVEL DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrZ0017travel
        RESULT result,
      setInitialStatus FOR DETERMINE ON SAVE
            keys FOR ZrZ0017travel~setInitialStatus.
ENDCLASS.

CLASS LHC_ZR_Z0017TRAVEL IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD setInitialStatus.
    " 1. Leer las reservas recién creadas
    READ ENTITIES OF zr_z0017travel IN LOCAL MODE
      ENTITY zr_z0017travel
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    " 2. Asignar el estado 'N'
    MODIFY ENTITIES OF zr_z0017travel IN LOCAL MODE
      ENTITY zr_z0017travel
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR travel IN lt_travels (
                        %tky   = travel-%tky
                        Status = 'N'
                      ) ).
  ENDMETHOD.

ENDCLASS.
