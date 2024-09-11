import 'package:code_icons/data/model/request/vactionRequest/update_vacation_request_data_model.dart';
import 'package:code_icons/data/model/request/vactionRequest/vacation_request_data_model.dart';
import 'package:code_icons/data/model/response/HR/Employee/Vacation/vacation_response_data_model.dart';
import 'package:code_icons/data/model/response/HR/Employee/Vacation/vacation_type_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class VacationInterface {
  Future<Either<Failures, int>> addVacationRequest(
      {required AddVacationRequestDataModel vacationRequestDataModel});
  Future<Either<Failures, String>> updateVacationRequest({
    required UpdateVacationRequestDataModel updateVacationRequestDataModel,
    required int requestID,
  });
  Future<Either<Failures, List<VacationResponseDataModel>>>
      getAllVacationRequests();
  Future<Either<Failures, VacationResponseDataModel>> getVacationRequestByID(
      {required int requestID});
  Future<Either<Failures, List<VacationResponseDataModel>>>
      deletVacationRequestByID({required int requestID});
  Future<Either<Failures, List<VacationTypeDataModel>>> getAllVacationtTypes();
  Future<Either<Failures, VacationTypeDataModel>> getVacationtTypeByID(
      {required typeId});
}
