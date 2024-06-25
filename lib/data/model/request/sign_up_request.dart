class SignUpRequest {
  String? name;
  String? email;
  String? password;

  String? phone;

  SignUpRequest({
    this.name,
    this.email,
    this.password,
    this.phone,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        name: json['name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        phone: json['phone'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };
}
