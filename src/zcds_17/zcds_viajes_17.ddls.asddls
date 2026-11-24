

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'viajes'
@Metadata.ignorePropagatedAnnotations: true

// definimos la entidad
define view entity ZCDS_VIAJES_17

// la tabla principal con el alias Travel
as select from /dmo/travel   as Travel

   // este es el primer join aqui se cruzamos con cliente por el identificador del cliente
    inner join   /dmo/customer as Customer
      on Travel.customer_id = Customer.customer_id
   // el segundo join cruzamos con agencia por el identificador de la agencia
    inner join   /dmo/agency   as Agency
      on Travel.agency_id = Agency.agency_id
{
    // clave primaria 
    key Travel.travel_id     as IdViaje,
    
    
    // fecha de inicio y fin de viaje
      Travel.begin_date    as FechaInicio,
      Travel.end_date      as FechaFin,
      
    // asociamos el importe númerico con su moneda
      @Semantics.amount.currencyCode: 'Moneda'
      Travel.total_price   as PrecioTotal,
      
    // campo moneda del precio total
      Travel.currency_code as Moneda,
      
    // campo calculado de fecha fin el nombre del mes 
         substring( Travel.end_date, 5, 2 ) as MesFin,
         
         
    // when 'enero' or 'febrero' or 'marzo' then '1T'
    
        case
            when $projection.MesFin between '01' and '03'
            
            then 'Primer Trimestre'
            else 'otro trimestre'
            
            end      as TrimestreFin,
            
    
      
    // los datos obtenidos de la tabla /dmo/customer
      Customer.first_name  as NombreCliente,
      Customer.last_name   as ApellidoCliente,
      
    // los datos obtenidos de la tabla /dmo/agency 
      Agency.name          as NombreAgencia,
      Agency.city          as CiudadAgencia
}
