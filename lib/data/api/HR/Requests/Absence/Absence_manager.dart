import 'dart:convert';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/HR/Requests/Absence/IAbsence.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/model/request/AbsenceRequest/absence_request.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AbsenceManager implements IAbsence {
  AuthManager authManager;
  HandleResponseHelper handleResponseHelper;
  HttpRequestHelper httpRequestHelper;
  AbsenceManager({
    required this.authManager,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });
  @override
  Future<Either<Failures, int>> addAbsenceRequest(
      {required AbsenceRequestDataModel absenceRequestDataModel}) async {
    try {
      // Check network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for the Absence request endpoint
      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.AbsenceRequest);

      // Get the user details and token for authentication
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the POST request to the Absence request endpoint with the Absence data
      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.POST,
          url: url,
          token: token,
          body: jsonEncode(absenceRequestDataModel.toJson()));

      // Handle the response and return the appropriate result
      return await handleResponseHelper.handleResponse<int>(
          response: response, fromJson: (json) => json);
    } catch (e) {
      // Handle any errors that occur during the request
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<AbsenceRequestDataModel>>>
      getAllAbsenceRequests() async {
    try {
      // Check network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for the Absence requests endpoint
      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.AbsenceRequest);

      // Get the user details and token for authentication
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the GET request to retrieve all Absence requests
      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.GET, url: url, token: token);

      // Handle the response and return the list of Absence requests
      return await handleResponseHelper
          .handleResponse<List<AbsenceRequestDataModel>>(
              response: response,
              fromJson: (json) => (json as List)
                  .map((item) => AbsenceRequestDataModel.fromJson(item))
                  .toList());
    } catch (e) {
      // Handle any errors that occur during the request
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> deleteAbsenceRequest(
      {required int absenceRequestId}) async {
    try {
      // Check network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.AbsenceRequest}/$absenceRequestId");

      // Construct the URL for the delete Absence request endpoint

      // Get the user details and token for authentication
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the DELETE request to remove the Absence request
      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.DELETE, url: url, token: token);

      // Handle the response and return true if the deletion was successful
      if (response.statusCode == 200) {
        return right(true);
      } else {
        return left(
            Failures(errorMessege: response.reasonPhrase ?? "Unknown error"));
      }
    } catch (e) {
      // Handle any errors that occur during the request
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
