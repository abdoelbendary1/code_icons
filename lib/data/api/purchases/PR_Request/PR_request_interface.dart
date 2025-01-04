import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/update_pr_invoice_request/update_pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';
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
  Future<Either<Failures, List<PrInvoiceDm>>> fetchPrInvoicesData();

  Future<Either<Failures, List<CostCenterDataModel>>> fetchCostCenterData();
  Future<Either<Failures, String>> postPurchaseRequest(
      InvoiceReportDm purchaseRequestDataModel);
  Future<Either<Failures, int>> postPurchaseInvoice(
      PrInvoiceRequest purchaseRequestDataModel);
  Future<Either<Failures, PrInvoiceReportDm>> updateInvoiceRequest(
      {required UpdatePrInvoiceRequest purchaseRequestDataModel, required int id});
  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchAllPurchaseRequests();
  Future<Either<Failures, List<PrReturnDM>>> fetchPrReturnsData();
  Future<Either<Failures, PrReturnDM>> fetchPrReturnsDataByID(
      {required int id});

  Future<Either<Failures, PrInvoiceDm>> fetchPrInvoicesDataById(
      {required int id});
  Future<Either<Failures, List<UomDataModel>>> fetchUOMData();
  Future<Either<Failures, CurrencyDataModel>> fetchCurrencyDataById(
      {required int currencyId});
  Future<Either<Failures, List<CurrencyDataModel>>> fetchCurrencyData();
  Future<Either<Failures, List<VendorsEntity>>> fetchVendors();
  Future<Either<Failures, VendorsEntity>> fetchVendorByID({required int id});
}
