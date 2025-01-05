import 'dart:convert';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/HR/Requests/Loan/ILoan.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/model/request/LoanRequest/loan_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class LoanManager implements ILoan {
  AuthManager authManager;
  HandleResponseHelper handleResponseHelper;
  HttpRequestHelper httpRequestHelper;
  LoanManager({
    required this.authManager,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });
  @override
  Future<Either<Failures, int>> addLoanRequest(
      {required LoanRequestDataModel loanRequestDataModel}) async {
    try {
      // Check network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for the loan request endpoint
      var url = Uri.http(ApiConstants.chamberApi, ApiConstants.loanRequest);

      // Get the user details and token for authentication
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the POST request to the loan request endpoint with the loan data
      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.POST,
          url: url,
          token: token,
          body: jsonEncode(loanRequestDataModel.toJson()));

      // Handle the response and return the appropriate result
      return await handleResponseHelper.handleResponse<int>(
          response: response, fromJson: (json) => json);
    } catch (e) {
      // Handle any errors that occur during the request
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<LoanRequestDataModel>>>
      getAllLoanRequests() async {
    try {
      // Check network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for the loan requests endpoint
      var url = Uri.http(ApiConstants.chamberApi, ApiConstants.loanRequest);

      // Get the user details and token for authentication
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the GET request to retrieve all loan requests
      var response = await httpRequestHelper.sendRequest(
          method: HttpMethod.GET, url: url, token: token);

      // Handle the response and return the list of loan requests
      return await handleResponseHelper
          .handleResponse<List<LoanRequestDataModel>>(
              response: response,
              fromJson: (json) => (json as List)
                  .map((item) => LoanRequestDataModel.fromJson(item))
                  .toList());
    } catch (e) {
      // Handle any errors that occur during the request
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> deleteLoanRequest(
      {required int loanRequestId}) async {
    try {
      // Check network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
 var url = Uri.http(ApiConstants.chamberApi,
          "${ApiConstants.loanRequest}/$loanRequestId");
      // Construct the URL for the delete loan request endpoint
      

      // Get the user details and token for authentication
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the DELETE request to remove the loan request
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
