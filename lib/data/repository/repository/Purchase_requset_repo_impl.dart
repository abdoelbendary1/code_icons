// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/repository/data_source/purchase_request_remote_data_source.dart';
import 'package:code_icons/domain/repository/repository/Purchase_request_dart.dart';

class PurchaseRequestRepoImpl implements PurchaseRequestRepo {
  PurchaseRequestRemoteDataSource purchaseRequestRemoteDataSource;
  PurchaseRequestRepoImpl({
    required this.purchaseRequestRemoteDataSource,
  });
  @override
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchAllPurchaseRequests() {
    return purchaseRequestRemoteDataSource.fetchAllPurchaseRequests();
  }

  @override
  Future<Either<Failures, List<CostCenterEntity>>> fetchCostCenterData() {
    return purchaseRequestRemoteDataSource.fetchCostCenterData();
  }

  @override
  Future<Either<Failures, List<PurchaseItemEntity>>> fetchPurchaseItemData() {
    return purchaseRequestRemoteDataSource.fetchPurchaseItemData();
  }

  @override
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchPurchaseRequests() {
    return purchaseRequestRemoteDataSource.fetchPurchaseRequests();
  }

  @override
  Future<Either<Failures, List<StoreEntity>>> fetchStoreData() {
    return purchaseRequestRemoteDataSource.fetchStoreData();
  }

  @override
  Future<Either<Failures, List<UomEntity>>> fetchUOMData() {
    return purchaseRequestRemoteDataSource.fetchUOMData();
  }

  @override
  Future<Either<Failures, String>> postPurchaseRequest(
      {required PurchaseRequestDataModel purchaseRequestDataModel}) {
    return purchaseRequestRemoteDataSource.postPurchaseRequest(
        purchaseRequestDataModel: purchaseRequestDataModel);
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      deletePurchaseRequestById({required int id}) {
    return purchaseRequestRemoteDataSource.deletePurchaseRequestById(id: id);
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      fetchPurchaseRequestById({required int id}) {
    return purchaseRequestRemoteDataSource.fetchPurchaseRequestById(id: id);
  }

  @override
  Future<Either<Failures, PurchaseItemEntity>> fetchPurchaseItemDataByID(
      {required int id}) {
    return purchaseRequestRemoteDataSource.fetchPurchaseItemDataByID(id: id);
  }
}
