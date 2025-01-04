import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/update_pr_invoice_request/update_pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PurchaseRequestRepo {
  Future<Either<Failures, List<PurchaseItemEntity>>> fetchPurchaseItemData();
  Future<Either<Failures, List<VendorsEntity>>> fetchVendors();
  Future<Either<Failures, VendorsEntity>> fetchVendorByID({required int id});

  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchPurchaseRequests();
  Future<Either<Failures, PrReturnDM>> fetchPrReturnsDataByID(
      {required int id});
  Future<Either<Failures, List<PrInvoiceDm>>> fetchPrInvoicesData();
  Future<Either<Failures, List<PrReturnDM>>> fetchPrReturnsData();

  Future<Either<Failures, PrInvoiceDm>> fetchPrInvoicesDataById(
      {required int id});

  Future<Either<Failures, List<StoreEntity>>> fetchStoreData();
  Future<Either<Failures, List<CostCenterEntity>>> fetchCostCenterData();
  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchAllPurchaseRequests();
  Future<Either<Failures, List<UomEntity>>> fetchUOMData();
  Future<Either<Failures, String>> postPurchaseRequest(
      {required InvoiceReportDm purchaseRequestDataModel});
  Future<Either<Failures, int>> postPurchaseInvoice(
      {required PrInvoiceRequest purchaseRequestDataModel});
  Future<Either<Failures, PrInvoiceReportDm>> updateInvoiceRequest(
      {required UpdatePrInvoiceRequest purchaseRequestDataModel, required int id});
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      deletePurchaseRequestById({required int id});
  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      fetchPurchaseRequestById({required int id});
  Future<Either<Failures, PurchaseItemEntity>> fetchPurchaseItemDataByID(
      {required int id});
}
