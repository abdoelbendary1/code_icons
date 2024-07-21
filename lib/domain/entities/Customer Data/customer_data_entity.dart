class CustomerDataEntity {
  int? idBl;
  String? brandNameBl;
  String? nationalIdBl;
  String? birthDayBl;
  String? tradeRegistryBl;
  String? licenseDateBl;
  int? licenseYearBl;
  double? capitalBl;
  int? validBl;
  int? companyTypeBl;
  String? companyTypeNameBl;
  int? currencyIdBl;
  int? tradeOfficeBl;
  String? tradeOfficeNameBl;
  int? activityBl;
  String? activityNameBl;
  dynamic expiredBl;
  String? divisionBl;
  String? tradeTypeBl;
  String? ownerBl;
  String? addressBl;
  int? stationBl;
  String? stationNameBl;
  String? phoneBl;
  dynamic numExpiredBl;
  int? tradeRegistryTypeBl;
  int? customerDataIdBl;

  CustomerDataEntity(
      {this.idBl,
      this.brandNameBl,
      this.nationalIdBl,
      this.birthDayBl,
      this.tradeRegistryBl,
      this.licenseDateBl,
      this.licenseYearBl,
      this.capitalBl,
      this.validBl,
      this.companyTypeBl,
      this.companyTypeNameBl,
      this.currencyIdBl,
      this.tradeOfficeBl,
      this.tradeOfficeNameBl,
      this.activityBl,
      this.activityNameBl,
      this.expiredBl,
      this.divisionBl,
      this.tradeTypeBl,
      this.ownerBl,
      this.addressBl,
      this.stationBl,
      this.stationNameBl,
      this.phoneBl,
      this.numExpiredBl,
      this.tradeRegistryTypeBl,
      this.customerDataIdBl});

  CustomerDataEntity.fromJson(Map<String, dynamic> json) {
    idBl = json["idBL"];
    brandNameBl = json["brandNameBL"];
    nationalIdBl = json["nationalIdBL"];
    birthDayBl = json["birthDayBL"];
    tradeRegistryBl = json["tradeRegistryBL"];
    licenseDateBl = json["licenseDateBL"];
    licenseYearBl = json["licenseYearBL"];
    capitalBl = json["capitalBL"];
    validBl = json["validBL"];
    companyTypeBl = json["companyTypeBL"];
    companyTypeNameBl = json["companyTypeNameBL"];
    currencyIdBl = json["currencyIdBL"];
    tradeOfficeBl = json["tradeOfficeBL"];
    tradeOfficeNameBl = json["tradeOfficeNameBL"];
    activityBl = json["activityBL"];
    activityNameBl = json["activityNameBL"];
    expiredBl = json["expiredBL"];
    divisionBl = json["divisionBL"];
    tradeTypeBl = json["tradeTypeBL"];
    ownerBl = json["ownerBL"];
    addressBl = json["addressBL"];
    stationBl = json["stationBL"];
    stationNameBl = json["stationNameBL"];
    phoneBl = json["phoneBL"];
    numExpiredBl = json["numExpiredBL"];
    tradeRegistryTypeBl = json["tradeRegistryTypeBL"];
    customerDataIdBl = json["customerDataIdBL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["brandNameBL"] = brandNameBl;
    _data["nationalIdBL"] = nationalIdBl;
    _data["birthDayBL"] = birthDayBl;
    _data["tradeRegistryBL"] = tradeRegistryBl;
    _data["licenseDateBL"] = licenseDateBl;
    _data["licenseYearBL"] = licenseYearBl;
    _data["capitalBL"] = capitalBl;
    _data["validBL"] = validBl;
    _data["companyTypeBL"] = companyTypeBl;
    _data["companyTypeNameBL"] = companyTypeNameBl;
    _data["currencyIdBL"] = currencyIdBl;
    _data["tradeOfficeBL"] = tradeOfficeBl;
    _data["tradeOfficeNameBL"] = tradeOfficeNameBl;
    _data["activityBL"] = activityBl;
    _data["activityNameBL"] = activityNameBl;
    _data["expiredBL"] = expiredBl;
    _data["divisionBL"] = divisionBl;
    _data["tradeTypeBL"] = tradeTypeBl;
    _data["ownerBL"] = ownerBl;
    _data["addressBL"] = addressBl;
    _data["stationBL"] = stationBl;
    _data["stationNameBL"] = stationNameBl;
    _data["phoneBL"] = phoneBl;
    _data["numExpiredBL"] = numExpiredBl;
    _data["tradeRegistryTypeBL"] = tradeRegistryTypeBl;
    _data["customerDataIdBL"] = customerDataIdBl;
    return _data;
  }
}
