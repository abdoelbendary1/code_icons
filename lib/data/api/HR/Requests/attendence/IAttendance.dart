// ignore: file_names
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/model/request/attendanceRequest/attendance_request.dart';
import 'package:code_icons/domain/entities/HR/attendanceResponse/attendance_response_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';

abstract class IAttendance {
  Future<Either<Failures, int>> addAttendanceRequest(
      {required AttendanceRequest attendanceRequest});
  Future<Either<Failures, List<AttendanceResponseEntity>>>
      getAllAttendanceRequests();
  Future<Either<Failures, AttendanceResponseEntity>> getAttendanceRequestByID(
      {required String id});
  Future<Either<Failures, void>> updateAttendanceRequestByID(
      {required String id, required AttendanceRequest attendanceRequest});
  Future<Either<Failures, void>> deleteAttendanceRequest(
      {required String attendanceID});
}
