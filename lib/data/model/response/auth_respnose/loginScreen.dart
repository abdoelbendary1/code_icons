import 'package:hive/hive.dart';

@HiveType(typeId: 6) // Unique typeId for this adapter
class LoginScreensDM extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? userId;

  @HiveField(2)
  int? formId;

  @HiveField(3)
  String? modules;

  @HiveField(4)
  bool? canRead;

  @HiveField(5)
  bool? canCreate;

  @HiveField(6)
  bool? canUpdate;

  @HiveField(7)
  bool? canDelete;

  @HiveField(8)
  bool? canPrint;

  LoginScreensDM(
      {this.id,
      this.userId,
      this.formId,
      this.modules,
      this.canRead,
      this.canCreate,
      this.canUpdate,
      this.canDelete,
      this.canPrint});

  LoginScreensDM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    formId = json["formId"];
    modules = json["modules"];
    canRead = json["canRead"];
    canCreate = json["canCreate"];
    canUpdate = json["canUpdate"];
    canDelete = json["canDelete"];
    canPrint = json["canPrint"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["userId"] = userId;
    _data["formId"] = formId;
    _data["modules"] = modules;
    _data["canRead"] = canRead;
    _data["canCreate"] = canCreate;
    _data["canUpdate"] = canUpdate;
    _data["canDelete"] = canDelete;
    _data["canPrint"] = canPrint;
    return _data;
  }
}
