// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/tradeChamber/collections/trade_collection_interface.dart';
import 'package:code_icons/data/api/tradeChamber/customers/customers_interface.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/data/pointyCastle.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/collections/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/data/model/response/collections/activity/activity_data_model.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/collections/general_central/general_central_data_model.dart';
import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/data/model/response/collections/payment_values_dm.dart';
import 'package:code_icons/data/model/response/settings/settings_data_model.dart';
import 'package:code_icons/data/model/response/collections/station/station_data_model.dart';
import 'package:code_icons/data/model/response/collections/trade_office/trade_office.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/presentation/utils/shared_prefrence.dart';
import 'package:code_icons/services/di.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._({
    required this.authManager,
    required this.customersDataInterface,
    required this.tradeCollectionsInterface,
  });
  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._(
      authManager: injectAuthManagerInterface(),
      customersDataInterface: injectCustomersDataInterface(),
      tradeCollectionsInterface: injectTradeCollectionsInterface(),
    );
    return _instance!;
  }

  AuthManagerInterface authManager;
  CustomersDataInterface customersDataInterface;
  TradeCollectionsInterface tradeCollectionsInterface;

  Future<Either<Failures, AuthResponseDM>> login(
    String username,
    String password,
  ) async {
    return authManager.login(username, password);
  }

  Future<Either<Failures, List<CustomerDataModel>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  }) async {
    return customersDataInterface.fetchCustomerData(
        skip: skip, take: take, filter: filter);
  }

  Future<Either<Failures, CustomerDataModel>> fetchCustomerDataByID(
      {String? customerId}) async {
    return customersDataInterface.fetchCustomerDataByID(customerId: customerId);
  }

  Future<Either<Failures, String>> postCustomerData(
      CustomerDataModel customerData) async {
    return customersDataInterface.postCustomerData(customerData: customerData);
  }

  Future<Either<Failures, List<TradeCollectionResponse>>>
      fetchTradeCollectionData({
    required int skip,
    required int take,
    String? filter,
    List<dynamic>? filterConditions,
  }) async {
    try {
      return tradeCollectionsInterface.fetchTradeCollectionData(
          skip: skip,
          take: take,
          filter: filter,
          filterConditions: filterConditions);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, TradeCollectionResponse>> getTradeCollectionDataByID({
    required int id,
  }) async {
    try {
      return tradeCollectionsInterface.getTradeCollectionDataByID(id: id);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<ActivityDataModel>>> fetchActivityeData() async {
    try {
      return tradeCollectionsInterface.fetchActivityeData();
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, ActivityDataModel>> fetchActivityeDataById(
      {required int activityId}) async {
    try {
      return tradeCollectionsInterface.fetchActivityeDataById(
          activityId: activityId);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PaymenValuesDM>> fetchPaymentValuesByID(
      {String? customerId}) async {
    try {
      return tradeCollectionsInterface.fetchPaymentValuesByID(
          customerId: customerId);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, TradeCollectionResponse>> postTradeCollectionData({
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    try {
      return tradeCollectionsInterface.postTradeCollectionData(
          tradeCollectionRequest: tradeCollectionRequest);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, int>> postUnRegisteredTradeCollectionData({
    required UnRegisteredCollectionsResponse unRegisteredTradeCollectionRequest,
  }) async {
    try {
      return tradeCollectionsInterface.postUnRegisteredTradeCollectionData(
          unRegisteredTradeCollectionRequest:
              unRegisteredTradeCollectionRequest);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<UnRegisteredCollectionsResponse>>>
      getUnRegisteredTradeCollectionData({
    required int skip,
    required int take,
    String? filter,
  }) async {
    try {
      return tradeCollectionsInterface.getUnRegisteredTradeCollectionData(
        skip: skip,
        take: take,
        filter: filter,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, PaymenValuesDM>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears}) async {
    try {
      return tradeCollectionsInterface.postPaymenValuesByID(
          customerId: customerId, paidYears: paidYears);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<TradeOfficeDataModel>>>
      fetchTradeOfficeData() async {
    try {
      return tradeCollectionsInterface.fetchTradeOfficeData();
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, TradeOfficeDataModel>> fetchTradeOfficeDataById(
      {required int tradeOfficeID}) async {
    try {
      return tradeCollectionsInterface.fetchTradeOfficeDataById(
          tradeOfficeID: tradeOfficeID);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<StationDataModel>>> fetchStationData() async {
    try {
      return tradeCollectionsInterface.fetchStationData();
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, StationDataModel>> fetchStationDataById(
      {required int stationId}) async {
    try {
      return tradeCollectionsInterface.fetchStationDataById(
          stationId: stationId);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, List<GeneralCentralDataModel>>>
      fetchGeneralCenterseData() async {
    try {
      return tradeCollectionsInterface.fetchGeneralCenterseData();
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, GeneralCentralDataModel>>
      fetchGeneralCenterseDataById({required int generalCentralId}) async {
    try {
      return tradeCollectionsInterface.fetchGeneralCenterseDataById(
          generalCentralId: generalCentralId);
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  //////////////////////////////
  Future<Either<Failures, SettingsDataModel>> fetchSettingsData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse('http://${ApiConstants.chamberApi}/api/Settings');

        /*    var url =
            Uri.http(ApiConstants.chamberApi, ApiConstants.settingsEndPoint); */
        var user = await authManager.getUser();
        var token = user!.accessToken;

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

  Future<Either<Failures, List<StoreDataModel>>> fetchStoreData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url =
            Uri.http(ApiConstants.chamberApi, ApiConstants.storeEndPoint);

        var user = await authManager.getUser();
        var token = user!.accessToken;
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
          return right(storeDataList);
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
        var url = Uri.http(ApiConstants.chamberApi, ApiConstants.itemEndPoint);

        var user = await authManager.getUser();
        var token = user!.accessToken;
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
        var url = Uri.http(ApiConstants.chamberApi, '/api/Item/$id');

        var user = await authManager.getUser();
        var token = user!.accessToken;
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
            Uri.http(ApiConstants.chamberApi, '/api/PurchaseRequest/$id');

        var user = await authManager.getUser();
        var token = user!.accessToken;
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
            Uri.http(ApiConstants.chamberApi, '/api/PurchaseRequest/$id');

        var user = await authManager.getUser();
        var token = user!.accessToken;
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
        var url = Uri.http(
            ApiConstants.chamberApi, ApiConstants.purchaseRequestEndPoint);

        var user = await authManager.getUser();
        var token = user!.accessToken;
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
        var url = Uri.http(
            ApiConstants.chamberApi, ApiConstants.costCenterAllEndPoint);

        var user = await authManager.getUser();
        var token = user!.accessToken;

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
          return right(costCenterDataList);
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
            Uri.http(ApiConstants.chamberApi, ApiConstants.postPREndPoint);

        var user = await authManager.getUser();
        var token = user!.accessToken;

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
            Uri.http(ApiConstants.chamberApi, ApiConstants.getPREndPoint);

        var user = await authManager.getUser();
        var token = user!.accessToken;

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
          return right(purchaseRequestList);
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
        var url = Uri.http(ApiConstants.chamberApi, ApiConstants.uoms);

        var user = await authManager.getUser();
        var token = user!.accessToken;

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
          return right(uomDataList);
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

  Future<Either<Failures, CurrencyDataModel>> fetchCurrencyDataById(
      {required int currencyId}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.parse(
            'http://${ApiConstants.chamberApi}/api/Currency/$currencyId');
        var user = await authManager.getUser();
        var token = user!.accessToken;

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
            Uri.http(ApiConstants.chamberApi, ApiConstants.currencyEndPoint);
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
}
