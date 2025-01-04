// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:code_icons/data/api/Sales/Invoice/Invoice_interface.dart';
import 'package:code_icons/data/api/Sales/permissions/sl_permissions_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/data/model/response/invoice/drawer_dm.dart';
import 'package:code_icons/data/model/response/invoice/invoice_tax_dm.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class InvoiceUseCases {
  InvoiceInterface invoiceInterface;
  InvoiceUseCases({
    required this.invoiceInterface,
  });
  Future<Either<Failures, List<InvoiceCustomerDm>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  }) async {
    return await invoiceInterface.fetchCustomerData(
        skip: skip, take: take, filter: filter);
  }

  Future<Either<Failures, String>> getImageFromAPI(
      {required String id, required BuildContext context}) async {
    return await invoiceInterface.getImageFromAPI(id: id, context: context);
  }

  Future<Either<Failures, List<InvoiceReportDm>>>
      fetchAllSalesInvoiceData() async {
    return await invoiceInterface.fetchAllSalesInvoiceData();
  }

  Future<Either<Failures, List<InvoiceReportDm>>>
      fetchAllSalesReturnsData() async {
    return await invoiceInterface.fetchAllSalesReturnseData();
  }

  Future<Either<Failures, List<CurrencyDataModel>>> fetchCurrencyData() async {
    return await invoiceInterface.fetchCurrencyData();
  }

  Future<Either<Failures, List<StoreEntity>>> fetchStoreData() async {
    return await invoiceInterface.fetchStoreData();
  }

  Future<Either<Failures, SlPermissionsDm>> fetchSLPermissionsData() async {
    return await invoiceInterface.fetchSLPermissionsData();
  }

  Future<Either<Failures, List<CostCenterEntity>>> fetchCostCenterData() async {
    return await invoiceInterface.fetchCostCenterData();
  }

  Future<Either<Failures, List<DrawerDm>>> fetchDrawerData() async {
    return await invoiceInterface.fetchDrawerData();
  }

  Future<Either<Failures, DrawerDm>> fetchDrawerDataById(
      {required int drawerId}) async {
    return await invoiceInterface.fetchDrawerDataById(drawerId: drawerId);
  }

  Future<Either<Failures, List<UomEntity>>> fetchUOMData() async {
    return await invoiceInterface.fetchUOMData();
  }

  Future<Either<Failures, int>> postSalesReport({
    required InvoiceReportDm invoiceReportDm,
  }) async {
    return await invoiceInterface.postInvoiceRequest(invoiceReportDm);
  }

  Future<Either<Failures, int>> postSalesReturnReport({
    required InvoiceReportDm invoiceReportDm,
  }) async {
    return await invoiceInterface.postSlReturnRequest(invoiceReportDm);
  }

  Future<Either<Failures, int>> postPrReturnReport({
    required PrInvoiceReportDm invoiceReportDm,
  }) async {
    return await invoiceInterface.postPrReturnRequest(invoiceReportDm);
  }

  Future<Either<Failures, InvoiceReportDm>> updateInvoiceRequest(
      {required InvoiceReportDm invoiceReportDm, required int id}) async {
    return await invoiceInterface.updateInvoiceRequest(
        invoiceReportDm: invoiceReportDm, id: id);
  }

  Future<Either<Failures, InvoiceReportDm>> updateReturnRequest(
      {required InvoiceReportDm invoiceReportDm, required int id}) async {
    return await invoiceInterface.updateReturnRequest(
        invoiceReportDm: invoiceReportDm, id: id);
  }

  Future<Either<Failures, PrReturnDM>> updatePrReturnRequest(
      {required PrReturnDM invoiceReportDm, required int id}) async {
    return await invoiceInterface.updatePrReturnRequest(
        invoiceReportDm: invoiceReportDm, id: id);
  }

  Future<Either<Failures, GetAllPurchasesRequestEntity>> deleteSalesInvoiceById(
      {required int id}) {
    return invoiceInterface.deleteSalesInvoiceById(id: id);
  }

  Future<Either<Failures, InvoiceReportDm>> fetchSalesInvoiceDataByID(
      {required int id}) {
    return invoiceInterface.fetchSalesInvoiceDataByID(id: id);
  }

  Future<Either<Failures, InvoiceReportDm>> fetchSalesReturnDataByID(
      {required int id}) {
    return invoiceInterface.fetchSalesReturnDataByID(id: id);
  }

  Future<Either<Failures, int>> postCustomerRequest(
      InvoiceCustomerDm invoiceCustomerDm) {
    return invoiceInterface.postCustomerRequest(invoiceCustomerDm);
  }

  Future<Either<Failures, List<SalesItemDm>>> fetchPurchaseItemData() async {
    return await invoiceInterface.fetchPurchaseItemData();
  }

  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchPurchaseRequests() async {
    return await invoiceInterface.fetchPurchaseRequests();
  }

  Future<Either<Failures, InvoiceTaxDm>> fetchTaxByID({required int id}) async {
    return await invoiceInterface.fetchTaxByID(id: id);
  }

  Future<Either<Failures, List<InvoiceTaxDm>>> fetchAllTaxes() async {
    return await invoiceInterface.fetchAllTaxes();
  }

  /*  Future<Either<Failures, List<GetAllPurchasesRequestEntity>>>
      fetchAllPurchaseRequests() async {
    return await invoiceInterface.fetchAllPurchaseRequests();
  } */

  /*  Future<Either<Failures, String>> postPurchaseRequest({
    required PurchaseRequestDataModel purchaseRequestDataModel,
  }) async {
    return await invoiceInterface.postPurchaseRequest(
        purchaseRequestDataModel: purchaseRequestDataModel);
  } */

  Future<Either<Failures, GetAllPurchasesRequestEntity>>
      deletePurchaseRequestById({required int id}) {
    return invoiceInterface.deletePurchaseRequestById(id: id);
  }

  Future<Either<Failures, SalesItemDm>> fetchPurchaseItemDataByID(
      {required int id}) {
    return invoiceInterface.fetchPurchaseItemDataByID(id: id);
  }
}
