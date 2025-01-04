import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';

class PrInvoiceRequest {
  List<InvoiceItemDetailsDm>? itemsDetails;
  List<dynamic>? outputTaxesDetails;
  int? paymentMethod;
  String? date;
  int? storeId;
  int? crncId;
  int? rate;
  int? vendor;
  double? invDiscountP;
  double? invDiscountV;
  double? paid;
  double? net;
  List<dynamic>? expnsessDetails;
  List<dynamic>? otherexpnsessDetails;

  PrInvoiceRequest({
    this.itemsDetails,
    this.outputTaxesDetails,
    this.paymentMethod,
    this.date,
    this.storeId,
    this.crncId,
    this.rate,
    this.vendor,
    this.invDiscountP,
    this.invDiscountV,
    this.paid,
    this.net,
    this.expnsessDetails,
    this.otherexpnsessDetails,
  });

  factory PrInvoiceRequest.fromJson(Map<String, dynamic> json) {
    return PrInvoiceRequest(
      itemsDetails: (json['itemsDetails'] as List<dynamic>?)
          ?.map((e) => InvoiceItemDetailsDm.fromJson(e as Map<String, dynamic>))
          .toList(),
      outputTaxesDetails: json['outputTaxesDetails'] as List<dynamic>?,
      paymentMethod: json['paymentMethod'] as int?,
      date: json['date'] == null ? null : (json['date'] as String),
      storeId: json['storeId'] as int?,
      crncId: json['crncId'] as int?,
      rate: json['rate'] as int?,
      vendor: json['vendor'] as int?,
      invDiscountP: json['invDiscountP'] as double?,
      invDiscountV: json['invDiscountV'] as double?,
      paid: json['paid'] as double?,
      net: json['net'] as double?,
      expnsessDetails: json['expnsessDetails'] as List<dynamic>?,
      otherexpnsessDetails: json['otherexpnsessDetails'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'itemsDetails': itemsDetails?.map((e) => e.toJson()).toList(),
        'outputTaxesDetails': outputTaxesDetails,
        'paymentMethod': paymentMethod,
        'date': date,
        'storeId': storeId,
        'crncId': crncId,
        'rate': rate,
        'vendor': vendor,
        'invDiscountP': invDiscountP,
        'invDiscountV': invDiscountV,
        'paid': paid,
        'net': net,
        'expnsessDetails': expnsessDetails,
        'otherexpnsessDetails': otherexpnsessDetails,
      };
}
