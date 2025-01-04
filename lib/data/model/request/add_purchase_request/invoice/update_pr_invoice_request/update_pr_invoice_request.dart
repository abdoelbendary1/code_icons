import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';

import 'items_detail.dart';

class UpdatePrInvoiceRequest {
  int? id;
  String? code;
  dynamic sourceCode;
  int? storeId;
  int? vendor;
  String? date;
  double? invDiscountP;
  double? invDiscountV;
  double? total;
  double? net;
  dynamic costcenter;
  int? paymentMethod;
  dynamic drawerId;
  dynamic payment;
  dynamic custody;
  dynamic custodyAcc;
  dynamic amount;
  int? crncId;
  int? rate;
  dynamic lcId;
  int? journalId;
  dynamic processId;
  dynamic sourceType;
  double? paid;
  dynamic notes;
  dynamic receiveDate;
  dynamic dueDate;
  String? insertDate;
  List<InvoiceItemDetailsDm>? itemsDetails;
  List<dynamic>? expnsessDetails;
  List<dynamic>? otherexpnsessDetails;

  UpdatePrInvoiceRequest({
    this.id,
    this.code,
    this.sourceCode,
    this.storeId,
    this.vendor,
    this.date,
    this.invDiscountP,
    this.invDiscountV,
    this.total,
    this.net,
    this.costcenter,
    this.paymentMethod,
    this.drawerId,
    this.payment,
    this.custody,
    this.custodyAcc,
    this.amount,
    this.crncId,
    this.rate,
    this.lcId,
    this.journalId,
    this.processId,
    this.sourceType,
    this.paid,
    this.notes,
    this.receiveDate,
    this.dueDate,
    this.insertDate,
    this.itemsDetails,
    this.expnsessDetails,
    this.otherexpnsessDetails,
  });

  factory UpdatePrInvoiceRequest.fromJson(Map<String, dynamic> json) {
    return UpdatePrInvoiceRequest(
      id: json['id'] as int?,
      code: json['code'] as String?,
      sourceCode: json['sourceCode'] as dynamic,
      storeId: json['storeId'] as int?,
      vendor: json['vendor'] as int?,
      date:
          json['date'] == null ? null : (json['date'] as String),
      invDiscountP: json['invDiscountP'] as double?,
      invDiscountV: json['invDiscountV'] as double?,
      total: json['total'] as double?,
      net: json['net'] as double?,
      costcenter: json['costcenter'] as dynamic,
      paymentMethod: json['paymentMethod'] as int?,
      drawerId: json['drawerId'] as dynamic,
      payment: json['payment'] as dynamic,
      custody: json['custody'] as dynamic,
      custodyAcc: json['custodyAcc'] as dynamic,
      amount: json['amount'] as dynamic,
      crncId: json['crncId'] as int?,
      rate: json['rate'] as int?,
      lcId: json['lcId'] as dynamic,
      journalId: json['journalId'] as int?,
      processId: json['processId'] as dynamic,
      sourceType: json['sourceType'] as dynamic,
      paid: json['paid'] as double?,
      notes: json['notes'] as dynamic,
      receiveDate: json['receiveDate'] as dynamic,
      dueDate: json['dueDate'] as dynamic,
      insertDate:
          json['insertDate'] == null ? null : (json['insertDate'] as String),
      itemsDetails: (json['itemsDetails'] as List<dynamic>?)
          ?.map((e) => InvoiceItemDetailsDm.fromJson(e as Map<String, dynamic>))
          .toList(),
      expnsessDetails: json['expnsessDetails'] as List<dynamic>?,
      otherexpnsessDetails: json['otherexpnsessDetails'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'sourceCode': sourceCode,
        'storeId': storeId,
        'vendor': vendor,
        'date': date,
        'invDiscountP': invDiscountP,
        'invDiscountV': invDiscountV,
        'total': total,
        'net': net,
        'costcenter': costcenter,
        'paymentMethod': paymentMethod,
        'drawerId': drawerId,
        'payment': payment,
        'custody': custody,
        'custodyAcc': custodyAcc,
        'amount': amount,
        'crncId': crncId,
        'rate': rate,
        'lcId': lcId,
        'journalId': journalId,
        'processId': processId,
        'sourceType': sourceType,
        'paid': paid,
        'notes': notes,
        'receiveDate': receiveDate,
        'dueDate': dueDate,
        'insertDate': insertDate,
        'itemsDetails': itemsDetails?.map((e) => e.toJson()).toList(),
        'expnsessDetails': expnsessDetails,
        'otherexpnsessDetails': otherexpnsessDetails,
      };
}
