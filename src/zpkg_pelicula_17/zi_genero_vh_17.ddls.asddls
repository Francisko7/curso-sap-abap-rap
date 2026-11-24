@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de búsqueda de Género'
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_GENERO_VH_17
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZDO_GENERO_17' )
{
      @UI.textArrangement: #TEXT_FIRST
      @ObjectModel.text.element: [ 'Descripcion' ]
  key cast( value_low as zde_genero_17 ) as Codigo,

      @Semantics.text: true
      text                               as Descripcion
}
where
  language = $session.system_language
