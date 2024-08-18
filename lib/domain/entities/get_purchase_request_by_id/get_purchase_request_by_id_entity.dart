
import 'package:code_icons/data/model/response/purchases/purchase_request/get_purchase_request_by_id/items_details_entity/items_details_data_model.dart';

class GetPurchaseRequestByIdEntity {
  List<ItemsDetailsDataModel>? itemsDetails;
  int? storeId;
  int? status;
  dynamic costcenter;
  dynamic notes;
  String? date;
  String? code;
  String? insertDate;

  GetPurchaseRequestByIdEntity({this.itemsDetails, this.storeId, this.status, this.costcenter, this.notes, this.date, this.code, this.insertDate});

  
}

