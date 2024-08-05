import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/purchase_item/purchase_item.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PurchaseRequestRemoteDataSource {
  Future<Either<Failures, List<PurchaseItemEntity>>> fetchPurchaseItemData();
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchPurchaseRequests();
  Future<Either<Failures, List<StoreEntity>>> fetchStoreData();
  Future<Either<Failures, List<CostCenterEntity>>> fetchCostCenterData();
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchAllPurchaseRequests();
  Future<Either<Failures, List<UomEntity>>> fetchUOMData();
  Future<Either<Failures, String>> postPurchaseRequest(
      {required PurchaseRequestDataModel purchaseRequestDataModel});
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      deletePurchaseRequestById({required int id});
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      fetchPurchaseRequestById({required int id});
  Future<Either<Failures, PurchaseItemEntity>> fetchPurchaseItemDataByID(
      {required int id});
}
