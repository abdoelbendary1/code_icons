import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';

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
  });

  TradeCollectionResponse.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
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
    notesBl = json["notesBL"];
    if (json["customerDataIdBL"] is int) {
      customerDataIdBl = json["customerDataIdBL"];
    }
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
    _data["differentBL"] = differentBl;
    _data["totalBL"] = totalBl;
    _data["notesBL"] = notesBl;
    _data["customerDataIdBL"] = customerDataIdBl;
    return _data;
  }
}
