// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/HR/Requests/Vacations/vacation_interface.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/model/request/vactionRequest/update_vacation_request_data_model.dart';
import 'package:code_icons/data/model/request/vactionRequest/vacation_request_data_model.dart';
import 'package:code_icons/data/model/response/HR/Employee/Vacation/vacation_response_data_model.dart';
import 'package:code_icons/data/model/response/HR/Employee/Vacation/vacation_type_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';

class vacationManager implements VacationInterface {
  AuthManager authManager;
  HandleResponseHelper handleResponseHelper;
  HttpRequestHelper httpRequestHelper;
  vacationManager({
    required this.authManager,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });
  @override
  Future<Either<Failures, int>> addVacationRequest(
      {required AddVacationRequestDataModel vacationRequestDataModel}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.http(ApiConstants.chamberApi, ApiConstants.vacationRequest);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.POST,
          url: url,
          token: token,
          body: jsonEncode(vacationRequestDataModel.toJson()));

      return await handleResponseHelper.handleResponse<int>(
          response: response, fromJson: (json) => json);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<VacationResponseDataModel>>>
      deletVacationRequestByID({required int requestID}) {
    // TODO: implement deletVacationRequestByID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<VacationResponseDataModel>>>
      getAllVacationRequests() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.http(ApiConstants.chamberApi, ApiConstants.vacationRequest);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<VacationResponseDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => VacationResponseDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<VacationTypeDataModel>>>
      getAllVacationtTypes() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.http(ApiConstants.chamberApi, ApiConstants.vacationType);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<VacationTypeDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => VacationTypeDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, VacationResponseDataModel>> getVacationRequestByID({
    required int requestID,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.http(ApiConstants.chamberApi, '/api/VacationRequest/$requestID');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<VacationResponseDataModel>(
        response: response,
        fromJson: (json) => VacationResponseDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, VacationTypeDataModel>> getVacationtTypeByID(
      {required typeId}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.http(ApiConstants.chamberApi, '/api/VactionTypes/$typeId');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<VacationTypeDataModel>(
        response: response,
        fromJson: (json) => VacationTypeDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> updateVacationRequest({
    required UpdateVacationRequestDataModel updateVacationRequestDataModel,
    required int requestID,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.http(ApiConstants.chamberApi, '/api/VacationRequest/$requestID');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.PUT,
        url: url,
        token: token,
        body: jsonEncode(updateVacationRequestDataModel.toJson()),
      );

      if (response.statusCode == 200) {
        return right("Vacation request updated successfully");
      } else {
        return left(
            Failures(errorMessege: response.reasonPhrase ?? 'Error occurred'));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
