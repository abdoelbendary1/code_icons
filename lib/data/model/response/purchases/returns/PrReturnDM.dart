import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/domain/entities/PR/Invoice/pr_invoice_entity.dart';
import 'package:code_icons/domain/entities/PR/return/PrReturnEntit.dart';

class PrReturnDM extends PrInvoiceEntity {
  PrReturnDM({
    super.id,
    super.code,
    super.sourceCode,
    super.storeId,
    super.vendor,
    super.notes,
    super.costcenter,
    super.date,
    super.invDiscountP,
    super.invDiscountV,
    super.crncId,
    super.rate,
    super.total,
    super.net,
    super.insertDate,
    super.itemsDetails,
  });

  // From JSON
  factory PrReturnDM.fromJson(Map<String, dynamic> json) {
    return PrReturnDM(
      id: json['id'],
      code: json['code'],
      sourceCode: json['sourceCode'],
      storeId: json['storeId'],
      vendor: json['vendor'],
      notes: json['notes'],
      costcenter: json['costcenter'],
      date: json['date'],
      invDiscountP: json['invDiscountP'].toDouble(),
      invDiscountV: json['invDiscountV'].toDouble(),
      crncId: json['crncId'],
      rate: json['rate'].toDouble(),
      total: json['total'].toDouble(),
      net: json['net'].toDouble(),
      insertDate: json['insertDate'],
      itemsDetails: (json['itemsDetails'] as List)
          .map((item) => InvoiceItemDetailsDm.fromJson(item))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'sourceCode': sourceCode,
      'storeId': storeId,
      'vendor': vendor,
      'notes': notes,
      'costcenter': costcenter,
      'date': date,
      'invDiscountP': invDiscountP,
      'invDiscountV': invDiscountV,
      'crncId': crncId,
      'rate': rate,
      'total': total,
      'net': net,
      'insertDate': insertDate,
      'itemsDetails': itemsDetails?.map((item) => item.toJson()).toList(),
    };
  }
}
