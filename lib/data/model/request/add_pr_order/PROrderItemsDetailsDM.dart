import 'package:code_icons/domain/entities/PR_order_entity/request/pt_orderItemsDetails.dart';

class PrOrderItemsDetailsDM extends PrOrderItemsDetailsEntity {
  PrOrderItemsDetailsDM({
    super.itemNameAr,
    super.currentQty,
    super.description,
    super.qty,
    super.precentage,
    super.precentagevalue,
    super.uom,
    super.prprice,
    super.alltaxesvalue,
    super.totalprice,
    super.idStore,
    super.id,
    super.length,
    super.width,
    super.height,
    super.allQtyValue,
    super.foreignKey,
    super.itemCode2,
    super.itemCode1,
  });

  PrOrderItemsDetailsDM.fromJson(Map<String, dynamic> json) {
    if (json["itemNameAr"] is int) {
      itemNameAr = json["itemNameAr"];
    }
    if (json["currentQty"] is int) {
      currentQty = json["currentQty"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["qty"] is int) {
      qty = json["qty"];
    }
    if (json["precentage"] is int) {
      precentage = json["precentage"];
    }
    if (json["precentagevalue"] is int) {
      precentagevalue = json["precentagevalue"];
    }
    if (json["uom"] is int) {
      uom = json["uom"];
    }
    if (json["prprice"] is int) {
      prprice = json["prprice"];
    }
    if (json["alltaxesvalue"] is int) {
      alltaxesvalue = json["alltaxesvalue"];
    }
    if (json["totalprice"] is String) {
      totalprice = json["totalprice"];
    }
    idStore = json["idStore"];
    if (json["id"] is String) {
      id = json["id"];
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
    if (json["allQtyValue"] is int) {
      allQtyValue = json["allQtyValue"];
    }
    if (json["foreignKey"] is String) {
      foreignKey = json["foreignKey"];
    }
    if (json["itemCode2"] is int) {
      itemCode2 = json["itemCode2"];
    }
    if (json["itemCode1"] is int) {
      itemCode1 = json["itemCode1"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemNameAr"] = itemNameAr;
    _data["currentQty"] = currentQty;
    _data["description"] = description;
    _data["qty"] = qty;
    _data["precentage"] = precentage;
    _data["precentagevalue"] = precentagevalue;
    _data["uom"] = uom;
    _data["prprice"] = prprice;
    _data["alltaxesvalue"] = alltaxesvalue;
    _data["totalprice"] = totalprice;
    _data["idStore"] = idStore;
    _data["id"] = id;
    _data["length"] = length;
    _data["width"] = width;
    _data["height"] = height;
    _data["allQtyValue"] = allQtyValue;
    _data["foreignKey"] = foreignKey;
    _data["itemCode2"] = itemCode2;
    _data["itemCode1"] = itemCode1;

    return _data;
  }
}
