@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PharmaCold: Sensores Base'
define view entity ZR_PHARMA_LOG
  as select from zpharma_log_i
  association to parent ZR_PHARMA_LOT as _PharmaLot on $projection.LotUuid = _PharmaLot.LotUuid
{
  key log_uuid              as LogUuid,
      lot_uuid              as LotUuid,
      sensor_id             as SensorId,
      @Semantics.quantity.unitOfMeasure: 'TempUnit'
      recorded_temp         as RecordedTemp,
      temp_unit             as TempUnit,
      recorded_at           as RecordedAt,
      location_gps          as LocationGps,
      
      /* ETags locales para control de concurrencia */
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* Asociaciones Públicas */
      _PharmaLot
}
