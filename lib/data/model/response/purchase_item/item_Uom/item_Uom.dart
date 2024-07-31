import 'package:code_icons/domain/entities/purchase_item/itemUom/item_Uom.dart';

class ItemUomDataModel extends ItemUomEntity {
  ItemUomDataModel({
    super.uomId,
    super.uom,
    super.prPrice,
    super.sellPrice,
    super.factor,
  });

  ItemUomDataModel.fromJson(Map<String, dynamic> json) {
    if (json["uomId"] is int) {
      uomId = json["uomId"];
    }
    if (json["uom"] is String) {
      uom = json["uom"];
    }
    if (json["prPrice"] is int) {
      prPrice = json["prPrice"];
    }
    if (json["sellPrice"] is int) {
      sellPrice = json["sellPrice"];
    }
    if (json["factor"] is int) {
      factor = json["factor"];
    }
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
