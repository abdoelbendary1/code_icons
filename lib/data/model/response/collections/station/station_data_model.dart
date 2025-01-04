import 'package:code_icons/domain/entities/station/station.dart';

class StationDataModel extends StationEntity {
  StationDataModel({super.idBl, super.stationBl});

  StationDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["stationBL"] is String) {
      stationBl = json["stationBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["stationBL"] = stationBl;
    return _data;
  }
}
