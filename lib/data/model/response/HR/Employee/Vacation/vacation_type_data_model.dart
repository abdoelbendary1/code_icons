import 'package:code_icons/domain/entities/HR/Vacation/vacation_type_entity.dart';

class VacationTypeDataModel extends VacationTypeEntity {
  VacationTypeDataModel({
    super.idBl,
    super.vactionTypeBl,
    super.openingBalanceBl,
    super.availableMonthBl,
    super.discountBl,
    super.insertDate,
  });

  @override
  toString() {
    return this.vactionTypeBl!;
  }

  VacationTypeDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is String) {
      idBl = json["idBL"];
    }
    if (json["vactionTypeBL"] is String) {
      vactionTypeBl = json["vactionTypeBL"];
    }
    if (json["openingBalanceBL"] is int) {
      openingBalanceBl = json["openingBalanceBL"];
    }
    if (json["availableMonthBL"] is int) {
      availableMonthBl = json["availableMonthBL"];
    }
    if (json["discountBL"] is int) {
      discountBl = json["discountBL"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["vactionTypeBL"] = vactionTypeBl;
    _data["openingBalanceBL"] = openingBalanceBl;
    _data["availableMonthBL"] = availableMonthBl;
    _data["discountBL"] = discountBl;
    _data["insertDate"] = insertDate;
    return _data;
  }
}
