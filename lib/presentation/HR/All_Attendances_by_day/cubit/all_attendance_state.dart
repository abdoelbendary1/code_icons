part of 'all_attendance_cubit.dart';

sealed class AllAttendanceState extends Equatable {
  const AllAttendanceState();

  @override
  List<Object> get props => [];
}

final class AllAttendanceInitial extends AllAttendanceState {}

final class DeleteAttendanceError extends AllAttendanceState {
  String errorMsg;
  DeleteAttendanceError({required this.errorMsg});
}

final class GetAllAttendanceError extends AllAttendanceState {
  String errorMsg;
  GetAllAttendanceError({required this.errorMsg});
}

final class GetAllAttendanceSuccess extends AllAttendanceState {
  List<AttendanceResponseEntity> attendances;
  GetAllAttendanceSuccess({
    required this.attendances,
  });
}

final class DeleteAttendanceSuccess extends AllAttendanceState {
  DeleteAttendanceSuccess();
}
