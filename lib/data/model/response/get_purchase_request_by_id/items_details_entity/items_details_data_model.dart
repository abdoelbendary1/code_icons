import 'package:code_icons/domain/entities/get_purchase_request_by_id/items_details_entity/items_details_entity.dart';

class ItemsDetailsDataModel extends ItemsDetailsEntity {
  ItemsDetailsDataModel(
      {super.itemCode1,
      super.itemNameAr,
      super.uom,
      super.qty,
     /*  super.prprice, */
      super.id});

  ItemsDetailsDataModel.fromJson(Map<String, dynamic> json) {
    if (json["itemCode1"] is int) {
      itemCode1 = json["itemCode1"];
    }
    if (json["itemNameAr"] is int) {
      itemNameAr = json["itemNameAr"];
    }
    if (json["uom"] is int) {
      uom = json["uom"];
    }
    if (json["qty"] is int) {
      qty = json["qty"];
    }
   /*  if (json["prprice"] is String) {
      prprice = json["prprice"];
    } */
    if (json["id"] is String) {
      id = json["id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["itemCode1"] = itemCode1;
    _data["itemNameAr"] = itemNameAr;
    _data["uom"] = uom;
    _data["qty"] = qty;
   /*  _data["prprice"] = prprice; */
    _data["id"] = id;
    return _data;
  }
}
