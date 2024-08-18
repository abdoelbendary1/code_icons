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
  List<dynamic>? screens;

  AuthRepoEntity({
    this.id,
    this.username,
    this.name,
    this.accessToken,
    this.message,
    this.screens,
  });
}
