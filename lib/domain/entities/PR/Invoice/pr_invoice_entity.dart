// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';

class PrInvoiceEntity {
  int? id;
  dynamic code;
  dynamic sourceCode;
  int? storeId;
  int? vendor;
  String? date;
  double? invDiscountP;
  double? invDiscountV;
  double? total;
  double? net;
  int? costcenter;
  int? paymentMethod;
  int? drawerId;
  int? payment;
  dynamic custody;
  dynamic custodyAcc;
  dynamic amount;
  int? crncId;
  double? rate;
  dynamic lcId;
  int? journalId;
  dynamic processId;
  dynamic sourceType;
  dynamic? paid;
  dynamic notes;
  dynamic receiveDate;
  dynamic dueDate;
  dynamic? insertDate;
  List<InvoiceItemDetailsDm>? itemsDetails;
  List<ExpnsessDetailsDm>? expnsessDetails;
  List<dynamic>? otherexpnsessDetails;

  PrInvoiceEntity(
      {this.id,
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
      this.otherexpnsessDetails});
}

class ExpnsessDetailsEntity {
  String? id;
  int? pRInvoiceId;
  int? accountId;
  String? notes;
  int? price;
  int? dist;
  ExpnsessDetailsEntity({
    this.id,
    this.pRInvoiceId,
    this.accountId,
    this.notes,
    this.price,
    this.dist,
  });
}
