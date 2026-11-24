@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio 1: Aerolíneas en español'
define view entity ZCDS_VUELOS17
  as select from /dmo/carrier
{
  key carrier_id as CodigoAerolinea,
      name       as NombreAerolinea
}
