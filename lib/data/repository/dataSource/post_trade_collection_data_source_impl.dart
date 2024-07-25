import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/data_model/unlimited_Data_model.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/domain/repository/data_source/post_trade_collection_data_source.dart';
import 'package:dartz/dartz.dart';

class PostTradeCollectionDataSourceImpl
    implements PostTradeCollectionDataSource {
  ApiManager apiManager;
  PostTradeCollectionDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, TradeCollectionEntity>> postTradeCollectionData(
      {required String token,
      required TradeCollectionRequest tradeCollectionRequest}) async {
    var either = await apiManager.postTradeCollectionData(
        token: token, tradeCollectionRequest: tradeCollectionRequest);
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, String>> postUnRegisteredTradeCollectionData(
      {required UnRegisteredCollectionsResponse
          unRegisteredTradeCollectionRequest}) async {
    var either = await apiManager.postUnRegisteredTradeCollectionData(
        unRegisteredTradeCollectionRequest: unRegisteredTradeCollectionRequest);
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>>
      getUnRegisteredTradeCollectionData() async {
    var either = await apiManager.getUnRegisteredTradeCollectionData();
    return either.fold((l) => left(l), (response) => right(response));
  }
}
