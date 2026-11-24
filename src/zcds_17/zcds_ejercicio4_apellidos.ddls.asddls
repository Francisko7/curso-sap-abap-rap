@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio 4: Viajes y Clientes'
define view entity ZCDS_EJERCICIO4_APELLIDOS
  as select from /dmo/travel as Travel
  association [1..1] to /dmo/customer as _Customer
    on $projection.CustomerId = _Customer.customer_id
{
  key Travel.travel_id     as TravelId,  // clave primaria 
      Travel.customer_id   as CustomerId, // este campo lo necesitamos para resolver la condición
      _Customer.first_name as NombreCliente,  // campos obtenido de la entidad anterior del customer
      _Customer.last_name  as ApellidoCliente, // campos obtenido de la misma customer
      @Semantics.amount.currencyCode: 'CurrencyCode' // vinculación de la cifra con la clave primaria
      Travel.total_price   as PrecioTotal,
      Travel.currency_code as CurrencyCode  // clave de la moneda
}




