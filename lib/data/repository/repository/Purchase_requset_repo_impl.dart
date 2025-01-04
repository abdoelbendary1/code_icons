// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/update_pr_invoice_request/update_pr_invoice_request.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';
import 'package:dartz/dartz.dart';

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
  Future<Either<Failures, List<PrInvoiceDm>>> fetchPrInvoicesData() {
    return purchaseRequestRemoteDataSource.fetchPrInvoicesData();
  }

  @override
  Future<Either<Failures, String>> postPurchaseRequest(
      {required InvoiceReportDm purchaseRequestDataModel}) {
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
  Future<Either<Failures, PrInvoiceDm>> fetchPrInvoicesDataById(
      {required int id}) {
    return purchaseRequestRemoteDataSource.fetchPrInvoicesDataById(id: id);
  }

  @override
  Future<Either<Failures, PurchaseItemEntity>> fetchPurchaseItemDataByID(
      {required int id}) {
    return purchaseRequestRemoteDataSource.fetchPurchaseItemDataByID(id: id);
  }

  @override
  Future<Either<Failures, VendorsEntity>> fetchVendorByID({required int id}) {
    return purchaseRequestRemoteDataSource.fetchVendorByID(id: id);
  }

  @override
  Future<Either<Failures, List<VendorsEntity>>> fetchVendors() {
    return purchaseRequestRemoteDataSource.fetchVendors();
  }

  @override
  Future<Either<Failures, int>> postPurchaseInvoice(
      {required PrInvoiceRequest purchaseRequestDataModel}) {
    return purchaseRequestRemoteDataSource.postPurchaseInvoice(
        purchaseRequestDataModel: purchaseRequestDataModel);
  }

  @override
  Future<Either<Failures, List<PrReturnDM>>> fetchPrReturnsData() async {
    return purchaseRequestRemoteDataSource.fetchPrReturnsData();
  }

  @override
  Future<Either<Failures, PrReturnDM>> fetchPrReturnsDataByID(
      {required int id}) async {
    return purchaseRequestRemoteDataSource.fetchPrReturnsDataByID(id: id);
  }

  @override
  Future<Either<Failures, PrInvoiceReportDm>> updateInvoiceRequest(
      {required UpdatePrInvoiceRequest purchaseRequestDataModel, required int id}) {
    return purchaseRequestRemoteDataSource.updateInvoiceRequest(
        purchaseRequestDataModel: purchaseRequestDataModel, id: id);
  }
}
