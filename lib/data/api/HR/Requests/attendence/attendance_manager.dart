import 'dart:convert';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/HR/Requests/attendence/IAttendance.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/model/request/attendanceRequest/attendance_request.dart';
import 'package:code_icons/data/model/response/HR/attendanceResponse/attendance_response_data_model.dart';
import 'package:code_icons/domain/entities/HR/attendanceResponse/attendance_response_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AttendanceManager implements IAttendance {
  AuthManager authManager;
  HandleResponseHelper handleResponseHelper;
  HttpRequestHelper httpRequestHelper;
  AttendanceManager({
    required this.authManager,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });
  @override
  Future<Either<Failures, int>> addAttendanceRequest(
      {required AttendanceRequest attendanceRequest}) async {
    try {
      if (!await isConnected()) {
        return Left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url =
          Uri.http(ApiConstants.chamberApi, ApiConstants.attendenceRequest);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.POST,
          url: url,
          token: token,
          body: jsonEncode(attendanceRequest.toJson()));
      return await handleResponseHelper.handleResponse<int>(
          response: response, fromJson: (json) => json);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<AttendanceResponseEntity>>>
      getAllAttendanceRequests() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.http(ApiConstants.chamberApi, ApiConstants.attendenceRequest);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<AttendanceResponseDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => AttendanceResponseDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteAttendanceRequest(
      {required String attendanceID}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.parse(
          'http://${ApiConstants.chamberApi}${ApiConstants.attendenceRequest}/$attendanceID');

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.DELETE,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<void>(
          response: response,
          fromJson: (json) => json,
          defaultResponseForNoContent: "OK");
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AttendanceResponseEntity>> getAttendanceRequestByID(
      {required String id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.parse(
          'http://${ApiConstants.chamberApi}${ApiConstants.attendenceRequest}/$id');

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<AttendanceResponseEntity>(
        response: response,
        fromJson: (json) => AttendanceResponseDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateAttendanceRequestByID(
      {required String id,
      required AttendanceRequest attendanceRequest}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.parse(
          'http://${ApiConstants.chamberApi}${ApiConstants.attendenceRequest}/$id');

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.PUT,
        url: url,
        token: token,
        body: jsonEncode(
          attendanceRequest.toJson(),
        ),
      );

      return await handleResponseHelper.handleResponse<void>(
          response: response,
          fromJson: (json) => json,
          defaultResponseForNoContent: "OK");
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
