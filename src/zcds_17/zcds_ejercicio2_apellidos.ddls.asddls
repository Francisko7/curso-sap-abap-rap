@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Viajes con precio total menor a 2000'
define view entity ZCDS_EJERCICIO2_APELLIDOS
  as select from /dmo/travel
{
  key travel_id     as TravelId, // identificador único de viaje
      agency_id     as AgencyId,  //La agencia que gestiona el viaje
      customer_id   as CustomerId,  // Cliente que ha realizado el viaje
      begin_date    as BeginDate,  // FEcha de inicio viaje
      end_date      as EndDate,  // fecha fin viaje
      booking_fee   as BookingFee,  // gasto gestión
      
      // aqui vinculamos el importe con su moneda
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price   as TotalPrice,  // importe total del viaje
      currency_code as CurrencyCode, // código de la moneda
      description   as Description,  // descripción del viaje
      status        as Status         // estado de a reserva
}
where
  total_price < 2000
