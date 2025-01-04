import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/domain/entities/invoice/drawer/drawer_entity.dart';

class DrawerDm extends DrawerEntity {
  DrawerDm(
      {super.id,
      super.accountId,
      super.nameAr,
      super.nameEn,
      super.currencyId,
      super.currency,
      super.rate,
      super.openBalance,
      super.freeze,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate});

  DrawerDm.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    accountId = json["accountId"];
    nameAr = json["name_ar"];
    nameEn = json["name_en"];
    currencyId = json["currency_id"];
    currency = json["currency"] == null
        ? null
        : CurrencyDataModel.fromJson(json["currency"]);
    rate = json["rate"];
    openBalance = json["open_balance"];
    freeze = json["freeze"];
    userId = json["userId"];
    lastUpdateUserId = json["lastUpdateUserId"];
    insertDate = json["insertDate"];
    lastUpdateDate = json["lastUpdateDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["accountId"] = accountId;
    _data["name_ar"] = nameAr;
    _data["name_en"] = nameEn;
    _data["currency_id"] = currencyId;
    if (currency != null) {
      _data["currency"] = currency?.toJson();
    }
    _data["rate"] = rate;
    _data["open_balance"] = openBalance;
    _data["freeze"] = freeze;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    return _data;
  }
}
