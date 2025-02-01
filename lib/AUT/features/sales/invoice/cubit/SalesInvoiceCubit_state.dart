// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'SalesInvoiceCubit_cubit.dart';

sealed class SalesInvoiceState extends Equatable {
  const SalesInvoiceState();

  @override
  List<Object> get props => [];
}

class SalesInvoiceInitial extends SalesInvoiceState {}

class SalesInvoiceLoading extends SalesInvoiceState {}

class UpdateSalesInvoiceLoading extends SalesInvoiceState {}

class AddSalesCustomerLoading extends SalesInvoiceState {}

class AddSalesCustomerSuccess extends SalesInvoiceState {
  InvoiceCustomerEntity customerEntity;
  AddSalesCustomerSuccess({
    required this.customerEntity,
  });
}

final class UpdateTradeStatusTypeLoading extends SalesInvoiceState {}

final class UpdateTradeStatusTypeSuccess extends SalesInvoiceState {
  Map<String, dynamic>? selectedTradeStatusType;
  String? type;
  UpdateTradeStatusTypeSuccess({
    required this.selectedTradeStatusType,
    this.type,
  });
}

class FetchCustomersSuccess extends SalesInvoiceState {
  List<InvoiceCustomerEntity> customers;
  FetchCustomersSuccess({required this.customers});
}

class FetchCustomersError extends SalesInvoiceState {
  String errorMsg;
  FetchCustomersError({required this.errorMsg});
}

class GetAllInvoicesLoading extends SalesInvoiceState {}

class GetAllInvoicesSuccess extends SalesInvoiceState {
  List<InvoiceReportDm> invoices;
  GetAllInvoicesSuccess({required this.invoices});
}

class GetCustomerInvoicesSuccess extends SalesInvoiceState {
  List<InvoiceReportDm> invoices;
  GetCustomerInvoicesSuccess({required this.invoices});
}

class FetchInvoiceSuccess extends SalesInvoiceState {
  InvoiceReportDm invoice;
  FetchInvoiceSuccess({required this.invoice});
}

class GetAllInvoicesError extends SalesInvoiceState {
  String errorMsg;
  GetAllInvoicesError({required this.errorMsg});
}

final class selectItemSuccess extends SalesInvoiceState {
  PurchaseItemEntity purchaseItemEntity;
  selectItemSuccess({required this.purchaseItemEntity});
}

final class getStoreDataSuccess extends SalesInvoiceState {
  List<StoreEntity> storeDataList;
  getStoreDataSuccess({required this.storeDataList});
}

final class getStoreDataError extends SalesInvoiceState {
  String errorMsg;
  getStoreDataError({required this.errorMsg});
}

final class getCurrencyDataSuccess extends SalesInvoiceState {
  List<CurrencyEntity> currencyDataList;
  getCurrencyDataSuccess({
    required this.currencyDataList,
  });
}

final class getCurrencyDataError extends SalesInvoiceState {
  String errorMsg;
  getCurrencyDataError({required this.errorMsg});
}

final class getDrawerDataSuccess extends SalesInvoiceState {
  List<DrawerEntity> drawerDataList;
  getDrawerDataSuccess({
    required this.drawerDataList,
  });
}

final class getDrawerDataError extends SalesInvoiceState {
  String errorMsg;
  getDrawerDataError({required this.errorMsg});
}

final class getImageDataSuccess extends SalesInvoiceState {
  String? imageData;
  getImageDataSuccess({
    required this.imageData,
  });
}

final class getImageDataError extends SalesInvoiceState {
  String errorMsg;
  getImageDataError({required this.errorMsg});
}

final class getItemDataByIDError extends SalesInvoiceState {
  String errorMsg;
  getItemDataByIDError({required this.errorMsg});
}

final class getItemDataByIDLoading extends SalesInvoiceState {}

final class removeItemDataByIDLoading extends SalesInvoiceState {}

final class removeItemDataByIDSuccess extends SalesInvoiceState {}

final class removeItemDataByIDError extends SalesInvoiceState {}

final class DeletePRbyIDError extends SalesInvoiceState {
  String errorMsg;
  DeletePRbyIDError({required this.errorMsg});
}

final class GetPRbyIDError extends SalesInvoiceState {
  String errorMsg;
  GetPRbyIDError({required this.errorMsg});
}

final class GetTaxByIDError extends SalesInvoiceState {
  String errorMsg;
  GetTaxByIDError({required this.errorMsg});
}

