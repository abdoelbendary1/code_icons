import 'package:code_icons/domain/entities/sysSettings/sys_settings_entity.dart';

class SysSettingsDM extends SysSettingsEntity {
  SysSettingsDM(
      {super.idBl,
      super.defultCurrencyBl,
      super.salesWorkCycleBl,
      super.purchaseWorkCycleBl,
      super.supportsDimensionsBl,
      super.lengthBl,
      super.widthBl,
      super.heightBl,
      super.salesPriceIncludesTaxesBl,
      super.purchasePriceIncludesTaxesBl,
      super.dimensionsUseBl,
      super.supportsValidityDatesBl,
      super.smallUomForPriceBl,
      super.calculateBasedOnStageBl,
      super.dependOnExecutiveChartDatesBl,
      super.minimumWageBl,
      super.maximumWageBl,
      super.employeeRateBl,
      super.companyRateBl,
      super.taxExemptionLimitBl,
      super.dueDateCalculationBl,
      super.custodySettleOneTimeBl,
      super.accountCodingBl,
      super.supportsExpireDateBl,
      super.supportsBatchNumberBl,
      super.showStatisticsBl,
      super.defaultCountryBl});

  SysSettingsDM.fromJson(Map<String, dynamic> json) {
    idBl = json["idBL"];
    defultCurrencyBl = json["defultCurrencyBL"];
    salesWorkCycleBl = json["salesWorkCycleBL"];
    purchaseWorkCycleBl = json["purchaseWorkCycleBL"];
    supportsDimensionsBl = json["supportsDimensionsBL"];
    lengthBl = json["lengthBL"];
    widthBl = json["widthBL"];
    heightBl = json["heightBL"];
    salesPriceIncludesTaxesBl = json["salesPriceIncludesTaxesBL"];
    purchasePriceIncludesTaxesBl = json["purchasePriceIncludesTaxesBL"];
    dimensionsUseBl = json["dimensionsUseBL"];
    supportsValidityDatesBl = json["supportsValidityDatesBL"];
    smallUomForPriceBl = json["smallUOMForPriceBL"];
    calculateBasedOnStageBl = json["calculateBasedOnStageBL"];
    dependOnExecutiveChartDatesBl = json["dependOnExecutiveChartDatesBL"];
    minimumWageBl = json["minimumWageBL"];
    maximumWageBl = json["maximumWageBL"];
    employeeRateBl = json["employeeRateBL"];
    companyRateBl = json["companyRateBL"];
    taxExemptionLimitBl = json["taxExemptionLimitBL"];
    dueDateCalculationBl = json["dueDateCalculationBL"];
    custodySettleOneTimeBl = json["custodySettleOneTimeBL"];
    accountCodingBl = json["accountCodingBL"];
    supportsExpireDateBl = json["supportsExpireDateBL"];
    supportsBatchNumberBl = json["supportsBatchNumberBL"];
    showStatisticsBl = json["showStatisticsBL"];
    defaultCountryBl = json["defaultCountryBL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["defultCurrencyBL"] = defultCurrencyBl;
    _data["salesWorkCycleBL"] = salesWorkCycleBl;
    _data["purchaseWorkCycleBL"] = purchaseWorkCycleBl;
    _data["supportsDimensionsBL"] = supportsDimensionsBl;
    _data["lengthBL"] = lengthBl;
    _data["widthBL"] = widthBl;
    _data["heightBL"] = heightBl;
    _data["salesPriceIncludesTaxesBL"] = salesPriceIncludesTaxesBl;
    _data["purchasePriceIncludesTaxesBL"] = purchasePriceIncludesTaxesBl;
    _data["dimensionsUseBL"] = dimensionsUseBl;
    _data["supportsValidityDatesBL"] = supportsValidityDatesBl;
    _data["smallUOMForPriceBL"] = smallUomForPriceBl;
    _data["calculateBasedOnStageBL"] = calculateBasedOnStageBl;
    _data["dependOnExecutiveChartDatesBL"] = dependOnExecutiveChartDatesBl;
    _data["minimumWageBL"] = minimumWageBl;
    _data["maximumWageBL"] = maximumWageBl;
    _data["employeeRateBL"] = employeeRateBl;
    _data["companyRateBL"] = companyRateBl;
    _data["taxExemptionLimitBL"] = taxExemptionLimitBl;
    _data["dueDateCalculationBL"] = dueDateCalculationBl;
    _data["custodySettleOneTimeBL"] = custodySettleOneTimeBl;
    _data["accountCodingBL"] = accountCodingBl;
    _data["supportsExpireDateBL"] = supportsExpireDateBl;
    _data["supportsBatchNumberBL"] = supportsBatchNumberBl;
    _data["showStatisticsBL"] = showStatisticsBl;
    _data["defaultCountryBL"] = defaultCountryBl;
    return _data;
  }
}
