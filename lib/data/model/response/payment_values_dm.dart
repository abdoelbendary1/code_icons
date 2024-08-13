import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';

class PaymenValuesDM extends PaymentValuesEntity {
  PaymenValuesDM({
    super.yearsOfRepayment,
    super.paidYears,
    super.compensation,
    super.activity,
    super.late,
    super.current,
    super.different,
    super.total,
    super.clientId,
    super.tradeRegistryTypeBl,
    super.clientName,
    super.clientAddress,
    super.capital,
    super.message,
  });

  PaymenValuesDM.fromJson(Map<String, dynamic> json) {
    if (json["yearsOfRepayment"] is String) {
      yearsOfRepayment = json["yearsOfRepayment"];
    }

    paidYears = json["paidYears"] ?? [];

    if (json["compensation"] is double) {
      compensation = json["compensation"];
    }
    if (json["activity"] is double) {
      activity = json["activity"];
    }
    if (json["late"] is double) {
      late = json["late"];
    }
    if (json["current"] is double) {
      current = json["current"];
    }
    if (json["different"] is double) {
      different = json["different"];
    }
    if (json["total"] is double) {
      total = json["total"];
    }
    if (json["clientId"] is double) {
      clientId = json["clientId"];
    }
    if (json["tradeRegistryTypeBL"] is double) {
      tradeRegistryTypeBl = json["tradeRegistryTypeBL"];
    }
    if (json["clientName"] is String) {
      clientName = json["clientName"];
    }
    if (json["clientAddress"] is String) {
      clientAddress = json["clientAddress"];
    }
    if (json["capital"] is double) {
      capital = json["capital"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["yearsOfRepayment"] = yearsOfRepayment;
    if (paidYears != null) {
      _data["paidYears"] = paidYears;
    }
    _data["compensation"] = compensation;
    _data["activity"] = activity;
    _data["late"] = late;
    _data["current"] = current;
    _data["different"] = different;
    _data["total"] = total;
    _data["clientId"] = clientId;
    _data["tradeRegistryTypeBL"] = tradeRegistryTypeBl;
    _data["clientName"] = clientName;
    _data["clientAddress"] = clientAddress;
    _data["capital"] = capital;
    _data["message"] = message;

    return _data;
  }
}
