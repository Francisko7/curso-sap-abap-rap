@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PharmaCold: Lotes Farmacéuticos (Base)'
define root view entity ZR_PHARMA_LOT
  as select from zpharma_lot_h
  composition [0..*] of ZR_PHARMA_LOG as _TelemetryLogs
{
  key lot_uuid              as LotUuid,
      lot_id                as LotId,
      medication_name       as MedicationName,
      @Semantics.quantity.unitOfMeasure: 'TempUnit'
      min_temp              as MinTemp,
      @Semantics.quantity.unitOfMeasure: 'TempUnit'
      max_temp              as MaxTemp,
      temp_unit             as TempUnit,
      status                as Status,
      
      /* Datos Administrativos (Auditoría y ETags) */
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* Asociaciones Públicas */
      _TelemetryLogs
}
