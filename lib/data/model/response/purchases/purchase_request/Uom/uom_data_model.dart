import 'package:code_icons/domain/Uom/uom_entity.dart';

class UomDataModel extends UomEntity {
  UomDataModel({super.uomId, super.uom});

  UomDataModel.fromJson(Map<String, dynamic> json) {
    if (json["uomId"] is int) {
      uomId = json["uomId"];
    }
    if (json["uom"] is String) {
      uom = json["uom"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["uomId"] = uomId;
    _data["uom"] = uom;
    return _data;
  }
}
