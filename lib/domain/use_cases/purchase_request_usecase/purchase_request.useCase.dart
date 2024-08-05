// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/repository/repository/Purchase_request_dart.dart';
import 'package:dartz/dartz.dart';

class PurchaseRequestsUseCases {
  PurchaseRequestRepo purchaseRequestRepo;
  PurchaseRequestsUseCases({
    required this.purchaseRequestRepo,
  });
  Future<Either<Failures, List<PurchaseItemEntity>>>
      fetchPurchaseItemData() async {
    return await purchaseRequestRepo.fetchPurchaseItemData();
  }

  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchPurchaseRequests() async {
    return await purchaseRequestRepo.fetchPurchaseRequests();
  }

  Future<Either<Failures, List<StoreEntity>>> fetchStoreData() async {
    return await purchaseRequestRepo.fetchStoreData();
  }

  Future<Either<Failures, List<CostCenterEntity>>> fetchCostCenterData() async {
    return await purchaseRequestRepo.fetchCostCenterData();
  }

  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchAllPurchaseRequests() async {
    return await purchaseRequestRepo.fetchAllPurchaseRequests();
  }

  Future<Either<Failures, List<UomEntity>>> fetchUOMData() async {
    return await purchaseRequestRepo.fetchUOMData();
  }

  Future<Either<Failures, String>> postPurchaseRequest({
    required PurchaseRequestDataModel purchaseRequestDataModel,
  }) async {
    return await purchaseRequestRepo.postPurchaseRequest(
        purchaseRequestDataModel: purchaseRequestDataModel);
  }

  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      deletePurchaseRequestById({required int id}) {
    return purchaseRequestRepo.deletePurchaseRequestById(id: id);
  }

  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      fetchPurchaseRequestById({required int id}) {
    return purchaseRequestRepo.fetchPurchaseRequestById(id: id);
  }

  Future<Either<Failures, PurchaseItemEntity>> fetchPurchaseItemDataByID(
      {required int id}) {
    return purchaseRequestRepo.fetchPurchaseItemDataByID(id: id);
  }
}
