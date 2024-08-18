import 'package:code_icons/data/model/response/purchases/purchase_request/get_purchase_request_by_id/items_details_entity/items_details_data_model.dart';
import 'package:code_icons/domain/entities/get_purchase_request_by_id/get_purchase_request_by_id_entity.dart';

class GetPurchaseRequestByIdDataModel extends GetPurchaseRequestByIdEntity {
  GetPurchaseRequestByIdDataModel({
    super.itemsDetails,
    super.storeId,
    super.status,
    super.costcenter,
    super.notes,
    super.date,
    super.code,
    super.insertDate,
  });

  GetPurchaseRequestByIdDataModel.fromJson(Map<String, dynamic> json) {
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
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
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
    _data["insertDate"] = insertDate;
    return _data;
  }
}
