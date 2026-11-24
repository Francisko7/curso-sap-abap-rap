@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZRAP_MOLINO_17'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_RAP_MOLINO_17
  provider contract transactional_query
  as projection on ZR_RAP_MOLINO_17
  association [1..1] to ZR_RAP_MOLINO_17 as _BaseEntity on $projection.MolinoID = _BaseEntity.MolinoID
{
  key MolinoID,
  Nombre,
  Fabricante,
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MODELO_VH_17', element: 'Codigo' } }]
@UI.textArrangement: #TEXT_ONLY
  Modelo,
  Ubicacion,
  PotenciaKw,
  AlturaM,
  FechaInst,
  Estado,
  Responsable,
  CodigoInterno,
  Observaciones,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
