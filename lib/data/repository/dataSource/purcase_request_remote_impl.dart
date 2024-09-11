import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/api/purchases/PR_Request/PR_manager.dart';
import 'package:code_icons/data/api/purchases/PR_Request/PR_request_interface.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/repository/data_source/purchase_request_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class PurchaseRequestRemoteDataSourceImpl
    implements PurchaseRequestRemoteDataSource {
  PurchaseRequestRemoteDataSourceImpl(
      {required this.apiManager, required this.prRequestManager});
  ApiManager apiManager;
  PrRequestInterface prRequestManager;
  @override
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchAllPurchaseRequests() async {
    var either = await prRequestManager.fetchAllPurchaseRequests();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, List<CostCenterEntity>>> fetchCostCenterData() async {
    var either = await prRequestManager.fetchCostCenterData();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, List<PurchaseItemEntity>>>
      fetchPurchaseItemData() async {
    var either = await prRequestManager.fetchPurchaseItemData();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchPurchaseRequests() async {
    var either = await prRequestManager.fetchPurchaseRequests();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, List<StoreEntity>>> fetchStoreData() async {
    var either = await prRequestManager.fetchStoreData();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, List<UomEntity>>> fetchUOMData() async {
    var either = await prRequestManager.fetchUOMData();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, String>> postPurchaseRequest(
      {required PurchaseRequestDataModel purchaseRequestDataModel}) async {
    var either =
        await prRequestManager.postPurchaseRequest(purchaseRequestDataModel);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      deletePurchaseRequestById({required int id}) async {
    var either = await prRequestManager.deletePurchaseRequestById(id: id);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      fetchPurchaseRequestById({required int id}) async {
    var either = await prRequestManager.fetchPurchaseRequestById(id: id);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, PurchaseItemEntity>> fetchPurchaseItemDataByID(
      {required int id}) async {
    var either = await prRequestManager.fetchPurchaseItemDataByID(id: id);
    return either.fold((l) => left(l), (r) => right(r));
  }
}
