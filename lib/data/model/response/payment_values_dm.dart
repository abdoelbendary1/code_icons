import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';

class PaymentValuesDM extends PaymentValuesEntity {
  PaymentValuesDM({
    super.yearsOfRepayment,
    super.paidYears,
    super.compensation,
    super.late,
    super.current,
    super.different,
    super.total,
  });

  factory PaymentValuesDM.fromJson(Map<String, dynamic> json) {
    return PaymentValuesDM(
      yearsOfRepayment: json['yearsOfRepayment'] as String,
      paidYears: List<int>.from(json['paidYears']),
      compensation: json['compensation'].toDouble(),
      late: json['late'].toDouble(),
      current: json['current'].toDouble(),
      different: json['different'].toDouble(),
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["yearsOfRepayment"] = yearsOfRepayment;
    if (paidYears != null) {
      _data["paidYears"] = paidYears;
    }
    _data["compensation"] = compensation;
    _data["late"] = late;
    _data["current"] = current;
    _data["different"] = different;
    _data["total"] = total;
    return _data;
  }
}
