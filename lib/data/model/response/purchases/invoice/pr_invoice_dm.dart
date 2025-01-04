import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/domain/entities/PR/Invoice/pr_invoice_entity.dart';

class PrInvoiceDm extends PrInvoiceEntity {
  PrInvoiceDm(
      {super.id,
      super.code,
      super.sourceCode,
      super.storeId,
      super.vendor,
      super.date,
      super.invDiscountP,
      super.invDiscountV,
      super.total,
      super.net,
      super.costcenter,
      super.paymentMethod,
      super.drawerId,
      super.payment,
      super.custody,
      super.custodyAcc,
      super.amount,
      super.crncId,
      super.rate,
      super.lcId,
      super.journalId,
      super.processId,
      super.sourceType,
      super.paid,
      super.notes,
      super.receiveDate,
      super.dueDate,
      super.insertDate,
      super.itemsDetails,
      super.expnsessDetails,
      super.otherexpnsessDetails});

  PrInvoiceDm.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    sourceCode = json["sourceCode"];
    storeId = json["storeId"];
    vendor = json["vendor"];
    date = json["date"];
    invDiscountP = json["invDiscountP"];
    invDiscountV = json["invDiscountV"];
    total = json["total"];
    net = json["net"];
    costcenter = json["costcenter"];
    paymentMethod = json["paymentMethod"];
    drawerId = json["drawerId"];
    payment = json["payment"];
    custody = json["custody"];
    custodyAcc = json["custodyAcc"];
    amount = json["amount"];
    crncId = json["crncId"];
    rate = json["rate"];
    lcId = json["lcId"];
    journalId = json["journalId"];
    processId = json["processId"];
    sourceType = json["sourceType"];
    paid = json["paid"];
    notes = json["notes"];
    receiveDate = json["receiveDate"];
    dueDate = json["dueDate"];
    insertDate = parseDouble(json['insertDate']);
    itemsDetails = json["itemsDetails"] == null
        ? null
        : (json["itemsDetails"] as List)
            .map((e) => InvoiceItemDetailsDm.fromJson(e))
            .toList();
    expnsessDetails = json["expnsessDetails"] == null
        ? null
        : (json["expnsessDetails"] as List)
            .map((e) => ExpnsessDetailsDm.fromJson(e))
            .toList();
    if (json["otherexpnsessDetails"] is List) {
      otherexpnsessDetails = json["otherexpnsessDetails"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["code"] = code;
    _data["sourceCode"] = sourceCode;
    _data["storeId"] = storeId;
    _data["vendor"] = vendor;
    _data["date"] = date;
    _data["invDiscountP"] = invDiscountP;
    _data["invDiscountV"] = invDiscountV;
    _data["total"] = total;
    _data["net"] = net;
    _data["costcenter"] = costcenter;
    _data["paymentMethod"] = paymentMethod;
    _data["drawerId"] = drawerId;
    _data["payment"] = payment;
    _data["custody"] = custody;
    _data["custodyAcc"] = custodyAcc;
    _data["amount"] = amount;
    _data["crncId"] = crncId;
    _data["rate"] = rate;
    _data["lcId"] = lcId;
    _data["journalId"] = journalId;
    _data["processId"] = processId;
    _data["sourceType"] = sourceType;
    _data["paid"] = paid;
    _data["notes"] = notes;
    _data["receiveDate"] = receiveDate;
    _data["dueDate"] = dueDate;
    _data["insertDate"] = insertDate;
    if (itemsDetails != null) {
      _data["itemsDetails"] = itemsDetails?.map((e) => e.toJson()).toList();
    }
    if (expnsessDetails != null) {
      _data["expnsessDetails"] =
          expnsessDetails?.map((e) => e.toJson()).toList();
    }
    if (otherexpnsessDetails != null) {
      _data["otherexpnsessDetails"] = otherexpnsessDetails;
    }
    return _data;
  }
} // Helper function to parse double values safely

double? parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    return double.tryParse(value); // Try parsing String to double
  }
  return null; // If parsing fails, return null
}

class ExpnsessDetailsDm extends ExpnsessDetailsEntity {
  ExpnsessDetailsDm(
      {super.id,
      super.pRInvoiceId,
      super.accountId,
      super.notes,
      super.price,
      super.dist});

  ExpnsessDetailsDm.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["pR_InvoiceId"] is int) {
      pRInvoiceId = json["pR_InvoiceId"];
    }
    if (json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if (json["notes"] is String) {
      notes = json["notes"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["dist"] is int) {
      dist = json["dist"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["pR_InvoiceId"] = pRInvoiceId;
    _data["accountId"] = accountId;
    _data["notes"] = notes;
    _data["price"] = price;
    _data["dist"] = dist;
    return _data;
  }
}
