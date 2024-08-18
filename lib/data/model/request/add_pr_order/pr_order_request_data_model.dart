import 'package:code_icons/data/model/request/add_pr_order/PROrderItemsDetailsDM.dart';
import 'package:code_icons/domain/entities/PR_order_entity/request/pt_orderItemsDetails.dart';
import 'package:code_icons/domain/entities/PR_order_entity/request/pr_ordrer_request.dart';

class PrOrderRequestDataModel extends PrOrdrerRequestEntity {
  PrOrderRequestDataModel(
      {super.sourceCode,
      super.storeId,
      super.vendor,
      super.notes,
      super.costcenter,
      super.date,
      super.crncId,
      super.rate,
      super.total,
      super.net,
      super.itemsDetails});

  PrOrderRequestDataModel.fromJson(Map<String, dynamic> json) {
    sourceCode = json["sourceCode"];
    if (json["storeId"] is int) {
      storeId = json["storeId"];
    }
    if (json["vendor"] is int) {
      vendor = json["vendor"];
    }
    if (json["notes"] is String) {
      notes = json["notes"];
    }
    costcenter = json["costcenter"];
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["crncId"] is int) {
      crncId = json["crncId"];
    }
    if (json["rate"] is int) {
      rate = json["rate"];
    }
    if (json["total"] is int) {
      total = json["total"];
    }
    if (json["net"] is int) {
      net = json["net"];
    }
    if (json["itemsDetails"] is List) {
      itemsDetails = json["itemsDetails"] == null
          ? null
          : (json["itemsDetails"] as List)
              .map((e) => PrOrderItemsDetailsDM.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["sourceCode"] = sourceCode;
    _data["storeId"] = storeId;
    _data["vendor"] = vendor;
    _data["notes"] = notes;
    _data["costcenter"] = costcenter;
    _data["date"] = date;
    _data["crncId"] = crncId;
    _data["rate"] = rate;
    _data["total"] = total;
    _data["net"] = net;
    if (itemsDetails != null) {
      _data["itemsDetails"] = itemsDetails?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}
