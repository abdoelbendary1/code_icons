import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';


class AuthResponseDm extends AuthRepoEntity {
  AuthResponseDm({super.status, super.message, super.data});

  AuthResponseDm.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : UserDM.fromJson(json["data"]);
  }
}

class UserDM extends UserEntity {
  UserDM(
      {super.id,
      super.name,
      super.email,
      super.phone,
      super.image,
      super.points,
      super.credit,
      super.token});

  UserDM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["image"] = image;
    _data["points"] = points;
    _data["credit"] = credit;
    _data["token"] = token;
    return _data;
  }
}
