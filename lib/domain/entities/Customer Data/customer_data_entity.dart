import 'package:animated_custom_dropdown/custom_dropdown.dart';

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
  String? message;
  @override
  String toString() {
    return "${tradeRegistryBl.toString()} ${brandNameBl}";
  }

  String toTradeRegistryBl() {
    return tradeRegistryBl.toString();
  }

  CustomerDataEntity({
    this.idBl,
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
    this.customerDataIdBl,
    this.message,
  });
}
