import 'package:code_icons/data/model/response/purchase_item/item_Uom/item_Uom.dart';
import 'package:code_icons/domain/entities/purchase_item/itemUom/item_Uom.dart';

class PurchaseItemEntity {
  int? itemId;
  int? itemCode1;
  String? itemCode2;
  String? itemNameAr;
  dynamic itemNameEn;
  dynamic description;
  int? category;
  int? company;
  int? itemType;
  bool? isExpire;
  int? expireMonth;
  List<ItemUomDataModel>? itemUom;
  List<dynamic>? itemTaxsRelation;
  List<dynamic>? itemReviews;
  List<dynamic>? images;
  int? smallUom;
  int? smallUomPrice;
  int? smallUoMprPrice;
  dynamic mediumUom;
  dynamic mediumUomFactor;
  int? mediumUomPrice;
  int? mediumUoMprPrice;
  dynamic largeUom;
  dynamic largeUomFactor;
  int? largeUomPrice;
  int? largeUoMprPrice;
  int? dfltSellUomIndx;
  int? dfltPrchsUomIndx;
  int? reorderLevel;
  int? maxQty;
  int? minQty;
  int? currentQty;
  bool? calcBeforeDisc;
  int? price;
  int? discount;
  int? length;
  int? width;
  int? height;
  String? insertDate;
  dynamic matrixId;
  dynamic matrix;

  PurchaseItemEntity({
    this.itemId,
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
    this.smallUom,
    this.smallUomPrice,
    this.smallUoMprPrice,
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
    this.matrix,
  });
}
