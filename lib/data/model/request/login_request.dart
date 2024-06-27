class LoginRequest {
  String? UserName;
  String? Password;

  LoginRequest({this.UserName, this.Password});

  LoginRequest.fromJson(Map<String, String> json) {
    if (json["UserName"] is String) {
      UserName = json["UserName"];
    }
    if (json["Password"] is String) {
      Password = json["Password"];
    }
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["UserName"] = UserName as String;
    data["Password"] = Password as String;
    return data;
  }
}
