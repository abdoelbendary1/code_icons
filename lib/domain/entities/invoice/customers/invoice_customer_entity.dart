class InvoiceCustomerEntity {
  int? id;
  int? cusCode;
  String? cusNameAr;
  dynamic cusNameEn;
  dynamic tel;
  dynamic mobile;
  dynamic address;
  double? maxCredit;
  double? discountRatio;
  dynamic city;
  dynamic email;
  dynamic fax;
  dynamic zip;
  dynamic shipping;
  dynamic manager;
  dynamic dueDaysCount;
  dynamic representative;
  dynamic representativeJob;
  int? categoryId;
  dynamic taxCardNumber;
  dynamic taxFileNumber;
  dynamic tradeRegistry;
  dynamic taxDepartment;
  bool? isTaxable;
  dynamic idNumber;
  dynamic bankName;
  dynamic bankAccNum;
  bool? isBlocked;
  bool? isActive;
  int? groupId;
  dynamic repMobile;
  dynamic repId;
  dynamic region;
  int? csType;
  dynamic street;
  dynamic neighborhood;
  String? countryId;
  dynamic governate;
  dynamic buildingNumber;
  dynamic subArea;
  dynamic priceLevelId;
  dynamic knowUs;
  bool? stopped;
  String? insertDate;
  int? accountId;
  @override
  String toString() {
    return cusNameAr!;
  }

  InvoiceCustomerEntity(
      {this.id,
      this.cusCode,
      this.cusNameAr,
      this.cusNameEn,
      this.tel,
      this.mobile,
      this.address,
      this.maxCredit,
      this.discountRatio,
      this.city,
      this.email,
      this.fax,
      this.zip,
      this.shipping,
      this.manager,
      this.dueDaysCount,
      this.representative,
      this.representativeJob,
      this.categoryId,
      this.taxCardNumber,
      this.taxFileNumber,
      this.tradeRegistry,
      this.taxDepartment,
      this.isTaxable,
      this.idNumber,
      this.bankName,
      this.bankAccNum,
      this.isBlocked,
      this.isActive,
      this.groupId,
      this.repMobile,
      this.repId,
      this.region,
      this.csType,
      this.street,
      this.neighborhood,
      this.countryId,
      this.governate,
      this.buildingNumber,
      this.subArea,
      this.priceLevelId,
      this.knowUs,
      this.stopped,
      this.insertDate,
      this.accountId});
}
