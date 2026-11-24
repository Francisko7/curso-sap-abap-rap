@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZRAP_PELICULA_17'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_RAP_PELICULA_17
  provider contract transactional_query
  as projection on ZR_RAP_PELICULA_17
  association [1..1] to ZR_RAP_PELICULA_17 as _BaseEntity on $projection.IdPelicula = _BaseEntity.IdPelicula
{
  key IdPelicula,
  Titulo,
  Director,
  Anio,
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_PELI_GENERO_VH_17', element: 'Codigo' } }]
  Genero,
  Clasificacion,
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
