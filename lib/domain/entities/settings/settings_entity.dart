import 'package:hive/hive.dart';

@HiveType(typeId: 3) // Ensure the typeId is unique
class SettingsEntity extends HiveObject {
  @HiveField(0)
  String? collections;

  @HiveField(1)
  String? finance;

  @HiveField(2)
  String? cashInOut;

  @HiveField(3)
  String? purchases;

  @HiveField(4)
  String? sales;

  @HiveField(5)
  String? costructions;

  @HiveField(6)
  String? charterparty;

  @HiveField(7)
  String? humanResources;

  @HiveField(8)
  String? stores;

  @HiveField(9)
  String? reports;

  @HiveField(10)
  String? realStateInvestments;

  @HiveField(11)
  String? imports;

  @HiveField(12)
  String? hospital;
  @HiveField(13)
  String? settings;

  int? id;
  int? mainCrnc;
  dynamic currency;
  bool? isStoreOnEachPurchRecord;
  bool? prInvoicePostToStore;

  SettingsEntity(
      {this.id,
      this.mainCrnc,
      this.currency,
      this.isStoreOnEachPurchRecord,
      this.prInvoicePostToStore,
      this.finance,
      this.cashInOut,
      this.purchases,
      this.sales,
      this.costructions,
      this.charterparty,
      this.humanResources,
      this.stores,
      this.reports,
      this.settings,
      this.realStateInvestments,
      this.imports,
      this.hospital,
      this.collections});
}
