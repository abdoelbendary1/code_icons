import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';

class ItemCompanyDm extends ItemCompanyEntity {
  ItemCompanyDm(
      {super.comId,
      super.comCode,
      super.comNameAr,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate,
      super.parentId,
      super.items});

  ItemCompanyDm.fromJson(Map<String, dynamic> json) {
    comId = json["comId"];
    comCode = json["comCode"];
    comNameAr = json["comNameAr"];
    userId = json["userId"];
    lastUpdateUserId = json["lastUpdateUserId"];
    insertDate = json["insertDate"];
    lastUpdateDate = json["lastUpdateDate"];
    parentId = json["parentId"];
    items = json["items"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["comId"] = comId;
    _data["comCode"] = comCode;
    _data["comNameAr"] = comNameAr;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    _data["parentId"] = parentId;
    _data["items"] = items;
    return _data;
  }
}
