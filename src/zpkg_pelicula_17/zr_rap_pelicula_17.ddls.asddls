@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZRAP_PELICULA_17'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_RAP_PELICULA_17
  as select from ZRAP_PELICULA_17
{
  key id_pelicula as IdPelicula,
  titulo as Titulo,
  director as Director,
  anio as Anio,
  genero as Genero,
  clasificacion as Clasificacion,
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
