part of 'purchase_request_cubit.dart';

sealed class PurchaseRequestState extends Equatable {
  const PurchaseRequestState();

  @override
  List<Object> get props => [];
}

final class PurchaseRequestInitial extends PurchaseRequestState {}
