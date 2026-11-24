@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZAUTO_VEH_17'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_AUTO_VEH_17
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_AUTO_VEH_17
  association [1..1] to ZR_AUTO_VEH_17 as _BaseEntity on $projection.VEHICULOUUID = _BaseEntity.VEHICULOUUID
{
  key VehiculoUUID,
  Matricula,
  Bastidor,
  Marca,
  Modelo,
  AnioFabricacion,
  Kilometros,
  Combustible,
  PotenciaCv,
  @Semantics: {
    Amount.Currencycode: 'Moneda'
  }
  Precio,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  Moneda,
  Estado,
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
