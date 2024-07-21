import 'package:code_icons/domain/entities/Currency/currency.dart';

class CurrencyDataModel extends CurrencyEntity {
  CurrencyDataModel(
      {super.id,
      super.piaster3Ar,
      super.piaster2Ar,
      super.piaster3En,
      super.piaster2En,
      super.piaster1Ar,
      super.piaster1En,
      super.pound3Ar,
      super.pound3En,
      super.pound2En,
      super.pound2Ar,
      super.pound1En,
      super.pound1Ar,
      super.currencyNameEn,
      super.currencyNameAr,
      super.rate,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate});

  CurrencyDataModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    piaster3Ar = json["piaster_3_ar"];
    piaster2Ar = json["piaster_2_ar"];
    piaster3En = json["piaster_3_en"];
    piaster2En = json["piaster_2_en"];
    piaster1Ar = json["piaster_1_ar"];
    piaster1En = json["piaster_1_en"];
    pound3Ar = json["pound_3_ar"];
    pound3En = json["pound_3_en"];
    pound2En = json["pound_2_en"];
    pound2Ar = json["pound_2_ar"];
    pound1En = json["pound_1_en"];
    pound1Ar = json["pound_1_ar"];
    if (json["currency_name_en"] is String) {
      currencyNameEn = json["currency_name_en"];
    }
    if (json["currency_name_ar"] is String) {
      currencyNameAr = json["currency_name_ar"];
    }
    if (json["rate"] is int) {
      rate = json["rate"];
    }
    userId = json["userId"];
    if (json["lastUpdateUserId"] is int) {
      lastUpdateUserId = json["lastUpdateUserId"];
    }
    insertDate = json["insertDate"];
    if (json["lastUpdateDate"] is String) {
      lastUpdateDate = json["lastUpdateDate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["piaster_3_ar"] = piaster3Ar;
    _data["piaster_2_ar"] = piaster2Ar;
    _data["piaster_3_en"] = piaster3En;
    _data["piaster_2_en"] = piaster2En;
    _data["piaster_1_ar"] = piaster1Ar;
    _data["piaster_1_en"] = piaster1En;
    _data["pound_3_ar"] = pound3Ar;
    _data["pound_3_en"] = pound3En;
    _data["pound_2_en"] = pound2En;
    _data["pound_2_ar"] = pound2Ar;
    _data["pound_1_en"] = pound1En;
    _data["pound_1_ar"] = pound1Ar;
    _data["currency_name_en"] = currencyNameEn;
    _data["currency_name_ar"] = currencyNameAr;
    _data["rate"] = rate;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    return _data;
  }
}
