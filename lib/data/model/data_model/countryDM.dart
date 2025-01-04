class Country {
  final String code;
  final String name;
  final String dialCode;

  Country({
    required this.code,
    required this.name,
    required this.dialCode,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      dialCode: map['dialCode'] ?? '',
    );
  }
}
