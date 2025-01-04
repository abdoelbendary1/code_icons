import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';

class SalesInvoiceReportEntity {
  int? id;
  dynamic? code;
  String? sourceCode;
  int? storeId;
  int? customer;
  String? notes;
  dynamic? costcenter;
  String? date;
  double? invDiscountP;
  double? invDiscountV;
  double? total;
  double? invTaxes;
  double? net;
  dynamic jrnl;
  int? paymentMethod;
  dynamic? drawerId;
  int? crncId;
  double? rate;
  dynamic? lcId;
  dynamic? processId;
  dynamic sourceType;
  double? paid;
  double? remain;
  double? customerBalance;
  dynamic receiveDate;
  dynamic dueDate;
  String? insertDate;
  List<InvoiceItemDetailsDm>? itemsDetails;
  List<dynamic>? outputTaxesDetails;

  SalesInvoiceReportEntity(
      {this.id,
      this.code,
      this.sourceCode,
      this.storeId,
      this.customer,
      this.notes,
      this.costcenter,
      this.date,
      this.invDiscountP,
      this.invDiscountV,
      this.total,
      this.invTaxes,
      this.net,
      this.jrnl,
      this.paymentMethod,
      this.drawerId,
      this.crncId,
      this.rate,
      this.lcId,
      this.processId,
      this.sourceType,
      this.paid,
      this.remain,
      this.customerBalance,
      this.receiveDate,
      this.dueDate,
      this.insertDate,
      this.itemsDetails,
      this.outputTaxesDetails});
}
