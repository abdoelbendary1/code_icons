import 'dart:convert';
import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/tradeChamber/collections/trade_collection_interface.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/collections/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/data/model/response/collections/activity/activity_data_model.dart';
import 'package:code_icons/data/model/response/collections/general_central/general_central_data_model.dart';
import 'package:code_icons/data/model/response/collections/payment_values_dm.dart';
import 'package:code_icons/data/model/response/collections/station/station_data_model.dart';
import 'package:code_icons/data/model/response/collections/trade_office/trade_office.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class TradeCollectionManager implements TradeCollectionsInterface {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;

  TradeCollectionManager({
    required this.httpRequestHelper,
    required this.handleResponseHelper,
    required this.authManager,
  });
  @override
  Future<Either<Failures, List<TradeCollectionResponse>>>
      fetchTradeCollectionData({
    required int skip,
    required int take,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var queryParams = {
        'skip': skip.toString(),
        'take': take.toString(),
        'requireTotalCount': 'true',
        // Only add filter if provided
      };

      var url = Uri.https(
        ApiConstants.chamberApi,
        ApiConstants.tradeCollectionEndPoint,
        queryParams,
      );
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<TradeCollectionResponse>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => TradeCollectionResponse.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, TradeCollectionResponse>> getTradeCollectionDataByID(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, "/api/TradeCollection/$id");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<TradeCollectionResponse>(
        response: response,
        fromJson: (json) => TradeCollectionResponse.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ActivityDataModel>>> fetchActivityeData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.activityEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<ActivityDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => ActivityDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, ActivityDataModel>> fetchActivityeDataById(
      {required int activityId}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.activityEndPoint}/$activityId");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<ActivityDataModel>(
        response: response,
        fromJson: (json) => ActivityDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PaymenValuesDM>> fetchPaymentValuesByID(
      {String? customerId}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.paymentValuesEndPoint}/$customerId");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<PaymenValuesDM>(
        response: response,
        fromJson: (json) => PaymenValuesDM.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, TradeCollectionResponse>> postTradeCollectionData({
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.tradeCollectionEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(tradeCollectionRequest.toJson()),
      );

      return await handleResponseHelper.handleResponse<TradeCollectionResponse>(
        response: response,
        fromJson: (id) => TradeCollectionResponse(idBl: id),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, int>> postUnRegisteredTradeCollectionData({
    required UnRegisteredCollectionsResponse unRegisteredTradeCollectionRequest,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, "/api/TradeCollection/UnRegistered");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(unRegisteredTradeCollectionRequest.toJson()),
      );

      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<UnRegisteredCollectionsResponse>>>
      getUnRegisteredTradeCollectionData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, "/api/TradeCollection/UnRegistered");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<UnRegisteredCollectionsResponse>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => UnRegisteredCollectionsResponse.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PaymenValuesDM>> postPaymenValuesByID({
    int? customerId,
    List<int>? paidYears,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.paymentValuesEndPoint}/$customerId");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(paidYears),
      );

      return await handleResponseHelper.handleResponse<PaymenValuesDM>(
        response: response,
        fromJson: (json) => PaymenValuesDM.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<TradeOfficeDataModel>>>
      fetchTradeOfficeData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.tradeOfficeEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<TradeOfficeDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => TradeOfficeDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, TradeOfficeDataModel>> fetchTradeOfficeDataById({
    required int tradeOfficeID,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.tradeOfficeEndPoint}/$tradeOfficeID");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<TradeOfficeDataModel>(
        response: response,
        fromJson: (json) => TradeOfficeDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<StationDataModel>>> fetchStationData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.stationEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<StationDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => StationDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, StationDataModel>> fetchStationDataById({
    required int stationId,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.stationEndPoint}/$stationId");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<StationDataModel>(
        response: response,
        fromJson: (json) => StationDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<GeneralCentralDataModel>>>
      fetchGeneralCenterseData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.generalCentersEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<GeneralCentralDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => GeneralCentralDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GeneralCentralDataModel>>
      fetchGeneralCenterseDataById({
    required int generalCentralId,
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          "${ApiConstants.generalCentersEndPoint}/$generalCentralId");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<GeneralCentralDataModel>(
        response: response,
        fromJson: (json) => GeneralCentralDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
