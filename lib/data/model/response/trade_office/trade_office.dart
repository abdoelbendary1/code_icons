import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';

class TradeOfficeDataModel extends TradeOfficeEntity {
  TradeOfficeDataModel({super.idBl, super.tradeOfficeBl});

  TradeOfficeDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["tradeOfficeBL"] is String) {
      tradeOfficeBl = json["tradeOfficeBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["tradeOfficeBL"] = tradeOfficeBl;
    return _data;
  }
}
