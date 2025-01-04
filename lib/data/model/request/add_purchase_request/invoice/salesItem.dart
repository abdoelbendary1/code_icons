// ignore_for_file: public_member_api_docs, sort_constructors_first
class SalesItemDm {
  int? itemId;
  int? itemCode1;
  dynamic itemCode2;
  String? itemNameAr;
  dynamic itemNameEn;
  dynamic description;
  int? category;
  int? company;
  int? itemType;
  bool? isExpire;
  double? expireMonth;
  List<SalesItemUom>? itemUom;
  List<ItemTaxsRelation>? itemTaxsRelation;
  List<dynamic>? itemReviews;
  List<dynamic>? images;
  int? smallUOM;
  double? smallUOMPrice;
  double? smallUOMprPrice;
  dynamic mediumUom;
  dynamic mediumUomFactor;
  double? mediumUomPrice;
  double? mediumUoMprPrice;
  dynamic largeUom;
  dynamic largeUomFactor;
  double? largeUomPrice;
  double? largeUoMprPrice;
  int? dfltSellUomIndx;
  int? dfltPrchsUomIndx;
  int? reorderLevel;
  int? maxQty;
  int? minQty;
  double? currentQty;
  bool? calcBeforeDisc;
  double? price;
  double? discount;
  double? length;
  double? width;
  double? height;
  String? insertDate;
  dynamic matrixId;
  dynamic matrix;

  SalesItemDm(
      {this.itemId,
      this.itemCode1,
      this.itemCode2,
      this.itemNameAr,
      this.itemNameEn,
      this.description,
      this.category,
      this.company,
      this.itemType,
      this.isExpire,
      this.expireMonth,
      this.itemUom,
      this.itemTaxsRelation,
      this.itemReviews,
      this.images,
      this.smallUOM,
      this.smallUOMPrice,
      this.smallUOMprPrice,
      this.mediumUom,
      this.mediumUomFactor,
      this.mediumUomPrice,
      this.mediumUoMprPrice,
      this.largeUom,
      this.largeUomFactor,
      this.largeUomPrice,
      this.largeUoMprPrice,
      this.dfltSellUomIndx,
      this.dfltPrchsUomIndx,
      this.reorderLevel,
      this.maxQty,
      this.minQty,
      this.currentQty,
      this.calcBeforeDisc,
      this.price,
      this.discount,
      this.length,
      this.width,
      this.height,
      this.insertDate,
      this.matrixId,
      this.matrix});

  SalesItemDm.fromJson(Map<String, dynamic> json) {
    itemId = json["itemId"];
    itemCode1 = json["itemCode1"];
    itemCode2 = json["itemCode2"];
    itemNameAr = json["itemNameAr"];
    itemNameEn = json["itemNameEn"];
    description = json["description"];
    category = json["category"];
    company = json["company"];
    itemType = json["itemType"];
    isExpire = json["isExpire"];
    expireMonth = json["expireMonth"];
    itemUom = json["itemUom"] == null
        ? null
        : (json["itemUom"] as List)
            .map((e) => SalesItemUom.fromJson(e))
            .toList();
    itemTaxsRelation = json["itemTaxsRelation"] == null
        ? null
        : (json["itemTaxsRelation"] as List)
            .map((e) => ItemTaxsRelation.fromJson(e))
            .toList();
    itemReviews = json["itemReviews"] ?? [];
    images = json["images"] ?? [];
    smallUOM = json["smallUOM"];
    smallUOMPrice = json["smallUOMPrice"];
    smallUOMprPrice = json["smallUOMprPrice"];
    mediumUom = json["mediumUOM"];
    mediumUomFactor = json["mediumUOMFactor"];
    mediumUomPrice = json["mediumUOMPrice"];
    mediumUoMprPrice = json["mediumUOMprPrice"];
    largeUom = json["largeUOM"];
    largeUomFactor = json["largeUOMFactor"];
    largeUomPrice = json["largeUOMPrice"];
    largeUoMprPrice = json["largeUOMprPrice"];
    dfltSellUomIndx = json["dfltSellUomIndx"];
    dfltPrchsUomIndx = json["dfltPrchsUomIndx"];
    reorderLevel = json["reorderLevel"];
    maxQty = json["maxQty"];
    minQty = json["minQty"];
    currentQty = json["currentQTY"];
    calcBeforeDisc = json["calcBeforeDisc"];
    price = json["price"];
    discount = json["discount"];
    length = json["length"];
    width = json["width"];
    height = json["height"];
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
      _data["itemTaxsRelation"] =
          itemTaxsRelation?.map((e) => e.toJson()).toList();
    }
    if (itemReviews != null) {
      _data["itemReviews"] = itemReviews;
    }
    if (images != null) {
      _data["images"] = images;
    }
    _data["smallUOM"] = smallUOM;
    _data["smallUOMPrice"] = smallUOMPrice;
    _data["smallUOMprPrice"] = smallUOMprPrice;
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

