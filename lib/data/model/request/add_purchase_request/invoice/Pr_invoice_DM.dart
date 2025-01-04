/* import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/domain/entities/invoice/invoiceReport/sales_invoice_report_entity.dart';

class PrInvoiceReportDm extends SalesInvoiceReportEntity {
  final List<dynamic>? expnsessDetails;

  final String? allQtyValue;
  final int? currentQty;
  final String? description;
  final String? foreignKey;
  final double? height;

  final int? itemCode1;
  final int? itemNameAr;
  final double? length;
  final double? precentage;
  final double? precentagevalue;
  final double? prprice;
  final double? qty;
  final String? totalprice;
  final int? uom;
  final double? width;

  final List<dynamic>? otherexpnsessDetails;

  final int? vendor;

  PrInvoiceReportDm({
    super.code,
    super.crncId,
    super.date,
    this.expnsessDetails,
    super.invDiscountP,
    super.invDiscountV,
    super.itemsDetails,
    this.allQtyValue,
    this.currentQty,
    this.description,
    this.foreignKey,
    this.height,
    super.id,
    this.itemCode1,
    this.itemNameAr,
    this.length,
    this.precentage,
    this.precentagevalue,
    this.prprice,
    this.qty,
    this.totalprice,
    this.uom,
    this.width,
    super.net,
    this.otherexpnsessDetails,
    super.outputTaxesDetails,
    super.paid,
    super.paymentMethod,
    super.rate,
    super.storeId,
    this.vendor,
    super.notes,
    super.costcenter,
    super.invTaxes,
  });

  // JSON to Model Conversion
  factory PrInvoiceReportDm.fromJson(Map<String, dynamic> json) {
    return PrInvoiceReportDm(
      crncId: json['crncId'],
      date: json['date'],
      costcenter: json['costcenter'],
      expnsessDetails: json['expnsessDetails'] as List<dynamic>,
      invDiscountP: (json['invDiscountP'] as num).toDouble(),
      invDiscountV: (json['invDiscountV'] as num).toDouble(),
      itemsDetails: (json['itemsDetails'] as List<dynamic>)
          .map((item) => InvoiceItemDetailsDm.fromJson(item))
          .toList(),
      notes: json['notes'],
      invTaxes: (json['invTaxes'] as num?)?.toDouble(),
      allQtyValue: json['allQtyValue'],
      currentQty: json['currentQty'],
      description: json['description'],
      foreignKey: json['foreignKey'],
      height: (json['height'] as num).toDouble(),
      id: json['id'],
      itemCode1: json['itemCode1'],
      itemNameAr: json['itemNameAr'],
      length: (json['length'] as num).toDouble(),
      precentage: (json['precentage'] as num).toDouble(),
      precentagevalue: (json['precentagevalue'] as num).toDouble(),
      prprice: (json['prprice'] as num).toDouble(),
      qty: (json['qty'] as num).toDouble(),
      totalprice: json['totalprice'],
      uom: json['uom'],
      width: (json['width'] as num).toDouble(),
      net: (json['net'] as num).toDouble(),
      otherexpnsessDetails: json['otherexpnsessDetails'] as List<dynamic>,
      outputTaxesDetails: (json['outputTaxesDetails'] as List<dynamic>?)
              ?.map((e) => ItemTaxsRelation.fromJson(e))
              .toList() ??
          [],
      paid: (json['paid'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      rate: (json['rate'] as num).toDouble(),
      storeId: json['storeId'],
      vendor: json['vendor'],
    );
  }

  // Model to JSON Conversion
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = {};

    if (crncId != null) _data['crncId'] = crncId;
    if (date != null) _data['date'] = date;
    _data['expnsessDetails'] = expnsessDetails?.map((e) => e.toJson()).toList();
    if (notes != null) _data['notes'] = notes;

    if (invDiscountP != null) _data['invDiscountP'] = invDiscountP;
    if (invDiscountV != null) _data['invDiscountV'] = invDiscountV;
    if (itemsDetails!.isNotEmpty) {
      _data['itemsDetails'] =
          itemsDetails!.map((item) => item.toJson()).toList();
    }
    if (invTaxes != null) _data['invTaxes'] = invTaxes;

    if (costcenter != null) _data['costcenter'] = costcenter;

    _data['allQtyValue'] = allQtyValue;
    _data['currentQty'] = currentQty;
    if (description != null) _data['description'] = description;
    _data['foreignKey'] = foreignKey;
    _data['height'] = height;
    if (id != null) _data['id'] = id;
    _data['itemCode1'] = itemCode1;
    _data['itemNameAr'] = itemNameAr;
    _data['length'] = length;
    _data['precentage'] = precentage;
    _data['precentagevalue'] = precentagevalue;
    _data['prprice'] = prprice;
    _data['qty'] = qty;
    _data['totalprice'] = totalprice;
    _data['uom'] = uom;
    _data['width'] = width;
    if (net != null) _data['net'] = net;
    _data['otherexpnsessDetails'] =
        otherexpnsessDetails?.map((e) => e.toJson()).toList();
    if (outputTaxesDetails!.isNotEmpty) {
      _data['outputTaxesDetails'] =
          outputTaxesDetails?.map((e) => e.toJson()).toList();
    }
    if (paid != null) _data['paid'] = paid;
    if (paymentMethod != null) _data['paymentMethod'] = paymentMethod;
    if (rate != null) _data['rate'] = rate;
    if (storeId != null) _data['storeId'] = storeId;
    _data['vendor'] = vendor;

    return _data;
  }
}
 */
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/domain/entities/invoice/invoiceReport/sales_invoice_report_entity.dart';

