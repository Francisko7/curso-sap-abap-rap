@EndUserText.label: 'Desplegable de Modelo'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_MODELO_VH_17'
@ObjectModel.resultSet.sizeCategory: #XS
define custom entity ZI_MODELO_VH_17
{
  @UI.textArrangement: #TEXT_ONLY
  @ObjectModel.text.element: [ 'Descripcion' ]
  key Codigo      : abap.char(40);
      Descripcion : abap.char(60);
}
