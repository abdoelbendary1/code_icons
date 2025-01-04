import 'package:code_icons/data/api/Sales/permissions/sl_permissions_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/data/model/response/invoice/drawer_dm.dart';
import 'package:code_icons/data/model/response/invoice/invoice_tax_dm.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class InvoiceInterface {
  Future<Either<Failures, List<InvoiceReportDm>>> fetchAllSalesInvoiceData();
  Future<Either<Failures, List<InvoiceReportDm>>> fetchAllSalesReturnseData();
  Future<Either<Failures, InvoiceReportDm>> updateInvoiceRequest(
      {required InvoiceReportDm invoiceReportDm, required int id});
  Future<Either<Failures, String>> getImageFromAPI(
      {required String id, required BuildContext context});
  Future<Either<Failures, InvoiceReportDm>> updateReturnRequest(
      {required InvoiceReportDm invoiceReportDm, required int id});
  Future<Either<Failures, PrReturnDM>> updatePrReturnRequest(
      {required PrReturnDM invoiceReportDm, required int id});
  Future<Either<Failures, int>> postCustomerRequest(
      InvoiceCustomerDm invoiceCustomerDm);

  Future<Either<Failures, InvoiceReportDm>> fetchSalesInvoiceDataByID(
      {required int id});
  Future<Either<Failures, InvoiceReportDm>> fetchSalesReturnDataByID(
      {required int id});
  Future<Either<Failures, GetAllPurchasesRequests>> deleteSalesInvoiceById(
      {required int id});
  Future<Either<Failures, SlPermissionsDm>> fetchSLPermissionsData();

  Future<Either<Failures, List<StoreDataModel>>> fetchStoreData();
  Future<Either<Failures, List<CostCenterDataModel>>> fetchCostCenterData();
  Future<Either<Failures, int>> postInvoiceRequest(
      InvoiceReportDm invoiceReportDm);
  Future<Either<Failures, int>> postSlReturnRequest(
      InvoiceReportDm invoiceReportDm);
  Future<Either<Failures, int>> postPrReturnRequest(
      PrInvoiceReportDm invoiceReportDm);
  /*  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchAllPurchaseRequests(); */
  Future<Either<Failures, List<UomDataModel>>> fetchUOMData();
  Future<Either<Failures, CurrencyDataModel>> fetchCurrencyDataById(
      {required int currencyId});
  Future<Either<Failures, List<CurrencyDataModel>>> fetchCurrencyData();
  Future<Either<Failures, List<DrawerDm>>> fetchDrawerData();
  Future<Either<Failures, DrawerDm>> fetchDrawerDataById(
      {required int drawerId});

  Future<Either<Failures, List<InvoiceCustomerDm>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  });
  Future<Either<Failures, List<SalesItemDm>>> fetchPurchaseItemData();
  Future<Either<Failures, SalesItemDm>> fetchPurchaseItemDataByID(
      {required int id});
  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchPurchaseRequests();
  Future<Either<Failures, GetAllPurchasesRequests>> fetchPurchaseRequestById(
      {required int id});
  Future<Either<Failures, GetAllPurchasesRequests>> deletePurchaseRequestById(
      {required int id});
  Future<Either<Failures, InvoiceTaxDm>> fetchTaxByID({required int id});
  Future<Either<Failures, List<InvoiceTaxDm>>> fetchAllTaxes();
}
