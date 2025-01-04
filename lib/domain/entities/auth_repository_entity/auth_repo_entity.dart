import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/loginScreen.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class AuthRepoEntity extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? accessToken;

  @HiveField(4)
  String? message;

  @HiveField(5)
  List<LoginScreensDM>? screens;

  AuthRepoEntity({
    this.id,
    this.username,
    this.name,
    this.accessToken,
    this.message,
    this.screens,
  });
}
