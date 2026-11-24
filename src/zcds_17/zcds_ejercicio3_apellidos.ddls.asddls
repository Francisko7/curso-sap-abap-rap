@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio 3: Viajes con precio neto calculado'

define view entity ZCDS_EJERCICIO3_APELLIDOS
  as select from /dmo/travel
{
  key travel_id                 as TravelId,  // clave primaria
      agency_id                 as AgencyId,  // datos del viaje
      customer_id               as CustomerId,  // datos del viaje

      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price               as TotalPrice,    // Precio total bruto

      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee               as BookingFee,    // Gastos de gestión

      currency_code             as CurrencyCode,  // Clave de moneda de referencia

      // Campo donde realizamos la operación
      // Realizamos la resta 
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price - booking_fee as PrecioSinGestion // Resultado: Importe neto
}