class PrInvoiceReportDm extends SalesInvoiceReportEntity {
  final double? amount;
  final List<dynamic>? expnsessDetails;
  final dynamic allQtyValue;
  final int? currentQty;
  final String? description;
  final String? foreignKey;
  final double? height;
  final int? itemCode1;
  final int? itemNameAr;
  final double? length;
  final int? mClassificationIdBL;
  final double? precentage;
  final double? precentagevalue;
  final double? prprice;
  final double? qty;
  final String? totalprice; // String or double, based on payload
  final int? uom;
  final double? width;
  final List<dynamic>? otherexpnsessDetails;
  final int? vendor;
  final int? payment;
  final String? batch;
  final String? custody;
  final String? custodyAcc;
  final int? journalId;

  PrInvoiceReportDm({
    this.amount,
    super.code,
    super.crncId,
    super.date,
    this.expnsessDetails,
    super.invDiscountP,
    super.invDiscountV,
    super.itemsDetails,
    this.allQtyValue,
    this.currentQty,
    this.description,
    this.foreignKey,
    this.height,
    super.id,
    this.itemCode1,
    this.itemNameAr,
    this.length,
    this.mClassificationIdBL,
    this.precentage,
    this.precentagevalue,
    this.prprice,
    this.qty,
    this.totalprice,
    this.uom,
    this.width,
    super.net,
    this.otherexpnsessDetails,
    super.outputTaxesDetails,
    super.paid,
    this.payment,
    super.paymentMethod,
    super.processId,
    super.receiveDate,
    super.sourceCode,
    super.sourceType,
    this.batch,
    this.custody,
    this.custodyAcc,
    super.insertDate,
    this.journalId,
    super.storeId,
    this.vendor,
    super.notes,
    super.costcenter,
    super.invTaxes,
    super.rate,
    super.drawerId,
    super.total,
  });

