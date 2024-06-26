class SignUpRepoEntity {
  bool? status;
  String? message;
  Data? data;

  SignUpRepoEntity({this.status, this.message, this.data});
}

class Data {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  Data({this.name, this.email, this.phone, this.id, this.image, this.token});
}
