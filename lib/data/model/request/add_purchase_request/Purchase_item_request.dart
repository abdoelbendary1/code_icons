import 'package:code_icons/data/model/response/purchase_item/item_Uom/item_Uom.dart';
import 'package:code_icons/domain/entities/purchase_item/itemUom/item_Uom.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';

class PurchaseItemRequestDataModel extends PurchaseItemEntity {
  int? uom;
  PurchaseItemRequestDataModel({
    super.itemId,
    super.itemCode1,
    super.itemCode2,
    super.itemNameAr,
    super.itemNameEn,
    super.description,
    super.category,
    super.company,
    super.itemType,
    super.isExpire,
    super.expireMonth,
    super.itemUom,
    super.itemTaxsRelation,
    super.itemReviews,
    super.images,
    super.smallUom,
    super.smallUomPrice,
    super.smallUoMprPrice,
    super.mediumUom,
    super.mediumUomFactor,
    super.mediumUomPrice,
    super.mediumUoMprPrice,
    super.largeUom,
    super.largeUomFactor,
    super.largeUomPrice,
    super.largeUoMprPrice,
    super.dfltSellUomIndx,
    super.dfltPrchsUomIndx,
    super.reorderLevel,
    super.maxQty,
    super.minQty,
    super.currentQty,
    super.calcBeforeDisc,
    super.price,
    super.discount,
    super.length,
    super.width,
    super.height,
    super.insertDate,
    super.matrixId,
    super.matrix,
    this.uom,
  });

  PurchaseItemRequestDataModel.fromJson(Map<String, dynamic> json) {
    if (json["itemId"] is int) {
      itemId = json["itemId"];
    }
    if (json["itemCode1"] is int) {
      itemCode1 = json["itemCode1"];
    }
    if (json["itemCode2"] is String) {
      itemCode2 = json["itemCode2"];
    }
    if (json["itemNameAr"] is String) {
      itemNameAr = json["itemNameAr"];
    }
    itemNameEn = json["itemNameEn"];
    description = json["description"];
    if (json["category"] is int) {
      category = json["category"];
    }
    if (json["company"] is int) {
      company = json["company"];
    }
    if (json["itemType"] is int) {
      itemType = json["itemType"];
    }
    if (json["isExpire"] is bool) {
      isExpire = json["isExpire"];
    }
    if (json["expireMonth"] is int) {
      expireMonth = json["expireMonth"];
    }
    if (json["itemUom"] is List) {
      itemUom = json["itemUom"] == null
          ? null
          : (json["itemUom"] as List)
              .map((e) => ItemUomDataModel.fromJson(e))
              .toList();
    }
    if (json["itemTaxsRelation"] is List) {
      itemTaxsRelation = json["itemTaxsRelation"] ?? [];
    }
    if (json["itemReviews"] is List) {
      itemReviews = json["itemReviews"] ?? [];
    }
    if (json["images"] is List) {
      images = json["images"] ?? [];
    }
    if (json["smallUOM"] is int) {
      smallUom = json["smallUOM"];
    }
    if (json["smallUOMPrice"] is int) {
      smallUomPrice = json["smallUOMPrice"];
    }
    if (json["smallUOMprPrice"] is int) {
      smallUoMprPrice = json["smallUOMprPrice"];
    }
    mediumUom = json["mediumUOM"];
    mediumUomFactor = json["mediumUOMFactor"];
    if (json["mediumUOMPrice"] is int) {
      mediumUomPrice = json["mediumUOMPrice"];
    }
    if (json["mediumUOMprPrice"] is int) {
      mediumUoMprPrice = json["mediumUOMprPrice"];
    }
    largeUom = json["largeUOM"];
    largeUomFactor = json["largeUOMFactor"];
    if (json["largeUOMPrice"] is int) {
      largeUomPrice = json["largeUOMPrice"];
    }
    if (json["largeUOMprPrice"] is int) {
      largeUoMprPrice = json["largeUOMprPrice"];
    }
    if (json["dfltSellUomIndx"] is int) {
      dfltSellUomIndx = json["dfltSellUomIndx"];
    }
    if (json["dfltPrchsUomIndx"] is int) {
      dfltPrchsUomIndx = json["dfltPrchsUomIndx"];
    }
    if (json["reorderLevel"] is int) {
      reorderLevel = json["reorderLevel"];
    }
    if (json["maxQty"] is int) {
      maxQty = json["maxQty"];
    }
    if (json["minQty"] is int) {
      minQty = json["minQty"];
    }
    if (json["currentQTY"] is int) {
      currentQty = json["currentQTY"];
    }
    if (json["calcBeforeDisc"] is bool) {
      calcBeforeDisc = json["calcBeforeDisc"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["discount"] is int) {
      discount = json["discount"];
    }
    if (json["length"] is int) {
      length = json["length"];
    }
    if (json["width"] is int) {
      width = json["width"];
    }
    if (json["height"] is int) {
      height = json["height"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    matrixId = json["matrixId"];
    matrix = json["matrix"];
    uom = json["uom"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemId"] = itemId;
    _data["itemCode1"] = itemCode1;
    _data["itemCode2"] = itemCode2;
    _data["itemNameAr"] = itemNameAr;
    _data["itemNameEn"] = itemNameEn;
    _data["description"] = description;
    _data["category"] = category;
    _data["company"] = company;
    _data["itemType"] = itemType;
    _data["isExpire"] = isExpire;
    _data["expireMonth"] = expireMonth;
    if (itemUom != null) {
      _data["itemUom"] = itemUom?.map((e) => e.toJson()).toList();
    }
    if (itemTaxsRelation != null) {
      _data["itemTaxsRelation"] = itemTaxsRelation;
    }
    if (itemReviews != null) {
      _data["itemReviews"] = itemReviews;
    }
    if (images != null) {
      _data["images"] = images;
    }
    _data["smallUOM"] = smallUom;
    _data["smallUOMPrice"] = smallUomPrice;
    _data["smallUOMprPrice"] = smallUoMprPrice;
    _data["mediumUOM"] = mediumUom;
    _data["mediumUOMFactor"] = mediumUomFactor;
    _data["mediumUOMPrice"] = mediumUomPrice;
    _data["mediumUOMprPrice"] = mediumUoMprPrice;
    _data["largeUOM"] = largeUom;
    _data["largeUOMFactor"] = largeUomFactor;
    _data["largeUOMPrice"] = largeUomPrice;
    _data["largeUOMprPrice"] = largeUoMprPrice;
    _data["dfltSellUomIndx"] = dfltSellUomIndx;
    _data["dfltPrchsUomIndx"] = dfltPrchsUomIndx;
    _data["reorderLevel"] = reorderLevel;
    _data["maxQty"] = maxQty;
    _data["minQty"] = minQty;
    _data["currentQTY"] = currentQty;
    _data["calcBeforeDisc"] = calcBeforeDisc;
    _data["price"] = price;
    _data["discount"] = discount;
    _data["length"] = length;
    _data["width"] = width;
    _data["height"] = height;
    _data["insertDate"] = insertDate;
    _data["matrixId"] = matrixId;
    _data["matrix"] = matrix;
    _data["uom"] = uom;

    return _data;
  }
}
