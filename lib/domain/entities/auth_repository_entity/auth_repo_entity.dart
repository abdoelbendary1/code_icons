class AuthRepoEntity {
  bool? status;
  String? message;
  UserEntity? data;

  AuthRepoEntity({this.status, this.message, this.data});
}

class UserEntity {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });
}
