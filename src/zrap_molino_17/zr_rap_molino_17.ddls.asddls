@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZRAP_MOLINO_17'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_RAP_MOLINO_17
  as select from ZRAP_MOLINO_17
{
  key molino_id as MolinoID,
  nombre as Nombre,
  fabricante as Fabricante,
  modelo as Modelo,
  ubicacion as Ubicacion,
  potencia_kw as PotenciaKw,
  altura_m as AlturaM,
  fecha_inst as FechaInst,
  estado as Estado,
  responsable as Responsable,
  codigo_interno as CodigoInterno,
  observaciones as Observaciones,
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
