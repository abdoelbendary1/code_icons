import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';

class UnRegisteredCollectionsResponse extends UnRegisteredCollectionEntity {
  UnRegisteredCollectionsResponse(
      {super.idBl,
      super.brandNameBl,
      super.activityBl,
      super.addressBl,
      super.receiptBl,
      super.receiptDateBl,
      super.divisionBl,
      super.currentBl,
      super.totalBl});

  UnRegisteredCollectionsResponse.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["brandNameBL"] is String) {
      brandNameBl = json["brandNameBL"];
    }
    if (json["activityBL"] is String) {
      activityBl = json["activityBL"];
    }
    if (json["addressBL"] is String) {
      addressBl = json["addressBL"];
    }
    if (json["receiptBL"] is String) {
      receiptBl = json["receiptBL"];
    }
    if (json["receiptDateBL"] is String) {
      receiptDateBl = json["receiptDateBL"];
    }
    if (json["divisionBL"] is double) {
      divisionBl = json["divisionBL"];
    }
    if (json["currentBL"] is double) {
      currentBl = json["currentBL"];
    }
    if (json["totalBL"] is double) {
      totalBl = json["totalBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["brandNameBL"] = brandNameBl;
    _data["activityBL"] = activityBl;
    _data["addressBL"] = addressBl;
    _data["receiptBL"] = receiptBl;
    _data["receiptDateBL"] = receiptDateBl;
    _data["divisionBL"] = divisionBl;
    _data["currentBL"] = currentBl;
    _data["totalBL"] = totalBl;
    return _data;
  }
}
