import 'package:hive/hive.dart';

@HiveType(typeId: 5) // Ensure the typeId is unique in your project
class LoginRequest {
  @HiveField(0)
  String? userName;

  @HiveField(1)
  String? password;

  LoginRequest({this.userName, this.password});

  LoginRequest.fromJson(Map<String, String> json) {
    userName = json["UserName"];
    password = json["Password"];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["UserName"] = userName!;
    data["Password"] = password!;
    return data;
  }
}
