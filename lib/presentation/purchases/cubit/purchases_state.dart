part of 'purchases_cubit.dart';

sealed class PurchasesState extends Equatable {
  const PurchasesState();

  @override
  List<Object> get props => [];
}

final class PurchasesInitial extends PurchasesState {}

final class UpdateTradeRegistryTypeLoading extends PurchasesState {}

final class UpdateTradeRegistryTypeSuccess extends PurchasesState {
  Map<String, dynamic>? selectedTradeRegistryType;
  String? type;
  UpdateTradeRegistryTypeSuccess({
    required this.selectedTradeRegistryType,
    this.type,
  });
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

final class AddPurchasesItemSuccess extends PurchasesState {}

final class GetPurchasesListloading extends PurchasesState {}

final class GetPurchasesListError extends PurchasesState {
  String errorMsg;
  GetPurchasesListError({required this.errorMsg});
}

final class GetPurchasesListSuccess extends PurchasesState {
  List<dynamic> purchases;
  GetPurchasesListSuccess({required this.purchases});
}
