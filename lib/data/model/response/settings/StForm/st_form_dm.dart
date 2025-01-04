import 'package:code_icons/domain/entities/settings/StForm/st_form_entity.dart';

class StFormDm extends StFormEntity {
  StFormDm({super.id, super.formId, super.formName, super.modules});

  StFormDm.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    formId = json["formId"];
    formName = json["formName"];
    modules = json["modules"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["formId"] = formId;
    _data["formName"] = formName;
    _data["modules"] = modules;
    return _data;
  }
}
