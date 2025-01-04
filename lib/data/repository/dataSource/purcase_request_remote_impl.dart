import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/api/purchases/PR_Request/PR_request_interface.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/update_pr_invoice_request/update_pr_invoice_request.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';
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
  Future<Either<Failures, List<PrInvoiceDm>>> fetchPrInvoicesData() async {
    var either = await prRequestManager.fetchPrInvoicesData();
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
      {required InvoiceReportDm purchaseRequestDataModel}) async {
    var either =
        await prRequestManager.postPurchaseRequest(purchaseRequestDataModel);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, int>> postPurchaseInvoice(
      {required PrInvoiceRequest purchaseRequestDataModel}) async {
    var either =
        await prRequestManager.postPurchaseInvoice(purchaseRequestDataModel);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, PrInvoiceReportDm>> updateInvoiceRequest(
      {required UpdatePrInvoiceRequest purchaseRequestDataModel,
      required int id}) async {
    var either = await prRequestManager.updateInvoiceRequest(
        purchaseRequestDataModel: purchaseRequestDataModel, id: id);
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

  @override
  Future<Either<Failures, List<VendorsEntity>>> fetchVendors() async {
    var either = await prRequestManager.fetchVendors();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, List<PrReturnDM>>> fetchPrReturnsData() async {
    var either = await prRequestManager.fetchPrReturnsData();
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, PrReturnDM>> fetchPrReturnsDataByID(
      {required int id}) async {
    var either = await prRequestManager.fetchPrReturnsDataByID(id: id);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, VendorsEntity>> fetchVendorByID(
      {required int id}) async {
    var either = await prRequestManager.fetchVendorByID(id: id);
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failures, PrInvoiceDm>> fetchPrInvoicesDataById(
      {required int id}) async {
    var either = await prRequestManager.fetchPrInvoicesDataById(id: id);
    return either.fold((l) => left(l), (r) => right(r));
  }
}
