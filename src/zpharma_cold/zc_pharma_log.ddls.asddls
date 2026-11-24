@EndUserText.label: 'PharmaCold: Telemetría (Proyección)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PHARMA_LOG
  as projection on ZR_PHARMA_LOG
{
  key LogUuid,
      LotUuid,
      SensorId,
      RecordedTemp,
      TempUnit,
      RecordedAt,
      LocationGps,
      LocalLastChangedAt,

      /* Asociaciones */
      _PharmaLot : redirected to parent ZC_PHARMA_LOT
      
}
