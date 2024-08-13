// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchase_item/purchase_item.dart';
import 'package:code_icons/data/model/response/store/store_data_model.dart';
import 'package:code_icons/data/pointyCastle.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/data/model/response/activity/activity_data_model.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/data/model/response/currency/currency.dart';
import 'package:code_icons/data/model/response/general_central/general_central_data_model.dart';
import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/data/model/response/payment_values_dm.dart';
import 'package:code_icons/data/model/response/settings/settings_data_model.dart';
import 'package:code_icons/data/model/response/station/station_data_model.dart';
import 'package:code_icons/data/model/response/trade_office/trade_office.dart';
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
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.loginEndPoint);

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
          String token = SharedPrefrence.getData(key: "accessToken") as String;
          print(token);

          return right(loginResponse);
        } else if (response.statusCode == 410) {
          return left(ServerError(
              errorMessege: "تاكد من صحة بيانات اسم المستخدم وكلمة السر"));
        } else if (responseString.isEmpty) {
          return left(ServerError(errorMessege: "NULL"));
        } else {
          return left(ServerError(
              errorMessege: loginResponse.message ?? "Server error"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
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
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.customerDataEndPoint);

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);
        // Define the headers
        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };
        print(token);

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
          if (customerDataList.isNotEmpty) {
            return right(customerDataList);
          } else {
            return left(ServerError(errorMessege: "list is empty"));
          }
        } else if (response.statusCode == 403) {
          return left(ServerError(errorMessege: "Access is denied"));
        } else if (response.statusCode == 401) {
          return left(ServerError(errorMessege: "Access is denied"));
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<StoreDataModel>>> fetchStoreData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.storeEndPoint);

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);

        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<StoreDataModel> storeDataList = responseBodyJson
              .map((json) => StoreDataModel.fromJson(json))
              .toList();
          if (storeDataList.isNotEmpty) {
            return right(storeDataList);
          } else {
            return left(ServerError(errorMessege: "List is empty"));
          }
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<PurchaseItemDataModel>>>
      fetchPurchaseItemData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.chamberApi, ApiConstants.itemEndPoint);

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);

        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<PurchaseItemDataModel> purchaseItemList = responseBodyJson
              .map((json) => PurchaseItemDataModel.fromJson(json))
              .toList();
          if (purchaseItemList.isNotEmpty) {
            return right(purchaseItemList);
          } else {
            return left(ServerError(errorMessege: "List is empty"));
          }
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PurchaseItemDataModel>> fetchPurchaseItemDataByID(
      {required int id}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.chamberApi, '/api/Item/$id');
        /* var url = Uri.https(ApiConstants.chamberApi, ApiConstants.itemEndPoint); */

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);

        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          PurchaseItemDataModel purchaseItem =
              PurchaseItemDataModel.fromJson(responseBodyJson);

          return right(purchaseItem);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, GetAllPurchasesRequests>> deletePurchaseRequestById(
      {required int id}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, '/api/PurchaseRequest/$id');

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);

        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        var request = http.Request('DELETE', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          GetAllPurchasesRequests deletedItem =
              GetAllPurchasesRequests.fromJson(responseBodyJson);

          return right(deletedItem);
        } else {
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, GetAllPurchasesRequests>> fetchPurchaseRequestById(
      {required int id}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, '/api/PurchaseRequest/$id');

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);

        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          GetAllPurchasesRequests purchaseItem =
              GetAllPurchasesRequests.fromJson(responseBodyJson);
          return right(purchaseItem);
        } else {
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchPurchaseRequests() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.purchaseRequestEndPoint);

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        print(token);

        var headers = {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<GetAllPurchasesRequests> purchaseRequestList = responseBodyJson
              .map((json) => GetAllPurchasesRequests.fromJson(json))
              .toList();
          if (purchaseRequestList.isNotEmpty) {
            return right(purchaseRequestList);
          } else {
            return left(ServerError(errorMessege: "List is empty"));
          }
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<CostCenterDataModel>>>
      fetchCostCenterData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.costCenterAllEndPoint);
        /* var url =
            Uri.parse('https://demoapi1.code-icons.com/api/costCenter/All'); */

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<CostCenterDataModel> costCenterDataList = responseBodyJson
              .map((json) => CostCenterDataModel.fromJson(json))
              .toList();
          if (costCenterDataList.isNotEmpty) {
            return right(costCenterDataList);
          } else {
            return left(ServerError(errorMessege: "List is empty"));
          }
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, String>> postPurchaseRequest(
      PurchaseRequestDataModel purchaseRequestDataModel) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.postPREndPoint);
        /*  var url =
            Uri.parse('https://demoapi1.code-icons.com/api/PurchaseRequest'); */

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var request = http.Request('POST', url);
        request.body = json.encode(purchaseRequestDataModel.toJson());
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

  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchAllPurchaseRequests() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.getPREndPoint);
        /*   var url =
            Uri.parse('https://demoapi1.code-icons.com/api/PurchaseRequest'); */

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<GetAllPurchasesRequests> purchaseRequestList = responseBodyJson
              .map((json) => GetAllPurchasesRequests.fromJson(json))
              .toList();
          if (purchaseRequestList.isNotEmpty) {
            return right(purchaseRequestList);
          } else {
            return left(ServerError(errorMessege: "List is empty"));
          }
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<UomDataModel>>> fetchUOMData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse('https://demoapi1.code-icons.com/api/uoms');

        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<UomDataModel> uomDataList = responseBodyJson
              .map((json) => UomDataModel.fromJson(json))
              .toList();
          if (uomDataList.isNotEmpty) {
            return right(uomDataList);
          } else {
            return left(ServerError(errorMessege: "List is empty"));
          }
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, SettingsDataModel>> fetchSettingsData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.settingsEndPoint);
        /* var url = Uri.parse('https://demoapi1.code-icons.com/api/Settings'); */
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          Map<String, dynamic> decodedJson = jsonDecode(responseBody);

          // Decrypt fields
          /* final key = encrypt.Key.fromUtf8('EncryptionKey');

          final iv = encrypt.IV.fromLength(16); */
          final key = 'EncryptionKey'; // 32 characters
          final iv = '1234567890123456';

          List<String> encryptedKeys = [
            'finance',
            'cashInOut',
            'purchases',
            'sales',
            'costructions',
            'charterparty',
            'humanResources',
            'stores',
            'reports',
            'settings',
            'realStateInvestments',
            'imports',
            'hospital',
            'collections'
          ];
          for (String field in encryptedKeys) {
            if (decodedJson.containsKey(field)) {
              decodedJson[field] = decrypt(decodedJson[field]);
              /*  decodedJson[field] = EncryptData.decryptString(
                  encryptedString: decodedJson[field],
                  ivString: iv,
                  keyString: key,
                  keyLength: 64); */
            }
          }

          SettingsDataModel settingsData =
              SettingsDataModel.fromJson(decodedJson);

          return right(settingsData);
        } else {
          return left(ServerError(errorMessege: 'Server error (Unknown data)'));
        }
      } else {
        return left(NetworkError(errorMessege: 'تأكد من اتصالك بالانترنت'));
      }
    } catch (e) {
      print('Exception: $e');
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, CurrencyDataModel>> fetchCurrencyDataById(
      {required int currencyId}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/api/Currency/$currencyId');
        String token = SharedPrefrence.getData(key: "accessToken") as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          CurrencyDataModel currencyData =
              CurrencyDataModel.fromJson(responseBodyJson);

          return right(currencyData);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<CurrencyDataModel>>> fetchCurrencyData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.currencyEndPoint);
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<CurrencyDataModel> currencyDataList = responseBodyJson
              .map((json) => CurrencyDataModel.fromJson(json))
              .toList();

          return right(currencyDataList);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<TradeOfficeDataModel>>>
      fetchTradeOfficeData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.tradeOfficeEndPoint);
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<TradeOfficeDataModel> tradeOfficeDataList = responseBodyJson
              .map((json) => TradeOfficeDataModel.fromJson(json))
              .toList();

          return right(tradeOfficeDataList);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, TradeOfficeDataModel>> fetchTradeOfficeDataById(
      {required int tradeOfficeID}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/${ApiConstants.tradeOfficeEndPoint}/$tradeOfficeID');
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          dynamic responseBodyJson = jsonDecode(responseBody);
          TradeOfficeDataModel tradeOfficeData =
              TradeOfficeDataModel.fromJson(responseBodyJson);

          return right(tradeOfficeData);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<StationDataModel>>> fetchStationData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.stationEndPoint);
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<StationDataModel> stationDataList = responseBodyJson
              .map((json) => StationDataModel.fromJson(json))
              .toList();

          return right(stationDataList);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, StationDataModel>> fetchStationDataById(
      {required int stationId}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/${ApiConstants.stationEndPoint}/$stationId');
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          dynamic responseBodyJson = jsonDecode(responseBody);
          StationDataModel stationData =
              StationDataModel.fromJson(responseBodyJson);

          return right(stationData);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<GeneralCentralDataModel>>>
      fetchGeneralCenterseData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.generalCentersEndPoint);
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<GeneralCentralDataModel> generalCentralDataList =
              responseBodyJson
                  .map((json) => GeneralCentralDataModel.fromJson(json))
                  .toList();

          return right(generalCentralDataList);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, GeneralCentralDataModel>>
      fetchGeneralCenterseDataById({required int generalCentralId}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/${ApiConstants.generalCentersEndPoint}/$generalCentralId');
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;
        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          dynamic responseBodyJson = jsonDecode(responseBody);
          GeneralCentralDataModel generalCentralData =
              GeneralCentralDataModel.fromJson(responseBodyJson);

          return right(generalCentralData);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<ActivityDataModel>>> fetchActivityeData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.https(ApiConstants.chamberApi, ApiConstants.activityEndPoint);
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> responseBodyJson = jsonDecode(responseBody);
          List<ActivityDataModel> activityDataList = responseBodyJson
              .map((json) => ActivityDataModel.fromJson(json))
              .toList();

          return right(activityDataList);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, ActivityDataModel>> fetchActivityeDataById(
      {required int activityId}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/${ApiConstants.activityEndPoint}/$activityId');
        String token =
            await SharedPrefrence.getData(key: 'accessToken') as String;

        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Cache-Control': 'no-cache',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive'
        };

        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          dynamic responseBodyJson = jsonDecode(responseBody);
          ActivityDataModel activityData =
              ActivityDataModel.fromJson(responseBodyJson);

          return right(activityData);
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, String>> postCustomerData(
      CustomerDataModel customerData) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.customerDataEndPoint);
        String token = SharedPrefrence.getData(key: "accessToken") as String;

        // Define the headers
        var headers = {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "User-Agent": "PostmanRuntime/7.39.0",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        };

        // Create the request
        var request = http.Request('POST', url);
        request.body = json.encode(customerData.toJson());
        request.headers.addAll(headers);

        // Send the request
        http.StreamedResponse response = await request.send();
        print(response.statusCode);

        // Process the response
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          print("customer response id $responseBody");
          return right(responseBody);
        } else if (response.statusCode == 410) {
          String responseBody = await response.stream.bytesToString();
          var messsage = CustomerDataModel.fromJson(jsonDecode(responseBody));
          print(messsage.message);
          return Left(ServerError(errorMessege: messsage.message!));
        } else {
          print("error ${response.statusCode}");
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PaymenValuesDM>> fetchPaymentValuesByID(
      {String? customerId}) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.chamberApi,
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
          var paymentValuesResponse = PaymenValuesDM.fromJson(responseBodyJson);

          print("Payment total data from api: ${paymentValuesResponse.total}");
          print("payment  : ${paymentValuesResponse.late}");
          print("payment  : ${paymentValuesResponse.paidYears}");

          print(
              "years of payment  : ${paymentValuesResponse.yearsOfRepayment}");

          return right(paymentValuesResponse);
        } else if (response.statusCode == 410) {
          String responseBody = await response.stream.bytesToString();
          var messsage = PaymenValuesDM.fromJson(jsonDecode(responseBody));
          print(messsage.message);
          return Left(ServerError(errorMessege: messsage.message!));
        } else {
          print("server error");
        }
        return left(ServerError(errorMessege: "Server error (Unknown data)"));
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
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
        var url = Uri.https(ApiConstants.chamberApi,
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
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
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
            ApiConstants.chamberApi, ApiConstants.tradeCollectionEndPoint);
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
              TradeCollectionResponse(idBl: collectionID);
          print("trade collection ID : ${tradeCollectionResponse.idBl}");
          return right(tradeCollectionResponse);
        } else {
          print(
              "Server error: ${response.statusCode} - ${response.reasonPhrase}");
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, TradeCollectionResponse>> getTradeCollectionDataByID({
    required int id,
  }) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        /* var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.tradeCollectionEndPoint); */
        var url = Uri.parse(
            "https://${ApiConstants.chamberApi}/api/TradeCollection/$id");
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        /* var body = json.encode(tradeCollectionRequest.toJson()); */

        var response = await http.get(
          url,
          headers: headers,
        );

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = response.body;
          var responseBodyJson = jsonDecode(responseBody);
          var tradeCollectionResponse =
              TradeCollectionResponse.fromJson(responseBodyJson);
          return right(tradeCollectionResponse);
        } else {
          print(
              "Server error: ${response.statusCode} - ${response.reasonPhrase}");
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, String>> postUnRegisteredTradeCollectionData({
    required UnRegisteredCollectionsResponse unRegisteredTradeCollectionRequest,
  }) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/api/TradeCollection/UnRegistered');

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var body = json.encode(unRegisteredTradeCollectionRequest.toJson());

        var request = http.Request('POST', url)
          ..headers.addAll(headers)
          ..body = body;

        var response = await request.send();

        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          return right(responseBody);
        } else {
          print(
              "Server error: ${response.statusCode} - ${response.reasonPhrase}");
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<UnRegisteredCollectionsResponse>>>
      getUnRegisteredTradeCollectionData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'https://${ApiConstants.chamberApi}/api/TradeCollection/UnRegistered');

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var request = http.Request('GET', url)..headers.addAll(headers);

        var response = await request.send();

        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          List<dynamic> jsonList = json.decode(responseBody);
          List<UnRegisteredCollectionsResponse> unRegisteredDataList = jsonList
              .map((json) => UnRegisteredCollectionsResponse.fromJson(json))
              .toList();
          print(unRegisteredDataList.elementAt(2).idBl);
          return right(unRegisteredDataList);
        } else {
          print(
              "Server error: ${response.statusCode} - ${response.reasonPhrase}");
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<TradeCollectionResponse>>>
      fetchTradeCollectionData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(
            ApiConstants.chamberApi, ApiConstants.tradeCollectionEndPoint);
        /*   var url =
            Uri.parse("https://demoapi1.code-icons.com/api/TradeCollection"); */
        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var response = await http.get(
          url,
          headers: headers,
        );

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          List<dynamic> responseBody = jsonDecode(response.body);

          var tradeCollections = responseBody
              .map((json) => TradeCollectionResponse.fromJson(json))
              .toList();

          return right(tradeCollections);
        } else {
          print(
              "Server error: ${response.statusCode} - ${response.reasonPhrase}");
          return left(ServerError(
              errorMessege: "Server error: ${response.reasonPhrase}"));
        }
      } else {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PaymenValuesDM>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears}) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.chamberApi,
            "${ApiConstants.paymentValuesEndPoint}/$customerId");

        String token = SharedPrefrence.getData(key: "accessToken") as String;
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                'https://${ApiConstants.chamberApi}/api/CustomerData/PaymentValues/$customerId'));

        request.body = json.encode(paidYears);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        // Process the response
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          String responseBody = await response.stream.bytesToString();
          var responseBodyJson = jsonDecode(responseBody);
          var paymentValuesResponse = PaymenValuesDM.fromJson(responseBodyJson);

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
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
    } catch (e) {
      print("Exception: $e");
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
