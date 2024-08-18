part of 'purchases_cubit.dart';

sealed class PurchasesState extends Equatable {
  const PurchasesState();

  @override
  List<Object> get props => [];
}

final class PurchasesInitial extends PurchasesState {}

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
  PurchaseItemEntity purchaseItemEntity;
  getItemDataByIDSuccess({required this.purchaseItemEntity});
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

final class AddPurchasesItemInitial extends PurchasesState {}

final class AddPurchasesItemError extends PurchasesState {
  String errorMsg;
  AddPurchasesItemError({
    required this.errorMsg,
  });
}

final class AddPurchasesItemloading extends PurchasesState {}

final class AddPurchasesItemSuccess extends PurchasesState {
  List<ItemsDetails> selectedItemsList;
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

  PurchasesItemSelected(
    this.selectedItem,
  );
}

class PurchasesItemSelectedLoading extends PurchasesState {}
