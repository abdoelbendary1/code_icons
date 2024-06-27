import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';

class AuthResponseDM extends AuthRepoEntity {
  List<dynamic>? screens;

  AuthResponseDM(
      {super.id,
      super.username,
      super.name,
      super.accessToken,
      super.message,
      this.screens});

  AuthResponseDM.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["access_token"] is String) {
      accessToken = json["access_token"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["screens"] is List) {
      screens = json["screens"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["username"] = username;
    _data["name"] = name;
    _data["access_token"] = accessToken;
    _data["message"] = message;
    if (screens != null) {
      _data["screens"] = screens;
    }
    return _data;
  }
}
