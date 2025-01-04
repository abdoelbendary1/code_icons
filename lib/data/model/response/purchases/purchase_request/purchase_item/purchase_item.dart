import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/item_Uom/item_Uom.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';

class PurchaseItemDataModel extends PurchaseItemEntity {
  PurchaseItemDataModel(
      {super.itemId,
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
      super.matrix});

  PurchaseItemDataModel.fromJson(Map<String, dynamic> json) {
    itemId = (json["itemId"] is double)
        ? (json["itemId"] as double).toInt()
        : json["itemId"];
    itemCode1 = (json["itemCode1"] is double)
        ? (json["itemCode1"] as double).toInt()
        : json["itemCode1"];
    itemCode2 = json["itemCode2"];
    itemNameAr = json["itemNameAr"];
    itemNameEn = json["itemNameEn"];
    description = json["description"];
    category = (json["category"] is double)
        ? (json["category"] as double).toInt()
        : json["category"];
    company = (json["company"] is double)
        ? (json["company"] as double).toInt()
        : json["company"];
    itemType = (json["itemType"] is double)
        ? (json["itemType"] as double).toInt()
        : json["itemType"];
    isExpire = json["isExpire"];
    expireMonth = (json["expireMonth"] is double)
        ? (json["expireMonth"] as double).toInt()
        : json["expireMonth"];
    itemUom = json["itemUom"] == null
        ? null
        : (json["itemUom"] as List)
            .map((e) => ItemUomDataModel.fromJson(e))
            .toList();
    itemTaxsRelation = json["itemTaxsRelation"];
    itemReviews = json["itemReviews"];
    images = json["images"];
    smallUom = (json["smallUOM"] is double)
        ? (json["smallUOM"] as double).toInt()
        : json["smallUOM"];
    smallUomPrice = (json["smallUOMPrice"] is double)
        ? (json["smallUOMPrice"] as double).toInt()
        : json["smallUOMPrice"];
    smallUoMprPrice = (json["smallUOMprPrice"] is double)
        ? (json["smallUOMprPrice"] as double).toInt()
        : json["smallUOMprPrice"];
    mediumUom = json["mediumUOM"];
    mediumUomFactor = json["mediumUOMFactor"];
    mediumUomPrice = (json["mediumUOMPrice"] is double)
        ? (json["mediumUOMPrice"] as double).toInt()
        : json["mediumUOMPrice"];
    mediumUoMprPrice = (json["mediumUOMprPrice"] is double)
        ? (json["mediumUOMprPrice"] as double).toInt()
        : json["mediumUOMprPrice"];
    largeUom = json["largeUOM"];
    largeUomFactor = json["largeUOMFactor"];
    largeUomPrice = (json["largeUOMPrice"] is double)
        ? (json["largeUOMPrice"] as double).toInt()
        : json["largeUOMPrice"];
    largeUoMprPrice = (json["largeUOMprPrice"] is double)
        ? (json["largeUOMprPrice"] as double).toInt()
        : json["largeUOMprPrice"];
    dfltSellUomIndx = (json["dfltSellUomIndx"] is double)
        ? (json["dfltSellUomIndx"] as double).toInt()
        : json["dfltSellUomIndx"];
    dfltPrchsUomIndx = (json["dfltPrchsUomIndx"] is double)
        ? (json["dfltPrchsUomIndx"] as double).toInt()
        : json["dfltPrchsUomIndx"];
    reorderLevel = (json["reorderLevel"] is double)
        ? (json["reorderLevel"] as double).toInt()
        : json["reorderLevel"];
    maxQty = (json["maxQty"] is double)
        ? (json["maxQty"] as double).toInt()
        : json["maxQty"];
    minQty = (json["minQty"] is double)
        ? (json["minQty"] as double).toInt()
        : json["minQty"];
    currentQty = (json["currentQTY"] is double)
        ? (json["currentQTY"] as double).toInt()
        : json["currentQTY"];
    calcBeforeDisc = json["calcBeforeDisc"];
    price = (json["price"] is double)
        ? (json["price"] as double).toInt()
        : json["price"];
    discount = (json["discount"] is double)
        ? (json["discount"] as double).toInt()
        : json["discount"];
    length = (json["length"] is double)
        ? (json["length"] as double).toInt()
        : json["length"];
    width = (json["width"] is double)
        ? (json["width"] as double).toInt()
        : json["width"];
    height = (json["height"] is double)
        ? (json["height"] as double).toInt()
        : json["height"];
    insertDate = json["insertDate"];
    matrixId = json["matrixId"];
    matrix = json["matrix"];
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
    return _data;
  }
}
