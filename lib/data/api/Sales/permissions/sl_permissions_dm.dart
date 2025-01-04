class SlPermissionsDm {
  int? userIdBl;
  int? itemDispensingWithoutCreditatDrawerBl;
  int? defaultpaymentTypeForSalesInvoiceBl;
  dynamic defaultpaymentTypeForSalesReturnInvoiceBl;
  bool? addDiscountOnTotalOfSalesInvoiceBl;
  bool? hideDiscountColumnOnSalesInvoiceBl;
  bool? canDispenseFromDrawerBl;
  dynamic defaultCustomerCategoryBl;

  SlPermissionsDm({
    this.userIdBl,
    this.itemDispensingWithoutCreditatDrawerBl,
    this.defaultpaymentTypeForSalesInvoiceBl,
    this.defaultpaymentTypeForSalesReturnInvoiceBl,
    this.addDiscountOnTotalOfSalesInvoiceBl,
    this.hideDiscountColumnOnSalesInvoiceBl,
    this.canDispenseFromDrawerBl,
    this.defaultCustomerCategoryBl,
  });

  factory SlPermissionsDm.fromJson(Map<String, dynamic> json) {
    return SlPermissionsDm(
      userIdBl: json['userIdBL'] as int?,
      itemDispensingWithoutCreditatDrawerBl:
          json['itemDispensingWithoutCreditatDrawerBL'] as int?,
      defaultpaymentTypeForSalesInvoiceBl:
          json['defaultpaymentTypeForSalesInvoiceBL'] as int?,
      defaultpaymentTypeForSalesReturnInvoiceBl:
          json['defaultpaymentTypeForSalesReturnInvoiceBL'] as dynamic,
      addDiscountOnTotalOfSalesInvoiceBl:
          json['addDiscountOnTotalOfSalesInvoiceBL'] as bool?,
      hideDiscountColumnOnSalesInvoiceBl:
          json['hideDiscountColumnOnSalesInvoiceBL'] as bool?,
      canDispenseFromDrawerBl: json['canDispenseFromDrawerBL'] as bool?,
      defaultCustomerCategoryBl: json['defaultCustomerCategoryBL'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'userIdBL': userIdBl,
        'itemDispensingWithoutCreditatDrawerBL':
            itemDispensingWithoutCreditatDrawerBl,
        'defaultpaymentTypeForSalesInvoiceBL':
            defaultpaymentTypeForSalesInvoiceBl,
        'defaultpaymentTypeForSalesReturnInvoiceBL':
            defaultpaymentTypeForSalesReturnInvoiceBl,
        'addDiscountOnTotalOfSalesInvoiceBL':
            addDiscountOnTotalOfSalesInvoiceBl,
        'hideDiscountColumnOnSalesInvoiceBL':
            hideDiscountColumnOnSalesInvoiceBl,
        'canDispenseFromDrawerBL': canDispenseFromDrawerBl,
        'defaultCustomerCategoryBL': defaultCustomerCategoryBl,
      };
}