  @override
  String toString() {
    return ' $itemCode1 $itemNameAr';
  }
}

class ItemTaxsRelation {
  int? id;
  dynamic? itemId;
  IcItem? iCItem;
  int? eTaxId;
  int? eTax;
  double? percentage;
  dynamic calcBeforeDisc;

  ItemTaxsRelation(
      {this.id,
      this.itemId,
      this.iCItem,
      this.eTaxId,
      this.eTax,
      this.percentage,
      this.calcBeforeDisc});

  ItemTaxsRelation.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    itemId = json["item_id"].toString();
    iCItem = json["iC_Item"] == null ? null : IcItem.fromJson(json["iC_Item"]);
    print("eTax_Id from JSON: ${json['eTax_Id']} before");
    eTaxId = json["eTax_Id"] ?? json["eTax_id"];

    print("eTax_Id from JSON: ${json['eTax_Id']} after");

    /* eTaxId = json["eTax_Id"] != null
        ? int.tryParse(json["eTax_Id"].toString())
        : null; */

    eTax = json["eTax"];
    percentage = json["percentage"];
    calcBeforeDisc = json["calcBeforeDisc"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["item_id"] = itemId;
    if (iCItem != null) {
      _data["iC_Item"] = iCItem?.toJson();
    }
    _data["eTax_Id"] = eTaxId;
    _data["eTax"] = eTax;
    _data["percentage"] = percentage;
    _data["calcBeforeDisc"] = calcBeforeDisc;
    return _data;
  }
}

class IcItem {
  int? itemId;
  int? itemCode1;
  dynamic itemCode2;
  String? itemNameAr;
  dynamic itemNameEn;
  dynamic description;
  dynamic matrixId;
  dynamic iCMatrix;
  int? category;
  dynamic iCCategory;
  int? company;
  dynamic iCCompany;
  int? itemType;
  bool? isExpire;
  double? expireMonth;
  int? smallUOM;
  double? smallUOMPrice;
  double? smallUOMprPrice;
  dynamic mediumUom;
  dynamic mediumUomFactor;
  double? mediumUomPrice;
  double? mediumUoMprPrice;
  dynamic largeUom;
  dynamic largeUomFactor;
  double? largeUomPrice;
  double? largeUoMprPrice;
  int? dfltSellUomIndx;
  int? dfltPrchsUomIndx;
  int? reorderLevel;
  int? maxQty;
  bool? calcBeforeDisc;
  int? minQty;
  double? price;
  double? discount;
  double? length;
  double? width;
  double? height;
  int? userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;
  dynamic images;
  List<dynamic>? itemTaxsRelation;

  IcItem(
      {this.itemId,
      this.itemCode1,
      this.itemCode2,
      this.itemNameAr,
      this.itemNameEn,
      this.description,
      this.matrixId,
      this.iCMatrix,
      this.category,
      this.iCCategory,
      this.company,
      this.iCCompany,
      this.itemType,
      this.isExpire,
      this.expireMonth,
      this.smallUOM,
      this.smallUOMPrice,
      this.smallUOMprPrice,
      this.mediumUom,
      this.mediumUomFactor,
      this.mediumUomPrice,
      this.mediumUoMprPrice,
      this.largeUom,
      this.largeUomFactor,
      this.largeUomPrice,
      this.largeUoMprPrice,
      this.dfltSellUomIndx,
      this.dfltPrchsUomIndx,
      this.reorderLevel,
      this.maxQty,
      this.calcBeforeDisc,
      this.minQty,
      this.price,
      this.discount,
      this.length,
      this.width,
      this.height,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate,
      this.images,
      this.itemTaxsRelation});

