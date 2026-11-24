@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZRAP_PRODUC_17'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_RAP_PRODUC_17
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_RAP_PRODUC_17
  association [1..1] to ZR_RAP_PRODUC_17 as _BaseEntity on $projection.PRODUCTOID = _BaseEntity.PRODUCTOID
{
  key ProductoID,
  Nombre,
  Descripcion,
  Stock,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
