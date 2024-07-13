import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentValueRequest {
  int idBl;
  List<int> paidYears;
  PaymentValueRequest({
    required this.idBl,
    required this.paidYears,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idBl': idBl,
      'paidYears': paidYears,
    };
  }

  factory PaymentValueRequest.fromJson(Map<String, dynamic> map) {
    return PaymentValueRequest(
        idBl: map['idBl'] as int,
        paidYears: List<int>.from(
          (map['paidYears'] as List<int>),
        ));
  }

  
}
