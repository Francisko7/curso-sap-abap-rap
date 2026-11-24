@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZAUTO_VEH_17'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_AUTO_VEH_17
  as select from ZAUTO_VEH_17
{
  key vehiculo_uuid as VehiculoUUID,
  matricula as Matricula,
  bastidor as Bastidor,
  marca as Marca,
  modelo as Modelo,
  anio_fabricacion as AnioFabricacion,
  kilometros as Kilometros,
  combustible as Combustible,
  potencia_cv as PotenciaCv,
  @Semantics.amount.currencyCode: 'Moneda'
  precio as Precio,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  moneda as Moneda,
  estado as Estado,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
