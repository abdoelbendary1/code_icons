part of 'absenceCubit.dart';

sealed class absenceRequestState extends Equatable {
  const absenceRequestState();

  @override
  List<Object> get props => [];
}

final class absenceRequestInitial extends absenceRequestState {}

final class addabsenceRequestError extends absenceRequestState {
  String errorMessage;
  addabsenceRequestError({required this.errorMessage});
}

final class addabsenceRequestSuccess extends absenceRequestState {
  int? requestID;
  addabsenceRequestSuccess({this.requestID});
}
