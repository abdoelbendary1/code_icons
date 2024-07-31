import 'package:code_icons/domain/entities/settings/settings_entity.dart';

class SettingsDataModel extends SettingsEntity {
  SettingsDataModel({
    super.id,
    super.mainCrnc,
    super.currency,
    super.isStoreOnEachPurchRecord,
    super.prInvoicePostToStore,
    super.finance,
    super.cashInOut,
    super.purchases,
    super.sales,
    super.costructions,
    super.charterparty,
    super.humanResources,
    super.stores,
    super.reports,
    super.settings,
    super.realStateInvestments,
    super.imports,
    super.hospital,
    super.collections,
  });

  SettingsDataModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["mainCrnc"] is int) {
      mainCrnc = json["mainCrnc"];
    }
    currency = json["currency"];
    if (json["isStoreOnEachPurchRecord"] is bool) {
      isStoreOnEachPurchRecord = json["isStoreOnEachPurchRecord"];
    }
    if (json["prInvoicePostToStore"] is bool) {
      prInvoicePostToStore = json["prInvoicePostToStore"];
    }
    if (json["finance"] is String) {
      finance = json["finance"];
    }
    if (json["cashInOut"] is String) {
      cashInOut = json["cashInOut"];
    }
    if (json["purchases"] is String) {
      purchases = json["purchases"];
    }
    if (json["sales"] is String) {
      sales = json["sales"];
    }
    if (json["costructions"] is String) {
      costructions = json["costructions"];
    }
    if (json["charterparty"] is String) {
      charterparty = json["charterparty"];
    }
    if (json["humanResources"] is String) {
      humanResources = json["humanResources"];
    }
    if (json["stores"] is String) {
      stores = json["stores"];
    }
    if (json["reports"] is String) {
      reports = json["reports"];
    }
    if (json["settings"] is String) {
      settings = json["settings"];
    }
    if (json["realStateInvestments"] is String) {
      realStateInvestments = json["realStateInvestments"];
    }
    if (json["imports"] is String) {
      imports = json["imports"];
    }
    if (json["hospital"] is String) {
      hospital = json["hospital"];
    }
    if (json["collections"] is String) {
      collections = json["collections"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["mainCrnc"] = mainCrnc;
    _data["currency"] = currency;
    _data["isStoreOnEachPurchRecord"] = isStoreOnEachPurchRecord;
    _data["prInvoicePostToStore"] = prInvoicePostToStore;
    _data["finance"] = finance;
    _data["cashInOut"] = cashInOut;
    _data["purchases"] = purchases;
    _data["sales"] = sales;
    _data["costructions"] = costructions;
    _data["charterparty"] = charterparty;
    _data["humanResources"] = humanResources;
    _data["stores"] = stores;
    _data["reports"] = reports;
    _data["settings"] = settings;
    _data["realStateInvestments"] = realStateInvestments;
    _data["imports"] = imports;
    _data["hospital"] = hospital;
    _data["collections"] = collections;
    return _data;
  }
}
