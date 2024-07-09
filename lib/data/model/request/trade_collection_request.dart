class TradeCollectionRequest {
  String? collectionDateBl;
  int? customerDataIdBl;
  String? phoneBl;
  String? tradeRegistryBl;
  String? addressBl;
  String? divisionBl;
  String? yearsOfRepaymentBl;
  double? paymentReceiptNumBl;
  double? activityBl;
  double? compensationBl;
  double? lateBl;
  double? currentBl;
  double? differentBl;
  double? totalBl;

  TradeCollectionRequest({
    this.collectionDateBl,
    this.customerDataIdBl,
    this.phoneBl,
    this.tradeRegistryBl,
    this.addressBl,
    this.divisionBl,
    this.yearsOfRepaymentBl,
    this.paymentReceiptNumBl,
    this.activityBl,
    this.compensationBl,
    this.lateBl,
    this.currentBl,
    this.differentBl,
    this.totalBl,
  });

  TradeCollectionRequest.fromJson(Map<String, dynamic> json) {
    if (json["collectionDateBL"] is String) {
      collectionDateBl = json["collectionDateBL"];
    }
    if (json["customerDataIdBL"] is double) {
      customerDataIdBl = json["customerDataIdBL"];
    }
    if (json["phoneBL"] is String) {
      phoneBl = json["phoneBL"];
    }
    if (json["tradeRegistryBL"] is String) {
      tradeRegistryBl = json["tradeRegistryBL"];
    }
    if (json["addressBL"] is String) {
      addressBl = json["addressBL"];
    }
    if (json["divisionBL"] is String) {
      divisionBl = json["divisionBL"];
    }
    if (json["yearsOfRepaymentBL"] is String) {
      yearsOfRepaymentBl = json["yearsOfRepaymentBL"];
    }
    if (json["paymentReceiptNumBL"] is double) {
      paymentReceiptNumBl = json["paymentReceiptNumBL"];
    }
    if (json["activityBL"] is double) {
      activityBl = json["activityBL"];
    }
    if (json["compensationBL"] is double) {
      compensationBl = json["compensationBL"];
    }
    if (json["lateBL"] is double) {
      lateBl = json["lateBL"];
    }
    if (json["currentBL"] is double) {
      currentBl = json["currentBL"];
    }
    if (json["differentBL"] is double) {
      differentBl = json["differentBL"];
    }
    if (json["totalBL"] is double) {
      totalBl = json["totalBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["collectionDateBL"] = collectionDateBl;
    _data["customerDataIdBL"] = customerDataIdBl;
    _data["phoneBL"] = phoneBl;
    _data["tradeRegistryBL"] = tradeRegistryBl;
    _data["addressBL"] = addressBl;
    _data["divisionBL"] = divisionBl;
    _data["yearsOfRepaymentBL"] = yearsOfRepaymentBl;
    _data["paymentReceiptNumBL"] = paymentReceiptNumBl;
    _data["activityBL"] = activityBl;
    _data["compensationBL"] = compensationBl;
    _data["lateBL"] = lateBl;
    _data["currentBL"] = currentBl;
    _data["differentBL"] = differentBl;
    _data["totalBL"] = totalBl;
    return _data;
  }
}
