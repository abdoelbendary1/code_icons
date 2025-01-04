import 'package:hive/hive.dart';

@HiveType(typeId: 2)
// Assign a unique typeId
class CustomerDataEntity extends HiveObject {
  @HiveField(0)
  int? idBl;

  @HiveField(1)
  String? brandNameBl;

  @HiveField(2)
  String? nationalIdBl;

  @HiveField(3)
  String? birthDayBl;

  @HiveField(4)
  String? tradeRegistryBl;

  @HiveField(5)
  String? licenseDateBl;

  @HiveField(6)
  int? licenseYearBl;

  @HiveField(7)
  double? capitalBl;

  @HiveField(8)
  int? validBl;

  @HiveField(9)
  int? companyTypeBl;

  @HiveField(10)
  String? companyTypeNameBl;

  @HiveField(11)
  int? currencyIdBl;

  @HiveField(12)
  int? tradeOfficeBl;

  @HiveField(13)
  String? tradeOfficeNameBl;

  @HiveField(14)
  int? activityBl;

  @HiveField(15)
  String? activityNameBl;

  @HiveField(16)
  dynamic expiredBl;

  @HiveField(17)
  String? divisionBl;

  @HiveField(18)
  String? tradeTypeBl;

  @HiveField(19)
  String? ownerBl;

  @HiveField(20)
  String? addressBl;

  @HiveField(21)
  int? stationBl;

  @HiveField(22)
  String? stationNameBl;

  @HiveField(23)
  String? phoneBl;

  @HiveField(24)
  dynamic numExpiredBl;

  @HiveField(25)
  int? tradeRegistryTypeBl;

  @HiveField(26)
  int? customerDataIdBl;

  @HiveField(27)
  String? message;
 

  /*  @override
  String toString() {
    return brandNameBl!;
  } */

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
