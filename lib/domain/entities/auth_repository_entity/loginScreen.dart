import 'package:hive/hive.dart';

@HiveType(typeId: 6) // Unique typeId for this adapter
class LoginScreensEntity extends HiveObject {
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

  LoginScreensEntity(
      {this.id,
      this.userId,
      this.formId,
      this.modules,
      this.canRead,
      this.canCreate,
      this.canUpdate,
      this.canDelete,
      this.canPrint});
}
