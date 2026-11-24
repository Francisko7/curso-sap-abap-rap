define view entity ZCDS_EJERCICIO1_CASE
  as select from /dmo/carrier
{
  key carrier_id as Codigo,
      name       as Nombre,

      left( name, 3 )                       as Abreviatura,
      upper( $projection.Abreviatura )      as TresLetrasMayus
}
