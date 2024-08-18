import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';

class GetAllPurchasesRequests extends GetAllPurchasesRequestEntity {
  GetAllPurchasesRequests({
    super.id,
    super.pRRequestDetails,
    super.code,
    super.storeId,
    super.iCStore,
    super.status,
    super.costcenter,
    super.aCcCostCenter,
    super.notes,
    super.date,
    super.userId,
    super.lastUpdateUserId,
    super.insertDate,
    super.lastUpdateDate,
  });

  GetAllPurchasesRequests.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    pRRequestDetails = json["pR_RequestDetails"];
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["storeId"] is int) {
      storeId = json["storeId"];
    }
    iCStore = json["iC_Store"];
    if (json["status"] is int) {
      status = json["status"];
    }
    costcenter = json["costcenter"];
    aCcCostCenter = json["aCC_CostCenter"];
    notes = json["notes"];
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["userId"] is int) {
      userId = json["userId"];
    }
    lastUpdateUserId = json["lastUpdateUserId"];
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    lastUpdateDate = json["lastUpdateDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["pR_RequestDetails"] = pRRequestDetails;
    _data["code"] = code;
    _data["storeId"] = storeId;
    _data["iC_Store"] = iCStore;
    _data["status"] = status;
    _data["costcenter"] = costcenter;
    _data["aCC_CostCenter"] = aCcCostCenter;
    _data["notes"] = notes;
    _data["date"] = date;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    return _data;
  }
}
