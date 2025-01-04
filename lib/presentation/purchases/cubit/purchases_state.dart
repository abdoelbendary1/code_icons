// ignore_for_file: must_be_immutable, camel_case_types

import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/invoice/invoice_tax_dm.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/invoice/customers/invoice_customer_entity.dart';
import 'package:code_icons/domain/entities/invoice/drawer/drawer_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/entities/sysSettings/sys_settings_entity.dart';
import 'package:equatable/equatable.dart';

sealed class PurchasesState extends Equatable {
  const PurchasesState();

  @override
  List<Object> get props => [];
}

final class PurchasesInitial extends PurchasesState {}

class GetCustomerInvoicesSuccess extends PurchasesState {
  List<InvoiceReportDm> invoices;
  GetCustomerInvoicesSuccess({required this.invoices});
}

class UpdatePrReturnLoading extends PurchasesState {}

final class UpdateTradeStatusTypeLoading extends PurchasesState {}

final class UpdateTradeStatusTypeSuccess extends PurchasesState {
  Map<String, dynamic>? selectedTradeStatusType;
  String? type;
  UpdateTradeStatusTypeSuccess({
    required this.selectedTradeStatusType,
    this.type,
  });
}

final class selectItemSuccess extends PurchasesState {
  PurchaseItemEntity purchaseItemEntity;
  selectItemSuccess({required this.purchaseItemEntity});
}

final class getStoreDataSuccess extends PurchasesState {
  List<StoreEntity> storeDataList;
  getStoreDataSuccess({required this.storeDataList});
}

final class AddPurchasesReturnSuccess extends PurchasesState {
  int invoiceId;
  AddPurchasesReturnSuccess({required this.invoiceId});
}

final class getStoreDataError extends PurchasesState {
  String errorMsg;
  getStoreDataError({required this.errorMsg});
}

final class getItemDataByIDError extends PurchasesState {
  String errorMsg;
  getItemDataByIDError({required this.errorMsg});
}

final class DeletePRbyIDError extends PurchasesState {
  String errorMsg;
  DeletePRbyIDError({required this.errorMsg});
}

final class GetPRbyIDError extends PurchasesState {
  String errorMsg;
  GetPRbyIDError({required this.errorMsg});
}

final class DeletePRbyIDSuccess extends PurchasesState {
  GetAllPurchasesRequestEntity purchasesRequestEntity;
  DeletePRbyIDSuccess({required this.purchasesRequestEntity});
}

final class GetPRbyIDSuccess extends PurchasesState {
  GetAllPurchasesRequestEntity purchasesRequestEntity;
  GetPRbyIDSuccess({required this.purchasesRequestEntity});
}

final class getItemDataByIDSuccess extends PurchasesState {
  SalesItemDm salesItemDm;
  getItemDataByIDSuccess({required this.salesItemDm});
}

final class getCostCenterSuccess extends PurchasesState {
  List<CostCenterEntity> costCenterList;
  getCostCenterSuccess({required this.costCenterList});
}

final class getCostCenterError extends PurchasesState {
  String errorMsg;
  getCostCenterError({required this.errorMsg});
}

final class GetUomDatSuccess extends PurchasesState {
  List<UomEntity> uomList;
  GetUomDatSuccess({required this.uomList});
}

final class getUomDataError extends PurchasesState {
  String errorMsg;
  getUomDataError({required this.errorMsg});
}

final class AddPurchasesRequestLoading extends PurchasesState {}

final class AddPurchasesRequestError extends PurchasesState {
  String errorMsg;
  AddPurchasesRequestError({
    required this.errorMsg,
  });
}

final class AddPurchasesRequestSuccess extends PurchasesState {}

final class AddPurchasesInvoiceSuccess extends PurchasesState {
  int invoiceId;
  AddPurchasesInvoiceSuccess({required this.invoiceId});
}

final class AddPurchasesItemInitial extends PurchasesState {}

final class AddPurchasesItemError extends PurchasesState {
  String errorMsg;
  AddPurchasesItemError({
    required this.errorMsg,
  });
}

final class AddPurchasesItemloading extends PurchasesState {}

final class AddPurchasesItemSuccess extends PurchasesState {
  List<InvoiceItemDetailsDm> selectedItemsList;
  AddPurchasesItemSuccess({required this.selectedItemsList});
}

final class GetPurchasesListloading extends PurchasesState {}

final class GetPurchasesListError extends PurchasesState {
  String errorMsg;
  GetPurchasesListError({required this.errorMsg});
}

