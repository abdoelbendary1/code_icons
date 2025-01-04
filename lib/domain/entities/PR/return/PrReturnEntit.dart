import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';

class PrReturnEntity {
  int id;
  int code;
  String? sourceCode;
  int storeId;
  int vendor;
  String? notes;
  String? costcenter;
  DateTime date;
  double invDiscountP;
  double invDiscountV;
  int crncId;
  double rate;
  double total;
  double net;
  DateTime insertDate;
  List<InvoiceItemDetailsDm> itemsDetails;

  PrReturnEntity({
    required this.id,
    required this.code,
    this.sourceCode,
    required this.storeId,
    required this.vendor,
    this.notes,
    this.costcenter,
    required this.date,
    required this.invDiscountP,
    required this.invDiscountV,
    required this.crncId,
    required this.rate,
    required this.total,
    required this.net,
    required this.insertDate,
    required this.itemsDetails,
  });
}