  IcItem.fromJson(Map<String, dynamic> json) {
    itemId = json["itemId"];
    itemCode1 = json["itemCode1"];
    itemCode2 = json["itemCode2"];
    itemNameAr = json["itemNameAr"];
    itemNameEn = json["itemNameEn"];
    description = json["description"];
    matrixId = json["matrixId"];
    iCMatrix = json["iC_Matrix"];
    category = json["category"];
    iCCategory = json["iC_Category"];
    company = json["company"];
    iCCompany = json["iC_Company"];
    itemType = json["itemType"];
    isExpire = json["isExpire"];
    expireMonth = json["expireMonth"];
    smallUOM = json["smallUOM"];
    smallUOMPrice = json["smallUOMPrice"];
    smallUOMprPrice = json["smallUOMprPrice"];
    mediumUom = json["mediumUOM"];
    mediumUomFactor = json["mediumUOMFactor"];
    mediumUomPrice = json["mediumUOMPrice"];
    mediumUoMprPrice = json["mediumUOMprPrice"];
    largeUom = json["largeUOM"];
    largeUomFactor = json["largeUOMFactor"];
    largeUomPrice = json["largeUOMPrice"];
    largeUoMprPrice = json["largeUOMprPrice"];
    dfltSellUomIndx = json["dfltSellUomIndx"];
    dfltPrchsUomIndx = json["dfltPrchsUomIndx"];
    reorderLevel = json["reorderLevel"];
    maxQty = json["maxQty"];
    calcBeforeDisc = json["calcBeforeDisc"];
    minQty = json["minQty"];
    price = json["price"];
    discount = json["discount"];
    length = json["length"];
    width = json["width"];
    height = json["height"];
    userId = json["userId"];
    lastUpdateUserId = json["lastUpdateUserId"];
    insertDate = json["insertDate"];
    lastUpdateDate = json["lastUpdateDate"];
    images = json["images"];
    itemTaxsRelation = json["itemTaxsRelation"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemId"] = itemId;
    _data["itemCode1"] = itemCode1;
    _data["itemCode2"] = itemCode2;
    _data["itemNameAr"] = itemNameAr;
    _data["itemNameEn"] = itemNameEn;
    _data["description"] = description;
    _data["matrixId"] = matrixId;
    _data["iC_Matrix"] = iCMatrix;
    _data["category"] = category;
    _data["iC_Category"] = iCCategory;
    _data["company"] = company;
    _data["iC_Company"] = iCCompany;
    _data["itemType"] = itemType;
    _data["isExpire"] = isExpire;
    _data["expireMonth"] = expireMonth;
    _data["smallUOM"] = smallUOM;
    _data["smallUOMPrice"] = smallUOMPrice;
    _data["smallUOMprPrice"] = smallUOMprPrice;
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
    _data["calcBeforeDisc"] = calcBeforeDisc;
    _data["minQty"] = minQty;
    _data["price"] = price;
    _data["discount"] = discount;
    _data["length"] = length;
    _data["width"] = width;
    _data["height"] = height;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    _data["images"] = images;
    if (itemTaxsRelation != null) {
      _data["itemTaxsRelation"] = itemTaxsRelation;
    }
    return _data;
  }
}

class SalesItemUom {
  int? uomId;
  String? uom;
  double? prPrice;
  double? sellPrice;
  double? factor;

  SalesItemUom(
      {this.uomId, this.uom, this.prPrice, this.sellPrice, this.factor});

  SalesItemUom.fromJson(Map<String, dynamic> json) {
    uomId = json["uomId"];
    uom = json["uom"];
    prPrice = json["prPrice"];
    sellPrice = json["sellPrice"];
    factor = json["factor"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["uomId"] = uomId;
    _data["uom"] = uom;
    _data["prPrice"] = prPrice;
    _data["sellPrice"] = sellPrice;
    _data["factor"] = factor;
    return _data;
  }
}
