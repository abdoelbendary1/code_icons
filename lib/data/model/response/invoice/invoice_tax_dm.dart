import 'package:code_icons/domain/entities/invoice/tax/invoicd_tax_entity.dart';

class InvoiceTaxDm extends InvoiceTaxEntity {
  InvoiceTaxDm(
      {super.eTaxableTypeId,
      super.code,
      super.descriptionAr,
      super.parentTaxId,
      super.tax,
      super.accountId,
      super.aCcAccount,
      super.isDeduct,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate,
      super.items});

  InvoiceTaxDm.fromJson(Map<String, dynamic> json) {
    eTaxableTypeId = json["e_TaxableTypeId"];
    code = json["code"];
    descriptionAr = json["descriptionAr"];
    parentTaxId = json["parentTaxId"];
    tax = json["tax"];
    accountId = json["accountId"];
    aCcAccount = json["aCC_Account"];
    isDeduct = json["isDeduct"];
    userId = json["userId"];
    lastUpdateUserId = json["lastUpdateUserId"];
    insertDate = json["insertDate"];
    lastUpdateDate = json["lastUpdateDate"];
    items = json["items"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["e_TaxableTypeId"] = eTaxableTypeId;
    _data["code"] = code;
    _data["descriptionAr"] = descriptionAr;
    _data["parentTaxId"] = parentTaxId;
    _data["tax"] = tax;
    _data["accountId"] = accountId;
    _data["aCC_Account"] = aCcAccount;
    _data["isDeduct"] = isDeduct;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    if (items != null) {
      _data["items"] = items;
    }
    return _data;
  }
}
