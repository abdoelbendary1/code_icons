import 'package:code_icons/domain/entities/activity/activity_entity.dart';

class ActivityDataModel extends ActivityEntity {
  ActivityDataModel({super.idBl, super.activityBl});

  ActivityDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["activityBL"] is String) {
      activityBl = json["activityBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["activityBL"] = activityBl;
    return _data;
  }
}
