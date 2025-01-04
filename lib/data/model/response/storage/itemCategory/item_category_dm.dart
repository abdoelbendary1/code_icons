import 'package:code_icons/domain/entities/storage/itemCategory/item_category_entity.dart';

class ItemCategoryDm extends ItemCategoryEntity {
  ItemCategoryDm(
      {super.catId,
      super.catCode,
      super.catNameAr,
      super.calcMethodIdBl,
      super.calcMethod,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate,
      super.parentId,
      super.items,
      super.imagePath,
      super.images});

  ItemCategoryDm.fromJson(Map<String, dynamic> json) {
    catId = json["catId"];
    catCode = json["catCode"];
    catNameAr = json["catNameAr"];
    calcMethodIdBl = json["calcMethodIdBL"];
    calcMethod = json["calcMethod"];
    userId = json["userId"];
    lastUpdateUserId = json["lastUpdateUserId"];
    insertDate = json["insertDate"];
    lastUpdateDate = json["lastUpdateDate"];
    parentId = json["parentId"];
    items = json["items"];
    imagePath = json["imagePath"];
    images = json["images"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["catId"] = catId;
    _data["catCode"] = catCode;
    _data["catNameAr"] = catNameAr;
    _data["calcMethodIdBL"] = calcMethodIdBl;
    _data["calcMethod"] = calcMethod;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    _data["parentId"] = parentId;
    _data["items"] = items;
    _data["imagePath"] = imagePath;
    _data["images"] = images;
    return _data;
  }
}
