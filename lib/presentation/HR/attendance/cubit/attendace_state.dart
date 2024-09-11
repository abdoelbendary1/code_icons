part of 'attendace_cubit.dart';

sealed class AttendaceState extends Equatable {
  const AttendaceState();

  @override
  List<Object> get props => [];
}

final class AttendaceInitial extends AttendaceState {}

final class AddAttendaceSheetSuccess extends AttendaceState {}

final class AddAttendaceSheetError extends AttendaceState {
  String errorMessage;
  AddAttendaceSheetError({required this.errorMessage});
}

final class UpdateAttendaceSheetSuccess extends AttendaceState {}

final class UpdateAttendaceSheetError extends AttendaceState {
  String errorMessage;
  UpdateAttendaceSheetError({required this.errorMessage});
}

final class GetAttendaceByIDError extends AttendaceState {
  String errorMessage;
  GetAttendaceByIDError({required this.errorMessage});
}

final class GetAttendaceByIDLoading extends AttendaceState {}

final class GetAttendaceByIDSuccess extends AttendaceState {
  AttendanceResponseEntity entity;
  GetAttendaceByIDSuccess({required this.entity});
}
