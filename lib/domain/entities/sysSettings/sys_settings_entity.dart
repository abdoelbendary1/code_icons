class SysSettingsEntity {
  dynamic idBl;
  int? defultCurrencyBl;
  int? salesWorkCycleBl;
  int? purchaseWorkCycleBl;
  bool? supportsDimensionsBl;
  dynamic lengthBl;
  dynamic widthBl;
  dynamic heightBl;
  bool? salesPriceIncludesTaxesBl;
  bool? purchasePriceIncludesTaxesBl;
  dynamic dimensionsUseBl;
  bool? supportsValidityDatesBl;
  bool? smallUomForPriceBl;
  bool? calculateBasedOnStageBl;
  bool? dependOnExecutiveChartDatesBl;
  double? minimumWageBl;
  double? maximumWageBl;
  double? employeeRateBl;
  double? companyRateBl;
  double? taxExemptionLimitBl;
  dynamic dueDateCalculationBl;
  bool? custodySettleOneTimeBl;
  int? accountCodingBl;
  bool? supportsExpireDateBl;
  bool? supportsBatchNumberBl;
  bool? showStatisticsBl;
  String? defaultCountryBl;

  SysSettingsEntity(
      {this.idBl,
      this.defultCurrencyBl,
      this.salesWorkCycleBl,
      this.purchaseWorkCycleBl,
      this.supportsDimensionsBl,
      this.lengthBl,
      this.widthBl,
      this.heightBl,
      this.salesPriceIncludesTaxesBl,
      this.purchasePriceIncludesTaxesBl,
      this.dimensionsUseBl,
      this.supportsValidityDatesBl,
      this.smallUomForPriceBl,
      this.calculateBasedOnStageBl,
      this.dependOnExecutiveChartDatesBl,
      this.minimumWageBl,
      this.maximumWageBl,
      this.employeeRateBl,
      this.companyRateBl,
      this.taxExemptionLimitBl,
      this.dueDateCalculationBl,
      this.custodySettleOneTimeBl,
      this.accountCodingBl,
      this.supportsExpireDateBl,
      this.supportsBatchNumberBl,
      this.showStatisticsBl,
      this.defaultCountryBl});
}
