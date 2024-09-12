// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_collection_cubit.dart';

@immutable
sealed class AddCollectionState {}

class SelecetedCustomer extends AddCollectionState {
  CustomerDataEntity customer;
  SelecetedCustomer({
    required this.customer,
  });
}

final class AddCollectionLoading extends AddCollectionState {}

final class CustomerDataLoaded extends AddCollectionState {
  List<CustomerDataEntity>? customerData;
  CustomerDataLoaded({required this.customerData});
}

final class CustomerDataError extends AddCollectionState {}

final class AddCollectionError extends AddCollectionState {
  late String errorMsg;
  AddCollectionError({required this.errorMsg});
}

final class AddCollectionSucces extends AddCollectionState {
  TradeCollectionEntity tradeCollectionEntity;
  AddCollectionSucces({required this.tradeCollectionEntity});
}

final class GetAllCustomerDataInitial extends AddCollectionState {}

final class GetAllCustomerDataError extends AddCollectionState {
  String errorMsg;
  GetAllCustomerDataError({required this.errorMsg});
}

final class GetAllCustomerDataLoading extends AddCollectionState {}

// ignore: must_be_immutable
final class GetAllCustomerDataSuccess extends AddCollectionState {
  List<CustomerDataEntity>? customerData;
  CustomerDataEntity? selectedCustomer;
  List<RecietCollectionDataModel>? receipts;
  GetAllCustomerDataSuccess({
    this.customerData,
    this.selectedCustomer,
    this.receipts,
  });
}

final class GetCustomerDataByIDInitial extends AddCollectionState {
  List<TextEditingController> controllers;
  GetCustomerDataByIDInitial({required this.controllers});
}

final class GetCustomerDataByIDError extends AddCollectionState {
  String errorMsg;
  GetCustomerDataByIDError({required this.errorMsg});
}

final class GetpaymentValuesByIDError extends AddCollectionState {
  String errorMsg;
  GetpaymentValuesByIDError({required this.errorMsg});
}

final class GetCustomerDataByIDLoading extends AddCollectionState {}

// ignore: must_be_immutable
final class GetCustomerDataByIDSuccess extends AddCollectionState {
  CustomerDataEntity customerData;
  List<TextEditingController>? controllers;
  /* List<Map<dynamic, dynamic>> yearsOfPayment; */
  GetCustomerDataByIDSuccess({
    required this.customerData,
     this.controllers,
  });
}

class YearsUpdatedState extends AddCollectionState {
  final List<Map<String, dynamic>> years;
  YearsUpdatedState({required this.years});

  @override
  List<Object> get props => [years];
}
