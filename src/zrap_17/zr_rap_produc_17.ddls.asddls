@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZRAP_PRODUC_17'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_RAP_PRODUC_17
  as select from ZRAP_PRODUC_17
{
  key producto_id as ProductoID,
  nombre as Nombre,
  descripcion as Descripcion,
  stock as Stock,
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
