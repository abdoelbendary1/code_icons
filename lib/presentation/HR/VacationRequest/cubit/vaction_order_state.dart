part of 'vaction_order_cubit.dart';

sealed class VactionOrderState extends Equatable {
  const VactionOrderState();

  @override
  List<Object> get props => [];
}

final class VactionOrderInitial extends VactionOrderState {}

final class GetVactionTypesError extends VactionOrderState {
  String errorMessage;
  GetVactionTypesError({required this.errorMessage});
}

final class GetVactionTypesSuccess extends VactionOrderState {
  List<VacationTypeEntity> vacationTypeEntityList;
  GetVactionTypesSuccess({required this.vacationTypeEntityList});
}

final class addVacationRequestError extends VactionOrderState {
  String errorMessage;
  addVacationRequestError({required this.errorMessage});
}

final class addVacationRequestSuccess extends VactionOrderState {
  int? requestID;
  addVacationRequestSuccess({this.requestID});
}
