import 'dart:convert';

import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../presentation/utils/shared_prefrence.dart';

class PROrderAPi {
  PROrderAPi._();
  static PROrderAPi? _instance;

  static PROrderAPi getInstance() {
    _instance ??= PROrderAPi._();
    return _instance!;
  }

  Future<Either<Failures, String>> postPurchaseOrder(
      PrOrderRequestDataModel prOrderRequestDataModel) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.elreedyApi, ApiConstants.postPurchaseOrderEndPoint);

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var request = http.Request('POST', url);
        request.body = json.encode(prOrderRequestDataModel.toJson());
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          String responseBody = await response.stream.bytesToString();
          return right(responseBody);
        } else {
          return left(ServerError(
              errorMessege: response.reasonPhrase ?? "Unknown server error"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, String>> getPurchaseOrder() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.elreedyApi, ApiConstants.postPurchaseOrderEndPoint);

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Authorization': 'Bearer $token',
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          String responseBody = await response.stream.bytesToString();
          return right(responseBody);
        } else {
          return left(ServerError(
              errorMessege: response.reasonPhrase ?? "Unknown server error"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, String>> getPurchaseOrderById(String id) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.chamberApi,
            "${ApiConstants.postPurchaseOrderEndPoint}/$id");

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Authorization': 'Bearer $token',
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          String responseBody = await response.stream.bytesToString();
          return right(responseBody);
        } else {
          return left(ServerError(
              errorMessege: response.reasonPhrase ?? "Unknown server error"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
