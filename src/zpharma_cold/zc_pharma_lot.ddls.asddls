@EndUserText.label: 'PharmaCold: Lotes (Proyección UI)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_PHARMA_LOT
  provider contract transactional_query
  as projection on ZR_PHARMA_LOT
{
  key LotUuid,
      @Search.defaultSearchElement: true
      LotId,
      @Search.defaultSearchElement: true
      MedicationName,
      MinTemp,
      MaxTemp,
      TempUnit,
      Status,
      LocalLastChangedAt,

      /* Asociaciones */
      _TelemetryLogs : redirected to composition child ZC_PHARMA_LOG
}
