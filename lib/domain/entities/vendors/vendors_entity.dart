class VendorsEntity {
  int? id;
  int? vendorCode;
  String? venNameAr;
  dynamic venNameEn;
  dynamic tel;
  dynamic mobile;
  dynamic address;
  dynamic managerName;
  int? accountId;
  dynamic city;
  dynamic email;
  dynamic fax;
  dynamic zip;
  dynamic shipping;
  dynamic representative;
  dynamic representativeJob;
  dynamic taxCardNumber;
  dynamic taxFileNumber;
  dynamic tradeRegistry;
  dynamic taxDepartment;
  bool? isTaxable;
  String? country;
  int? groupId;
  bool? stoppedVendor;
  int? userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;
  dynamic priceLevelId;
  dynamic website;

  VendorsEntity(
      {this.id,
      this.vendorCode,
      this.venNameAr,
      this.venNameEn,
      this.tel,
      this.mobile,
      this.address,
      this.managerName,
      this.accountId,
      this.city,
      this.email,
      this.fax,
      this.zip,
      this.shipping,
      this.representative,
      this.representativeJob,
      this.taxCardNumber,
      this.taxFileNumber,
      this.tradeRegistry,
      this.taxDepartment,
      this.isTaxable,
      this.country,
      this.groupId,
      this.stoppedVendor,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate,
      this.priceLevelId,
      this.website});
}
