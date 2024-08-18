import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';

class CostCenterDataModel extends CostCenterEntity {
  CostCenterDataModel(
      {super.id,
      super.costcenterNameAr,
      super.costcenterNameEn,
      super.level,
      super.parentId,
      super.code,
      super.costCenter,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate,
      super.items});

  CostCenterDataModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["costcenter_name_ar"] is String) {
      costcenterNameAr = json["costcenter_name_ar"];
    }
    costcenterNameEn = json["costcenter_name_en"];
    if (json["level"] is int) {
      level = json["level"];
    }
    parentId = json["parent_id"];
    if (json["code"] is String) {
      code = json["code"];
    }
    costCenter = json["costCenter"];
    if (json["userId"] is int) {
      userId = json["userId"];
    }
    lastUpdateUserId = json["lastUpdateUserId"];
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    lastUpdateDate = json["lastUpdateDate"];
    items = json["items"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["costcenter_name_ar"] = costcenterNameAr;
    _data["costcenter_name_en"] = costcenterNameEn;
    _data["level"] = level;
    _data["parent_id"] = parentId;
    _data["code"] = code;
    _data["costCenter"] = costCenter;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    _data["items"] = items;
    return _data;
  }
}
