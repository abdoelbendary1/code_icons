import 'package:code_icons/data/model/response/get_purchase_request_by_id/items_details_entity/items_details_data_model.dart';

class AddPurchaseRequest {
  List<ItemsDetailsDataModel>? itemsDetails;
  int? storeId;
  int? status;
  dynamic costcenter;
  dynamic notes;
  String? date;
  String? code;

  AddPurchaseRequest(
      {this.itemsDetails,
      this.storeId,
      this.status,
      this.costcenter,
      this.notes,
      this.date,
      this.code});

  AddPurchaseRequest.fromJson(Map<String, dynamic> json) {
    if (json["itemsDetails"] is List) {
      itemsDetails = json["itemsDetails"] == null
          ? null
          : (json["itemsDetails"] as List)
              .map((e) => ItemsDetailsDataModel.fromJson(e))
              .toList();
    }
    if (json["storeId"] is int) {
      storeId = json["storeId"];
    }
    if (json["status"] is int) {
      status = json["status"];
    }
    costcenter = json["costcenter"];
    notes = json["notes"];
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (itemsDetails != null) {
      _data["itemsDetails"] = itemsDetails?.map((e) => e.toJson()).toList();
    }
    _data["storeId"] = storeId;
    _data["status"] = status;
    _data["costcenter"] = costcenter;
    _data["notes"] = notes;
    _data["date"] = date;
    _data["code"] = code;
    return _data;
  }
}

class ItemsDetails {
  int? itemCode1;
  int? itemNameAr;
  int? uom;
  int? qty;
  dynamic description;
  String? id;

  ItemsDetails(
      {this.itemCode1,
      this.itemNameAr,
      this.uom,
      this.qty,
      this.description,
      this.id});

  ItemsDetails.fromJson(Map<String, dynamic> json) {
    if (json["itemCode1"] is int) {
      itemCode1 = json["itemCode1"];
    }
    if (json["itemNameAr"] is int) {
      itemNameAr = json["itemNameAr"];
    }
    if (json["uom"] is int) {
      uom = json["uom"];
    }
    if (json["qty"] is int) {
      qty = json["qty"];
    }
    description = json["description"];
    if (json["id"] is String) {
      id = json["id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemCode1"] = itemCode1;
    _data["itemNameAr"] = itemNameAr;
    _data["uom"] = uom;
    _data["qty"] = qty;
    _data["description"] = description;
    _data["id"] = id;
    return _data;
  }
}
