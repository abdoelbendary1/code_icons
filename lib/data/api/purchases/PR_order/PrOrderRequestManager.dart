import 'dart:convert';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/purchases/PR_order/PrOrderRequestInterface.dart';
import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class PrOrderRequestManager implements PrOrderRequestInterface {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;

  PrOrderRequestManager({
    required this.httpRequestHelper,
    required this.handleResponseHelper,
    required this.authManager,
  });

  @override
  Future<Either<Failures, String>> postPurchaseOrder(
      {required PrOrderRequestDataModel prOrderRequestDataModel}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.postPurchaseOrderEndPoint);

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(prOrderRequestDataModel.toJson()),
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> getPurchaseOrder() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.postPurchaseOrderEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> getPurchaseOrderById(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.parse(
          'https://${ApiConstants.chamberApi}${ApiConstants.postPurchaseOrderEndPoint}/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> fetchTaxes() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.taxes);
      /*  var url = Uri.parse('https://demoapi1.code-icons.com/api/Tax/All'); */
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> fetchVendors() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.vendors);
      /* var url = Uri.parse('https://demoapi1.code-icons.com/api/Vendor'); */
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deletePurchaseOrderById(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.parse('https://${ApiConstants.chamberApi}${ApiConstants.postPurchaseOrderEndPoint}/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.DELETE,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
