import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/domain/entities/invoice/invoiceReport/sales_invoice_report_entity.dart';

class InvoiceReportDm extends SalesInvoiceReportEntity {
  InvoiceReportDm({
    super.id,
    super.code,
    super.sourceCode,
    super.storeId,
    super.customer,
    super.notes,
    super.costcenter,
    super.date,
    super.invDiscountP,
    super.invDiscountV,
    super.total,
    super.invTaxes,
    super.net,
    super.jrnl,
    super.paymentMethod,
    super.drawerId,
    super.crncId,
    super.rate,
    super.lcId,
    super.processId,
    super.sourceType,
    super.paid,
    super.remain,
    super.customerBalance,
    super.receiveDate,
    super.dueDate,
    super.insertDate,
    super.itemsDetails,
    super.outputTaxesDetails,
  });
  @override
  String toString() {
    return ' $code $customer';
  }

  // Method to convert JSON to model
  factory InvoiceReportDm.fromJson(Map<String, dynamic> json) {
    return InvoiceReportDm(
      id: json['id'],
      code: json['code'],
      sourceCode: json['sourceCode'],
      storeId: json['storeId'],
      customer: json['customer'],
      notes: json['notes'],
      costcenter: json['costcenter'],
      date: json['date'],
      invDiscountP: (json['invDiscountP'] as num?)?.toDouble(),
      invDiscountV: (json['invDiscountV'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      invTaxes: (json['invTaxes'] as num?)?.toDouble(),
      net: (json['net'] as num?)?.toDouble(),
      jrnl: json['jrnl'],
      paymentMethod: json['paymentMethod'],
      drawerId: json['drawerId'],
      crncId: json['crncId'],
      rate: (json['rate'] as num?)?.toDouble(),
      lcId: json['lcId'],
      processId: (json['processId'] as num?)?.toDouble(),
      sourceType: json['sourceType'],
      paid: (json['paid'] as num?)?.toDouble(),
      remain: (json['remain'] as num?)?.toDouble(),
      customerBalance: (json['customerBalance'] as num?)?.toDouble(),
      receiveDate: json['receiveDate'],
      dueDate: json['dueDate'],
      insertDate: json['insertDate'],
      itemsDetails: (json['itemsDetails'] as List<dynamic>?)
          ?.map((item) => InvoiceItemDetailsDm.fromJson(item))
          .toList(),
      outputTaxesDetails: (json['outputTaxesDetails'] as List<dynamic>?)
          ?.map((item) => ItemTaxsRelation.fromJson(item))
          .toList(),
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = {};

    // Only add fields to the map if they are not null
    if (id != null) _data['id'] = id;
    if (code != null) _data['code'] = code;
    if (sourceCode != null) _data['sourceCode'] = sourceCode;
    if (storeId != null) _data['storeId'] = storeId;
    if (customer != null) _data['customer'] = customer;
    if (notes != null) _data['notes'] = notes;
    if (costcenter != null) _data['costcenter'] = costcenter;
    if (date != null) _data['date'] = date;
    if (invDiscountP != null) _data['invDiscountP'] = invDiscountP;
    if (invDiscountV != null) _data['invDiscountV'] = invDiscountV;
    if (total != null) _data['total'] = total;
    if (invTaxes != null) _data['invTaxes'] = invTaxes;
    if (net != null) _data['net'] = net;
    if (jrnl != null) _data['jrnl'] = jrnl;
    if (paymentMethod != null) _data['paymentMethod'] = paymentMethod;
    if (drawerId != null) _data['drawerId'] = drawerId;
    if (crncId != null) _data['crncId'] = crncId;
    if (rate != null) _data['rate'] = rate;
    if (lcId != null) _data['lcId'] = lcId;
    if (processId != null) _data['processId'] = processId;
    if (sourceType != null) _data['sourceType'] = sourceType;
    if (paid != null) _data['paid'] = paid;
    if (remain != null) _data['remain'] = remain;
    if (customerBalance != null) _data['customerBalance'] = customerBalance;
    if (receiveDate != null) _data['receiveDate'] = receiveDate;
    if (dueDate != null) _data['dueDate'] = dueDate;
    if (insertDate != null) _data['insertDate'] = insertDate;
    if (itemsDetails != null) {
      _data['itemsDetails'] =
          itemsDetails?.map((item) => item.toJson()).toList();
    }
    if (outputTaxesDetails != null) {
      _data['outputTaxesDetails'] = outputTaxesDetails;
    }

    return _data;
  }
}
