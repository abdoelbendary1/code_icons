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

abstract class TradeCollectionsInterface {
  Future<Either<Failures, List<TradeCollectionResponse>>>
      fetchTradeCollectionData({
    required int skip,
    required int take,
    String? filter,
    List<dynamic>? filterConditions,
  });
  Future<Either<Failures, TradeCollectionResponse>> getTradeCollectionDataByID({
    required int id,
  });
  Future<Either<Failures, List<ActivityDataModel>>> fetchActivityeData();
  Future<Either<Failures, ActivityDataModel>> fetchActivityeDataById(
      {required int activityId});
  Future<Either<Failures, PaymenValuesDM>> fetchPaymentValuesByID(
      {String? customerId});
  Future<Either<Failures, TradeCollectionResponse>> postTradeCollectionData({
    required TradeCollectionRequest tradeCollectionRequest,
  });
  Future<Either<Failures, int>> postUnRegisteredTradeCollectionData({
    required UnRegisteredCollectionsResponse unRegisteredTradeCollectionRequest,
  });
  Future<Either<Failures, List<UnRegisteredCollectionsResponse>>>
      getUnRegisteredTradeCollectionData({
    required int skip,
    required int take,
    String? filter,
  });
  Future<Either<Failures, PaymenValuesDM>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears});
  Future<Either<Failures, List<TradeOfficeDataModel>>> fetchTradeOfficeData();
  Future<Either<Failures, TradeOfficeDataModel>> fetchTradeOfficeDataById(
      {required int tradeOfficeID});
  Future<Either<Failures, List<StationDataModel>>> fetchStationData();
  Future<Either<Failures, StationDataModel>> fetchStationDataById(
      {required int stationId});
  Future<Either<Failures, List<GeneralCentralDataModel>>>
      fetchGeneralCenterseData();
  Future<Either<Failures, GeneralCentralDataModel>>
      fetchGeneralCenterseDataById({required int generalCentralId});
}
