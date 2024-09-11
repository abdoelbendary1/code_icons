part of 'Loan_order_cubit.dart';

sealed class LoanRequestState extends Equatable {
  const LoanRequestState();

  @override
  List<Object> get props => [];
}

final class LoanRequestInitial extends LoanRequestState {}

final class addLoanRequestError extends LoanRequestState {
  String errorMessage;
  addLoanRequestError({required this.errorMessage});
}

final class addLoanRequestSuccess extends LoanRequestState {
  int? requestID;
  addLoanRequestSuccess({this.requestID});
}
