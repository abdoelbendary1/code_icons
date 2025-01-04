import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';

class CustomerDataModel extends CustomerDataEntity {
  CustomerDataModel({
    super.idBl,
    super.brandNameBl,
    super.nationalIdBl,
    super.birthDayBl,
    super.tradeRegistryBl,
    super.licenseDateBl,
    super.licenseYearBl,
    super.capitalBl,
    super.validBl,
    super.companyTypeBl,
    super.companyTypeNameBl,
    super.currencyIdBl,
    super.tradeOfficeBl,
    super.tradeOfficeNameBl,
    super.activityBl,
    super.activityNameBl,
    super.expiredBl,
    super.divisionBl,
    super.tradeTypeBl,
    super.ownerBl,
    super.addressBl,
    super.stationBl,
    super.stationNameBl,
    super.phoneBl,
    super.numExpiredBl,
    super.tradeRegistryTypeBl,
    super.customerDataIdBl,
    super.message,
    
  });

  CustomerDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["brandNameBL"] is String) {
      brandNameBl = json["brandNameBL"];
    }
    if (json["nationalIdBL"] is String) {
      nationalIdBl = json["nationalIdBL"];
    }
    if (json["birthDayBL"] is String) {
      birthDayBl = json["birthDayBL"];
    }
    if (json["tradeRegistryBL"] is String) {
      tradeRegistryBl = json["tradeRegistryBL"];
    }
    if (json["licenseDateBL"] is String) {
      licenseDateBl = json["licenseDateBL"];
    }
    if (json["licenseYearBL"] is int) {
      licenseYearBl = json["licenseYearBL"];
    }
    if (json["capitalBL"] is double) {
      capitalBl = json["capitalBL"];
    }
    if (json["validBL"] is int) {
      validBl = json["validBL"];
    }
    if (json["companyTypeBL"] is int) {
      companyTypeBl = json["companyTypeBL"];
    }
    if (json["companyTypeNameBL"] is String) {
      companyTypeNameBl = json["companyTypeNameBL"];
    }
    if (json["currencyIdBL"] is int) {
      currencyIdBl = json["currencyIdBL"];
    }
    if (json["tradeOfficeBL"] is int) {
      tradeOfficeBl = json["tradeOfficeBL"];
    }
    if (json["tradeOfficeNameBL"] is String) {
      tradeOfficeNameBl = json["tradeOfficeNameBL"];
    }
    if (json["activityBL"] is int) {
      activityBl = json["activityBL"];
    }
    if (json["activityNameBL"] is String) {
      activityNameBl = json["activityNameBL"];
    }
    expiredBl = json["expiredBL"];
    if (json["divisionBL"] is String) {
      divisionBl = json["divisionBL"];
    }
    if (json["tradeTypeBL"] is String) {
      tradeTypeBl = json["tradeTypeBL"];
    }
    if (json["ownerBL"] is String) {
      ownerBl = json["ownerBL"];
    }
    if (json["addressBL"] is String) {
      addressBl = json["addressBL"];
    }
    if (json["stationBL"] is int) {
      stationBl = json["stationBL"];
    }
    if (json["stationNameBL"] is String) {
      stationNameBl = json["stationNameBL"];
    }
    if (json["phoneBL"] is String) {
      phoneBl = json["phoneBL"];
    }
    numExpiredBl = json["numExpiredBL"];
    if (json["tradeRegistryTypeBL"] is int) {
      tradeRegistryTypeBl = json["tradeRegistryTypeBL"];
    }
    customerDataIdBl = json["customerDataIdBL"];
    if (json["message"] is String) {
      message = json["message"];
    }
   
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
    _data["message"] = message;
   

    return _data;
  }
}
