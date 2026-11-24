@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clientes con código y apellido'
define view entity ZCDS_EJERCICIO1_APELLIDOS
  as select from /dmo/customer
{
  // Clave primaria: código de cliente con alias descriptivo
  key customer_id as CodigoCliente,
  // Campo adicional: apellido del cliente con alias descriptivo
      last_name   as ApellidoCliente
}