  // JSON to Model Conversion
  factory PrInvoiceReportDm.fromJson(Map<String, dynamic> json) {
    return PrInvoiceReportDm(
      amount: (json['amount'] as num?)?.toDouble(),
      code: json['code'],
      crncId: json['crncId'],
      date: (json['date']),
      expnsessDetails: json['expnsessDetails'] as List<dynamic>?,
      invDiscountP: (json['invDiscountP'] as num?)?.toDouble(),
      invDiscountV: (json['invDiscountV'] as num?)?.toDouble(),
      itemsDetails: (json['itemsDetails'] as List<dynamic>?)
          ?.map((item) => InvoiceItemDetailsDm.fromJson(item))
          .toList(),
      notes: json['notes'],
      invTaxes: (json['invTaxes'] as num?)?.toDouble(),
      allQtyValue: json['allQtyValue'],
      currentQty: json['currentQty'],
      description: json['description'],
      foreignKey: json['foreignKey'],
      height: (json['height'] as num?)?.toDouble(),
      id: json['id'],
      itemCode1: json['itemCode1'],
      itemNameAr: json['itemNameAr'],
      length: (json['length'] as num?)?.toDouble(),
      mClassificationIdBL: json['mClassificationIdBL'],
      precentage: (json['precentage'] as num?)?.toDouble(),
      precentagevalue: (json['precentagevalue'] as num?)?.toDouble(),
      prprice: (json['prprice'] as num?)?.toDouble(),
      qty: (json['qty'] as num?)?.toDouble(),
      totalprice: json['totalprice'], // Keep as dynamic for mixed types
      uom: json['uom'],
      width: (json['width'] as num?)?.toDouble(),
      net: (json['net'] as num?)?.toDouble(),
      otherexpnsessDetails: json['otherexpnsessDetails'] as List<dynamic>?,
      outputTaxesDetails: (json['outputTaxesDetails'] as List<dynamic>?)
              ?.map((e) => ItemTaxsRelation.fromJson(e))
              .toList() ??
          [],
      paid: (json['paid'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'],
      payment: json['payment'],
      processId: json['processId'],
      rate: (json['rate'] as num?)?.toDouble(),
      receiveDate: json['receiveDate'] != null
          ? DateTime.parse(json['receiveDate'])
          : null,
      sourceCode: json['sourceCode'],
      sourceType: json['sourceType'],
      storeId: json['storeId'],
      batch: json['batch'],
      custody: json['custody'],
      custodyAcc: json['custodyAcc'],
      insertDate: (json['insertDate']),
      journalId: json['journalId'],
      vendor: json['vendor'],
    );
  }

  // Model to JSON Conversion
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = {};

    _data['amount'] = amount;
    if (crncId != null) _data['crncId'] = crncId;
    if (date != null) _data['date'] = date;
    _data['expnsessDetails'] = expnsessDetails;
    if (notes != null) _data['notes'] = notes;

    if (invDiscountP != null) _data['invDiscountP'] = invDiscountP;
    if (invDiscountV != null) _data['invDiscountV'] = invDiscountV;
    if (itemsDetails != null && itemsDetails!.isNotEmpty) {
      _data['itemsDetails'] =
          itemsDetails!.map((item) => item.toJson()).toList();
    }
    if (invTaxes != null) _data['invTaxes'] = invTaxes;

    if (costcenter != null) _data['costcenter'] = costcenter;
    _data['allQtyValue'] = allQtyValue;
    _data['currentQty'] = currentQty;
    if (description != null) _data['description'] = description;
    _data['foreignKey'] = foreignKey;
    _data['height'] = height;
    if (id != null) _data['id'] = id;
    _data['itemCode1'] = itemCode1;
    _data['itemNameAr'] = itemNameAr;
    _data['length'] = length;
    _data['mClassificationIdBL'] = mClassificationIdBL;
    _data['precentage'] = precentage;
    _data['precentagevalue'] = precentagevalue;
    _data['prprice'] = prprice;
    _data['qty'] = qty;
    _data['totalprice'] = totalprice;
    _data['uom'] = uom;
    _data['width'] = width;
    if (net != null) _data['net'] = net;
    _data['otherexpnsessDetails'] = otherexpnsessDetails;
    if (outputTaxesDetails != null && outputTaxesDetails!.isNotEmpty) {
      _data['outputTaxesDetails'] =
          outputTaxesDetails?.map((e) => e.toJson()).toList();
    }
    if (paid != null) _data['paid'] = paid;
    if (paymentMethod != null) _data['paymentMethod'] = paymentMethod;
    if (rate != null) _data['rate'] = rate;
    if (storeId != null) _data['storeId'] = storeId;
    _data['vendor'] = vendor;
    _data['drawerId'] = drawerId;
    _data['dueDate'] = dueDate?.toIso8601String();
    _data['payment'] = payment;
    _data['processId'] = processId;
    _data['receiveDate'] = receiveDate?.toIso8601String();
    _data['sourceCode'] = sourceCode;
    _data['sourceType'] = sourceType;
    _data['batch'] = batch;
    _data['custody'] = custody;
    _data['custodyAcc'] = custodyAcc;
    _data['insertDate'] = insertDate;
    _data['journalId'] = journalId;

    return _data;
  }
}
