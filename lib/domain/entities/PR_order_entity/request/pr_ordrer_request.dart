import 'package:code_icons/data/model/request/add_pr_order/PROrderItemsDetailsDM.dart';

class PrOrdrerRequestEntity {
  dynamic sourceCode;
  int? storeId;
  int? vendor;
  String? notes;
  dynamic costcenter;
  String? date;
  int? crncId;
  int? rate;
  int? total;
  int? net;
  List<PrOrderItemsDetailsDM>? itemsDetails;

  PrOrdrerRequestEntity(
      {this.sourceCode,
      this.storeId,
      this.vendor,
      this.notes,
      this.costcenter,
      this.date,
      this.crncId,
      this.rate,
      this.total,
      this.net,
      this.itemsDetails});
}
