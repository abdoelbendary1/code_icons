class InvoiceTaxEntity {
  int? eTaxableTypeId;
  String? code;
  String? descriptionAr;
  dynamic parentTaxId;
  dynamic tax;
  int? accountId;
  dynamic aCcAccount;
  bool? isDeduct;
  int? userId;
  dynamic lastUpdateUserId;
  String? insertDate;
  dynamic lastUpdateDate;
  List<dynamic>? items;

  InvoiceTaxEntity(
      {this.eTaxableTypeId,
      this.code,
      this.descriptionAr,
      this.parentTaxId,
      this.tax,
      this.accountId,
      this.aCcAccount,
      this.isDeduct,
      this.userId,
      this.lastUpdateUserId,
      this.insertDate,
      this.lastUpdateDate,
      this.items});
}
