// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/model/data_model/postDataEX.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/data/model/response/payment_values_dm.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/presentation/utils/shared_prefrence.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<Either<Failures, AuthResponseDM>> login(
    String username,
    String password,
  ) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl, ApiConstants.loginEndPoint);

        var request = http.MultipartRequest('POST', url);
        request.fields['UserName'] = username;
        request.fields['Password'] = password;

        var response = await request.send();
        var responseBody = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseBody);

        var loginResponse = AuthResponseDM.fromJson(jsonDecode(responseString));

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          await SharedPrefrence.init();
          SharedPrefrence.saveData(
              key: "accessToken", value: loginResponse.accessToken!);

          return right(loginResponse);
        } else if (responseString.isEmpty) {
          return left(ServerError(errorMessege: "NULL"));
        } else {
          return left(ServerError(
              errorMessege: loginResponse.message ?? "Server error"));
        }
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      return Left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<CustomerDataModel>>> fetchCustomerData() async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.baseUrl, ApiConstants.customerDataEndPoint);
        /* var url = Uri.parse("https://demoapi1.code-icons.com/api/CustomerData"); */
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        // Define the headers
        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        // Create the MultipartRequest
        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        // Send the request
        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        // Process the response
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<CustomerDataModel> customerDataList = responseBodyJson
              .map((json) => CustomerDataModel.fromJson(json))
              .toList();

          return right(customerDataList);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PaymentValuesDM>> fetchPaymentValuesByID(
      {String? customerId}) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl,
            "${ApiConstants.paymentValuesEndPoint}/$customerId");
        /*  var url = Uri.parse(
            "https://demoapi1.code-icons.com/api/CustomerData/PaymentValues/$customerId"); */
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        // Define the headers
        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        // Create the MultipartRequest
        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        // Send the request
        http.StreamedResponse response = await request.send();
        print("payment status : ${response.statusCode}");

        // Process the response
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          var paymentValuesResponse =
              PaymentValuesDM.fromJson(responseBodyJson);

          print("Payment total data from api: ${paymentValuesResponse.total}");
          print("payment  : ${paymentValuesResponse.late}");
          print(
              "years of payment  : ${paymentValuesResponse.yearsOfRepayment}");

          return right(paymentValuesResponse);
        } else {
          print("server error");
        }
        return left(ServerError(errorMessege: "Server error (Unknown data)"));
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, CustomerDataModel>> fetchCustomerDataByID(
      {String? customerId}) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl,
            "${ApiConstants.customerDataEndPoint}/$customerId");
        /* var url = Uri.parse(
            "https://demoapi1.code-icons.com/api/CustomerData/${customerId}"); */
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        // Define the headers
        var headers = {
          "Authorization":
              "Bearer $token", // Replace YOUR_TOKEN with the actual token
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        // Create the MultipartRequest
        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        // Send the request
        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        // Process the response
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          var customerDataResponse =
              CustomerDataModel.fromJson(responseBodyJson);

          print("Customer data from api: ${customerDataResponse.brandNameBl}");

          return right(customerDataResponse);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, TradeCollectionResponse>> postTradeCollectionData({
    required String token,
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.baseUrl, ApiConstants.tradeCollectionEndPoint);
        /*   var url =
            Uri.parse("https://demoapi1.code-icons.com/api/TradeCollection"); */
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var body = json.encode(tradeCollectionRequest.toJson());

        var response = await http.post(url, headers: headers, body: body);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          int collectionID = int.parse(response.body);
          var tradeCollectionResponse =
              TradeCollectionResponse(collectionID: collectionID.toString());
          print(
              "trade collection ID : ${tradeCollectionResponse.collectionID}");
          return right(tradeCollectionResponse);
        } else {
          print(
              "Server error: ${response.statusCode} - ${response.reasonPhrase}");
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(
            NetworkError(errorMessege: "Check your internet connection"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PaymentValuesDM>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears}) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl,
            "${ApiConstants.paymentValuesEndPoint}/$customerId");

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                'https://demoapi1.code-icons.com/api/CustomerData/PaymentValues/$customerId'));

        request.body = json.encode(paidYears);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        // Process the response
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          var paymentValuesResponse =
              PaymentValuesDM.fromJson(responseBodyJson);

          print(
              "Payment total data from api request= ==============: ${paymentValuesResponse.total}");
          print("payment  : ${paymentValuesResponse.late}");
          print(
              "years of payment  : ${paymentValuesResponse.yearsOfRepayment}");

          return right(paymentValuesResponse);
        } else {
          print("server error");
        }
        return left(ServerError(errorMessege: "Server error (Unknown data)"));
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
