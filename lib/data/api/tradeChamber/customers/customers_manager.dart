// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:dartz/dartz.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/tradeChamber/customers/customers_interface.dart';
import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';

class CustomersManager implements CustomersDataInterface {
  final AuthManagerInterface authManager;
  final HttpRequestHelper httpRequestHelper;
  HandleResponseHelper handleResponseHelper;

  CustomersManager({
    required this.authManager,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });

  @override
  Future<Either<Failures, List<CustomerDataModel>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      /*   if (filter != null && filter.isNotEmpty) {
        var filterStructure = [
          ["brandNameBL", "contains", filter],
          "or",
          ["nationalIdBL", "contains", filter],
          "or",
          ["tradeRegistryBL", "contains", filter],
          "or",
          ["addressBL", "contains", filter],
          "or",
          ["divisionBL", "contains", filter]
        ];

        // Convert the filter structure to a JSON string and encode it
        filter = Uri.encodeComponent(jsonEncode(filterStructure));
      } */
      // Define query parameters for pagination and filtering

      var queryParams = {
        'skip': skip.toString(),
        'take': take.toString(),
        'requireTotalCount': 'true',
        if (filter != null) 'filter': filter, // Only add filter if provided
      };
      var url = Uri.http(
        ApiConstants.chamberApi,
        ApiConstants.customerDataEndPoint,
        queryParams, // Include the pagination and filter params
      );

// If using http instead of https
// var url = Uri.http(
//   ApiConstants.chamberApi,
//   ApiConstants.customerDataEndPoint,
//   queryParams, // Include the pagination and filter params
// );
      /*  var url = Uri.parse(
          'http://${ApiConstants.chamberApi}"${ApiConstants.customerDataEndPoint}"'); */
      /* var url = Uri.https(
        ApiConstants.chamberApi,
        ApiConstants.customerDataEndPoint,
        queryParams, // Include the pagination and filter params
      ); */

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<CustomerDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => CustomerDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, CustomerDataModel>> fetchCustomerDataByID(
      {required String? customerId}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      /*  var url = Uri.parse(
          'http://${ApiConstants.chamberApi}"${ApiConstants.customerDataEndPoint}/$customerId"'); */
      var url = Uri.http(ApiConstants.chamberApi,
          "${ApiConstants.customerDataEndPoint}/$customerId");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<CustomerDataModel>(
        response: response,
        fromJson: (json) => CustomerDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> postCustomerData(
      {required CustomerDataModel customerData}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      /*   var url = Uri.parse(
          'http://${ApiConstants.chamberApi}"${ApiConstants.customerDataEndPoint}"'); */
      var url =
          Uri.http(ApiConstants.chamberApi, ApiConstants.customerDataEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(customerData.toJson()),
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json.toString(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
