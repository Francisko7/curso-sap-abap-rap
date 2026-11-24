@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio 4: Vuelos y Aerolíneas'
define view entity ZCDS_EJERCICIO4
  as select from /dmo/flight as Flight
  association [1..1] to /dmo/carrier as _Carrier
    on $projection.CarrierId = _Carrier.carrier_id
{
  key Flight.carrier_id    as CarrierId,
  key Flight.connection_id as ConnectionId,
  key Flight.flight_date   as FlightDate,
      _Carrier.name        as NombreAerolinea,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Flight.price         as Price,
      Flight.currency_code as CurrencyCode
}
