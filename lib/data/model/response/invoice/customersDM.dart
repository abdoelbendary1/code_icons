import 'package:code_icons/domain/entities/invoice/customers/invoice_customer_entity.dart';

class InvoiceCustomerDm extends InvoiceCustomerEntity {
  InvoiceCustomerDm({
    super.id,
    super.cusCode,
    super.cusNameAr,
    super.cusNameEn,
    super.tel,
    super.mobile,
    super.address,
    super.maxCredit,
    super.discountRatio,
    super.city,
    super.email,
    super.fax,
    super.zip,
    super.shipping,
    super.manager,
    super.dueDaysCount,
    super.representative,
    super.representativeJob,
    super.categoryId,
    super.taxCardNumber,
    super.taxFileNumber,
    super.tradeRegistry,
    super.taxDepartment,
    super.isTaxable,
    super.idNumber,
    super.bankName,
    super.bankAccNum,
    super.isBlocked,
    super.isActive,
    super.groupId,
    super.repMobile,
    super.repId,
    super.region,
    super.csType,
    super.street,
    super.neighborhood,
    super.countryId,
    super.governate,
    super.buildingNumber,
    super.subArea,
    super.priceLevelId,
    super.knowUs,
    super.stopped,
    super.insertDate,
    super.accountId,
  });

  InvoiceCustomerDm.fromJson(Map<String, dynamic> json) {
    id = json["id"];

    cusCode = json["cusCode"];

    cusNameAr = json["cusNameAr"];

    cusNameEn = json["cusNameEn"];
    tel = json["tel"];
    mobile = json["mobile"];
    address = json["address"];
    maxCredit = json["maxCredit"];

    discountRatio = json["discountRatio"];

    city = json["city"];
    email = json["email"];
    fax = json["fax"];
    zip = json["zip"];
    shipping = json["shipping"];
    manager = json["manager"];
    dueDaysCount = json["dueDaysCount"];
    representative = json["representative"];
    representativeJob = json["representativeJob"];
    if (json["categoryId"] is int) {
      categoryId = json["categoryId"];
    }
    taxCardNumber = json["taxCardNumber"];
    taxFileNumber = json["taxFileNumber"];
    tradeRegistry = json["tradeRegistry"];
    taxDepartment = json["taxDepartment"];
    if (json["isTaxable"] is bool) {
      isTaxable = json["isTaxable"];
    }
    idNumber = json["idNumber"];
    bankName = json["bankName"];
    bankAccNum = json["bankAccNum"];
    if (json["is_Blocked"] is bool) {
      isBlocked = json["is_Blocked"];
    }
    if (json["is_Active"] is bool) {
      isActive = json["is_Active"];
    }
    if (json["groupId"] is int) {
      groupId = json["groupId"];
    }
    repMobile = json["rep_Mobile"];
    repId = json["rep_ID"];
    region = json["region"];
    csType = json["csType"];

    street = json["street"];
    neighborhood = json["neighborhood"];
    if (json["countryId"] is String) {
      countryId = json["countryId"];
    }
    governate = json["governate"];
    buildingNumber = json["buildingNumber"];
    subArea = json["subArea"];
    priceLevelId = json["priceLevelId"];
    knowUs = json["knowUs"];
    if (json["stopped"] is bool) {
      stopped = json["stopped"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    if (json["accountId"] is int) {
      accountId = json["accountId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (accountId != null) data['accountId'] = accountId;
    if (cusCode != null) data['cusCode'] = cusCode;
    if (cusNameAr != null) data['cusNameAr'] = cusNameAr;
    if (cusNameEn != null) data['cusNameEn'] = cusNameEn;
    if (tel != null) data['tel'] = tel;
    if (mobile != null) data['mobile'] = mobile;
    if (address != null) data['address'] = address;
    if (maxCredit != null) data['maxCredit'] = maxCredit;
    if (discountRatio != null) data['discountRatio'] = discountRatio;
    if (city != null) data['city'] = city;
    if (email != null) data['email'] = email;
    if (fax != null) data['fax'] = fax;
    if (zip != null) data['zip'] = zip;
    if (shipping != null) data['shipping'] = shipping;
    if (manager != null) data['manager'] = manager;
    if (dueDaysCount != null) data['dueDaysCount'] = dueDaysCount;
    if (representative != null) data['representative'] = representative;
    if (representativeJob != null)
      data['representativeJob'] = representativeJob;
    if (categoryId != null) data['categoryId'] = categoryId;
    if (taxCardNumber != null) data['taxCardNumber'] = taxCardNumber;
    if (taxFileNumber != null) data['taxFileNumber'] = taxFileNumber;
    if (tradeRegistry != null) data['tradeRegistry'] = tradeRegistry;
    if (taxDepartment != null) data['taxDepartment'] = taxDepartment;
    if (isTaxable != null) data['isTaxable'] = isTaxable;
    if (idNumber != null) data['idNumber'] = idNumber;
    if (bankName != null) data['bankName'] = bankName;
    if (bankAccNum != null) data['bankAccNum'] = bankAccNum;
    if (isBlocked != null) data['is_Blocked'] = isBlocked;
    if (isActive != null) data['is_Active'] = isActive;
    if (groupId != null) data['groupId'] = groupId;
    if (repMobile != null) data['rep_Mobile'] = repMobile;
    if (repId != null) data['rep_ID'] = repId;
    if (region != null) data['region'] = region;
    if (csType != null) data['csType'] = csType;
    if (street != null) data['street'] = street;
    if (neighborhood != null) data['neighborhood'] = neighborhood;
    if (countryId != null) data['countryId'] = countryId;
    if (governate != null) data['governate'] = governate;
    if (buildingNumber != null) data['buildingNumber'] = buildingNumber;
    if (subArea != null) data['subArea'] = subArea;
    if (priceLevelId != null) data['priceLevelId'] = priceLevelId;
    if (knowUs != null) data['knowUs'] = knowUs;
    if (stopped != null) data['stopped'] = stopped;
    if (insertDate != null) data['insertDate'] = insertDate;

    return data;
  }
}
