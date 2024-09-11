part of 'purchase_order_cubit.dart';

sealed class PurchaseOrderState extends Equatable {
  const PurchaseOrderState();

  @override
  List<Object> get props => [];
}

class PurchaseOrderInitial extends PurchaseOrderState {}

// States for deletePurchaseOrderById
class DeletePurchaseOrderLoading extends PurchaseOrderState {}

class DeletePurchaseOrderSuccess extends PurchaseOrderState {
  final String message;

  const DeletePurchaseOrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DeletePurchaseOrderError extends PurchaseOrderState {
  final String errorMessage;

  const DeletePurchaseOrderError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for fetchTaxes
class FetchTaxesLoading extends PurchaseOrderState {}

class FetchTaxesSuccess extends PurchaseOrderState {
  final String message;

  const FetchTaxesSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FetchTaxesError extends PurchaseOrderState {
  final String errorMessage;

  const FetchTaxesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for fetchVendors
class FetchVendorsLoading extends PurchaseOrderState {}

class FetchVendorsSuccess extends PurchaseOrderState {
  final String message;

  const FetchVendorsSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FetchVendorsError extends PurchaseOrderState {
  final String errorMessage;

  const FetchVendorsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for getPurchaseOrder
class GetPurchaseOrderLoading extends PurchaseOrderState {}

class GetPurchaseOrderSuccess extends PurchaseOrderState {
  final String message;

  const GetPurchaseOrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class GetPurchaseOrderError extends PurchaseOrderState {
  final String errorMessage;

  const GetPurchaseOrderError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for getPurchaseOrderById
class GetPurchaseOrderByIdLoading extends PurchaseOrderState {}

class GetPurchaseOrderByIdSuccess extends PurchaseOrderState {
  final String message;

  const GetPurchaseOrderByIdSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class GetPurchaseOrderByIdError extends PurchaseOrderState {
  final String errorMessage;

  const GetPurchaseOrderByIdError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// States for postPurchaseOrder
class PostPurchaseOrderLoading extends PurchaseOrderState {}

class PostPurchaseOrderSuccess extends PurchaseOrderState {
  final String message;

  const PostPurchaseOrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class PostPurchaseOrderError extends PurchaseOrderState {
  final String errorMessage;

  const PostPurchaseOrderError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
