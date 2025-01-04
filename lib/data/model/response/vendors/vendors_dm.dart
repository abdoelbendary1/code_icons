import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';

class VendorsDM extends VendorsEntity {
  VendorsDM(
      {super.id,
      super.vendorCode,
      super.venNameAr,
      super.venNameEn,
      super.tel,
      super.mobile,
      super.address,
      super.managerName,
      super.accountId,
      super.city,
      super.email,
      super.fax,
      super.zip,
      super.shipping,
      super.representative,
      super.representativeJob,
      super.taxCardNumber,
      super.taxFileNumber,
      super.tradeRegistry,
      super.taxDepartment,
      super.isTaxable,
      super.country,
      super.groupId,
      super.stoppedVendor,
      super.userId,
      super.lastUpdateUserId,
      super.insertDate,
      super.lastUpdateDate,
      super.priceLevelId,
      super.website});

  VendorsDM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    vendorCode = json["vendorCode"];
    venNameAr = json["venNameAr"];
    venNameEn = json["venNameEn"];
    tel = json["tel"];
    mobile = json["mobile"];
    address = json["address"];
    managerName = json["managerName"];
    accountId = json["accountId"];
    city = json["city"];
    email = json["email"];
    fax = json["fax"];
    zip = json["zip"];
    shipping = json["shipping"];
    representative = json["representative"];
    representativeJob = json["representativeJob"];
    taxCardNumber = json["taxCardNumber"];
    taxFileNumber = json["taxFileNumber"];
    tradeRegistry = json["tradeRegistry"];
    taxDepartment = json["taxDepartment"];
    isTaxable = json["isTaxable"];
    country = json["country"];
    groupId = json["groupId"];
    stoppedVendor = json["stoppedVendor"];
    userId = json["userId"];
    lastUpdateUserId = json["lastUpdateUserId"];
    insertDate = json["insertDate"];
    lastUpdateDate = json["lastUpdateDate"];
    priceLevelId = json["priceLevelId"];
    website = json["website"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["vendorCode"] = vendorCode;
    _data["venNameAr"] = venNameAr;
    _data["venNameEn"] = venNameEn;
    _data["tel"] = tel;
    _data["mobile"] = mobile;
    _data["address"] = address;
    _data["managerName"] = managerName;
    _data["accountId"] = accountId;
    _data["city"] = city;
    _data["email"] = email;
    _data["fax"] = fax;
    _data["zip"] = zip;
    _data["shipping"] = shipping;
    _data["representative"] = representative;
    _data["representativeJob"] = representativeJob;
    _data["taxCardNumber"] = taxCardNumber;
    _data["taxFileNumber"] = taxFileNumber;
    _data["tradeRegistry"] = tradeRegistry;
    _data["taxDepartment"] = taxDepartment;
    _data["isTaxable"] = isTaxable;
    _data["country"] = country;
    _data["groupId"] = groupId;
    _data["stoppedVendor"] = stoppedVendor;
    _data["userId"] = userId;
    _data["lastUpdateUserId"] = lastUpdateUserId;
    _data["insertDate"] = insertDate;
    _data["lastUpdateDate"] = lastUpdateDate;
    _data["priceLevelId"] = priceLevelId;
    _data["website"] = website;
    return _data;
  }
}
