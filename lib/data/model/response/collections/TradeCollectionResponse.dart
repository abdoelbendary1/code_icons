import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';

class TradeCollectionResponse extends TradeCollectionEntity {
  TradeCollectionResponse({
    super.idBl,
    super.collectionDateBl,
    super.yearsOfRepaymentBl,
    super.yearsOfRepaymentLstBl,
    super.paymentReceiptNumBl,
    super.compensationBl,
    super.lateBl,
    super.currentBl,
    super.differentBl,
    super.totalBl,
    super.notesBl,
    super.customerDataIdBl,
    super.activityBl,
    super.brandNameBl,
    super.capitalBl,
    super.collectorNameBl,
    super.lastPaidYearBl,
    super.tradeRegistryBl,
    super.tradeRegistryTypeBl,
  });

  TradeCollectionResponse.fromJson(Map<String, dynamic> json) {
    idBl = json["idBL"];

    if (json["collectionDateBL"] is String) {
      collectionDateBl = json["collectionDateBL"];
    }
    if (json["yearsOfRepaymentBL"] is String) {
      yearsOfRepaymentBl = json["yearsOfRepaymentBL"];
    }
    yearsOfRepaymentLstBl = json["yearsOfRepaymentLstBL"];
    if (json["paymentReceiptNumBL"] is String) {
      paymentReceiptNumBl = json["paymentReceiptNumBL"];
    }
    compensationBl = json["compensationBL"];

    lateBl = json["lateBL"];

    currentBl = json["currentBL"];

    activityBl = json["activityBL"];

    tradeRegistryTypeBl = json["tradeRegistryTypeBL"];

    differentBl = json["differentBL"];

    totalBl = json["totalBL"];

    notesBl = json["notesBL"];
    customerDataIdBl = json["customerDataIdBL"];

    lastPaidYearBl = json["lastPaidYearBL"];

    capitalBl = json["capitalBL"];

    collectorNameBl = json["collectorNameBL"];
    brandNameBl = json["brandNameBL"];

    tradeRegistryBl = json["tradeRegistryBL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["collectionDateBL"] = collectionDateBl;
    _data["yearsOfRepaymentBL"] = yearsOfRepaymentBl;
    _data["yearsOfRepaymentLstBL"] = yearsOfRepaymentLstBl;
    _data["paymentReceiptNumBL"] = paymentReceiptNumBl;
    _data["compensationBL"] = compensationBl;
    _data["lateBL"] = lateBl;
    _data["currentBL"] = currentBl;
    _data["activityBL"] = activityBl;
    _data["tradeRegistryTypeBL"] = tradeRegistryTypeBl;
    _data["differentBL"] = differentBl;
    _data["totalBL"] = totalBl;
    _data["notesBL"] = notesBl;
    _data["customerDataIdBL"] = customerDataIdBl;
    _data["lastPaidYearBL"] = lastPaidYearBl;
    _data["capitalBL"] = capitalBl;
    _data["collectorNameBL"] = collectorNameBl;
    _data["brandNameBL"] = brandNameBl;
    _data["tradeRegistryBL"] = tradeRegistryBl;
    return _data;
  }
}
