import 'package:code_icons/domain/entities/General_central/general_central_entity.dart';

class GeneralCentralDataModel extends GeneralCentralEntity {
  GeneralCentralDataModel({super.idBl, super.generalCenterNameBl});

  GeneralCentralDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["generalCenterNameBL"] is String) {
      generalCenterNameBl = json["generalCenterNameBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["idBL"] = idBl;
    data["generalCenterNameBL"] = generalCenterNameBl;
    return data;
  }
}
