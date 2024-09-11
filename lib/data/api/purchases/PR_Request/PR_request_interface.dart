import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PrRequestInterface {
  Future<Either<Failures, List<PurchaseItemDataModel>>> fetchPurchaseItemData();
  Future<Either<Failures, PurchaseItemDataModel>> fetchPurchaseItemDataByID(
      {required int id});
  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchPurchaseRequests();
  Future<Either<Failures, GetAllPurchasesRequests>> fetchPurchaseRequestById(
      {required int id});
  Future<Either<Failures, GetAllPurchasesRequests>> deletePurchaseRequestById(
      {required int id});
  Future<Either<Failures, List<StoreDataModel>>> fetchStoreData();
  Future<Either<Failures, List<CostCenterDataModel>>> fetchCostCenterData();
  Future<Either<Failures, String>> postPurchaseRequest(
      PurchaseRequestDataModel purchaseRequestDataModel);
  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchAllPurchaseRequests();
  Future<Either<Failures, List<UomDataModel>>> fetchUOMData();
  Future<Either<Failures, CurrencyDataModel>> fetchCurrencyDataById(
      {required int currencyId});
  Future<Either<Failures, List<CurrencyDataModel>>> fetchCurrencyData();
}