final class GetPurchasesListSuccess extends PurchasesState {
  List<GetAllPurchasesRequestEntity> purchases;
  GetPurchasesListSuccess({required this.purchases});
}

class PurchasesItemSelected extends PurchasesState {
  final PurchaseItemEntity selectedItem;

  const PurchasesItemSelected(
    this.selectedItem,
  );
} // ignore_for_file: public_member_api_docs, sort_constructors_first

class SalesInvoiceInitial extends PurchasesState {}

class SalesInvoiceLoading extends PurchasesState {}

class AddSalesCustomerLoading extends PurchasesState {}

class AddSalesCustomerSuccess extends PurchasesState {
  InvoiceCustomerEntity customerEntity;
  AddSalesCustomerSuccess({
    required this.customerEntity,
  });
}

class FetchCustomersSuccess extends PurchasesState {
  List<InvoiceCustomerEntity> customers;
  FetchCustomersSuccess({required this.customers});
}

class FetchCustomersError extends PurchasesState {
  String errorMsg;
  FetchCustomersError({required this.errorMsg});
}

class GetAllInvoicesLoading extends PurchasesState {}

class GetAllPrRerturnsLoading extends PurchasesState {}

class GetAllInvoicesSuccess extends PurchasesState {
  List<PrInvoiceDm> invoices;
  GetAllInvoicesSuccess({required this.invoices});
}

class GetAllInvoicesError extends PurchasesState {
  String errorMsg;
  GetAllInvoicesError({required this.errorMsg});
}

class GetAllPrReturnsSuccess extends PurchasesState {
  List<PrReturnDM> returns;
  GetAllPrReturnsSuccess({required this.returns});
}

class GetAllPrReturnsError extends PurchasesState {
  String errorMsg;
  GetAllPrReturnsError({required this.errorMsg});
}

final class getCurrencyDataSuccess extends PurchasesState {
  List<CurrencyEntity> currencyDataList;
  getCurrencyDataSuccess({
    required this.currencyDataList,
  });
}

final class getCurrencyDataError extends PurchasesState {
  String errorMsg;
  getCurrencyDataError({required this.errorMsg});
}

final class getDrawerDataSuccess extends PurchasesState {
  List<DrawerEntity> drawerDataList;
  getDrawerDataSuccess({
    required this.drawerDataList,
  });
}

final class getDrawerDataError extends PurchasesState {
  String errorMsg;
  getDrawerDataError({required this.errorMsg});
}

final class getImageDataSuccess extends PurchasesState {
  String? imageData;
  getImageDataSuccess({
    required this.imageData,
  });
}

final class getImageDataError extends PurchasesState {
  String errorMsg;
  getImageDataError({required this.errorMsg});
}

final class getItemDataByIDLoading extends PurchasesState {}

final class removeItemDataByIDLoading extends PurchasesState {}

final class removeItemDataByIDSuccess extends PurchasesState {}

final class removeItemDataByIDError extends PurchasesState {}

final class GetTaxByIDError extends PurchasesState {
  String errorMsg;
  GetTaxByIDError({required this.errorMsg});
}

final class GetTaxByIDSuccess extends PurchasesState {
  InvoiceTaxDm invoiceTaxDm;
  GetTaxByIDSuccess({required this.invoiceTaxDm});
}

final class GetAllDatSuccess extends PurchasesState {}

class UpdateRateSuccess extends PurchasesState {
  CurrencyEntity selectedCurrency;
  UpdateRateSuccess({
    required this.selectedCurrency,
  });
}

final class SysSettingsLoadFailure extends PurchasesState {
  String errorMsg;
  SysSettingsLoadFailure({required this.errorMsg});
}

class SysSettingsLoadSuccess extends PurchasesState {
  SysSettingsEntity settingsEntity;
  SysSettingsLoadSuccess({
    required this.settingsEntity,
  });
}

final class UpdatePurchasesRequestSuccess extends PurchasesState {
  UpdatePurchasesRequestSuccess();
}

final class EditPurchasesItemSuccess extends PurchasesState {
  InvoiceItemDetailsDm selectedItem;
  List<InvoiceItemDetailsDm> selectedItemsList;
  SalesItemDm salesItemDm;
  EditPurchasesItemSuccess({
    required this.selectedItem,
    required this.salesItemDm,
    required this.selectedItemsList,
  });
}

final class GetInvoiceItemsSuccess extends PurchasesState {
  List<InvoiceItemDetailsDm> selectedItemsList;
  GetInvoiceItemsSuccess({
    required this.selectedItemsList,
  });
}

class PurchasesItemSelectedLoading extends PurchasesState {}