final class GetTaxByIDSuccess extends SalesInvoiceState {
  InvoiceTaxDm invoiceTaxDm;
  GetTaxByIDSuccess({required this.invoiceTaxDm});
}

final class DeletePRbyIDSuccess extends SalesInvoiceState {
  GetAllPurchasesRequestEntity purchasesRequestEntity;
  DeletePRbyIDSuccess({required this.purchasesRequestEntity});
}

final class GetPRbyIDSuccess extends SalesInvoiceState {
  GetAllPurchasesRequestEntity purchasesRequestEntity;
  GetPRbyIDSuccess({required this.purchasesRequestEntity});
}

final class getItemDataByIDSuccess extends SalesInvoiceState {
  SalesItemDm salesItemDm;
  getItemDataByIDSuccess({required this.salesItemDm});
}

final class getCostCenterSuccess extends SalesInvoiceState {
  List<CostCenterEntity> costCenterList;
  getCostCenterSuccess({required this.costCenterList});
}

final class getCostCenterError extends SalesInvoiceState {
  String errorMsg;
  getCostCenterError({required this.errorMsg});
}

final class GetUomDatSuccess extends SalesInvoiceState {
  List<UomEntity> uomList;
  GetUomDatSuccess({required this.uomList});
}

final class GetAllDatSuccess extends SalesInvoiceState {}

class UpdateRateSuccess extends SalesInvoiceState {
  CurrencyEntity selectedCurrency;
  UpdateRateSuccess({
    required this.selectedCurrency,
  });
}

final class getUomDataError extends SalesInvoiceState {
  String errorMsg;
  getUomDataError({required this.errorMsg});
}

final class SysSettingsLoadFailure extends SalesInvoiceState {
  String errorMsg;
  SysSettingsLoadFailure({required this.errorMsg});
}

class SysSettingsLoadSuccess extends SalesInvoiceState {
  SysSettingsEntity settingsEntity;
  SysSettingsLoadSuccess({
    required this.settingsEntity,
  });
}

final class AddPurchasesRequestLoading extends SalesInvoiceState {}

final class AddPurchasesRequestError extends SalesInvoiceState {
  String errorMsg;
  AddPurchasesRequestError({
    required this.errorMsg,
  });
}

final class AddPurchasesRequestSuccess extends SalesInvoiceState {
  int invoiceId;
  AddPurchasesRequestSuccess({required this.invoiceId});
}

final class UpdatePurchasesRequestSuccess extends SalesInvoiceState {
  int invoiceId;
  UpdatePurchasesRequestSuccess({required this.invoiceId});
}

final class AddPurchasesItemInitial extends SalesInvoiceState {}

final class AddPurchasesItemError extends SalesInvoiceState {
  String errorMsg;
  AddPurchasesItemError({
    required this.errorMsg,
  });
}

final class AddPurchasesItemloading extends SalesInvoiceState {}

final class AddPurchasesItemSuccess extends SalesInvoiceState {
  List<InvoiceItemDetailsDm> selectedItemsList;
  AddPurchasesItemSuccess({required this.selectedItemsList});
}

final class EditPurchasesItemSuccess extends SalesInvoiceState {
  InvoiceItemDetailsDm selectedItem;
  List<InvoiceItemDetailsDm> selectedItemsList;
  SalesItemDm salesItemDm;
  EditPurchasesItemSuccess({
    required this.selectedItem,
    required this.salesItemDm,
    required this.selectedItemsList,
  });
}

final class GetInvoiceItemsSuccess extends SalesInvoiceState {
  List<InvoiceItemDetailsDm> selectedItemsList;
  GetInvoiceItemsSuccess({
    required this.selectedItemsList,
  });
}

final class GetPurchasesListloading extends SalesInvoiceState {}

final class GetPurchasesListError extends SalesInvoiceState {
  String errorMsg;
  GetPurchasesListError({required this.errorMsg});
}

final class GetPurchasesListSuccess extends SalesInvoiceState {
  List<GetAllPurchasesRequestEntity> purchases;
  GetPurchasesListSuccess({required this.purchases});
}

class PurchasesItemSelected extends SalesInvoiceState {
  final SalesItemDm selectedItem;

  PurchasesItemSelected(
    this.selectedItem,
  );
}

class PurchasesItemSelectedLoading extends SalesInvoiceState {}
