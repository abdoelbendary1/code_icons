import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/domain/entities/get_purchase_request_by_id/items_details_entity/items_details_entity.dart';

class PurchaseRequestDataModel {
  List<InvoiceItemDetailsDm>? itemsDetails;
  String? date;
  String? status;
  int? storeId;

  PurchaseRequestDataModel(
      {this.itemsDetails, this.date, this.status, this.storeId});

  PurchaseRequestDataModel.fromJson(Map<String, dynamic> json) {
    if (json["itemsDetails"] is List) {
      itemsDetails = json["itemsDetails"] == null
          ? null
          : (json["itemsDetails"] as List)
              .map((e) => InvoiceItemDetailsDm.fromJson(e))
              .toList();
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["storeId"] is int) {
      storeId = json["storeId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (itemsDetails != null) {
      _data["itemsDetails"] = itemsDetails?.map((e) => e.toJson()).toList();
    }
    _data["date"] = date;
    _data["status"] = status;
    _data["storeId"] = storeId;
    return _data;
  }
}

class ItemsDetails extends ItemsDetailsEntity {
  ItemsDetails(
      {super.itemCode1,
      super.itemNameAr,
      super.qty,
      super.uom,
      super.description,
      super.id});

  ItemsDetails.fromJson(Map<String, dynamic> json) {
    if (json["itemCode1"] is int) {
      itemCode1 = json["itemCode1"];
    }
    if (json["itemNameAr"] is int) {
      itemNameAr = json["itemNameAr"];
    }
    if (json["qty"] is int) {
      qty = json["qty"];
    }
    if (json["uom"] is int) {
      uom = json["uom"];
    }
    if (json["prprice"] is int) {
      description = json["description"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemCode1"] = itemCode1;
    _data["itemNameAr"] = itemNameAr;
    _data["qty"] = qty;
    _data["uom"] = uom;
    _data["description"] = description;
    _data["id"] = id;
    return _data;
  }
}
