import 'package:code_icons/data/model/request/AbsenceRequest/absence_request.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IAbsence {
  Future<Either<Failures, int>> addAbsenceRequest(
      {required AbsenceRequestDataModel absenceRequestDataModel});
  Future<Either<Failures, List<AbsenceRequestDataModel>>>
      getAllAbsenceRequests();
  Future<Either<Failures, bool>> deleteAbsenceRequest(
      {required int absenceRequestId});
}
