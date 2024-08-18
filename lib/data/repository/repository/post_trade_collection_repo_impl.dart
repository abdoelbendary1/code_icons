import 'package:code_icons/data/model/data_model/unlimited_Data_model.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/collections/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/domain/repository/data_source/post_trade_collection_data_source.dart';
import 'package:code_icons/domain/repository/repository/post_trade_collection_repo.dart';
import 'package:dartz/dartz.dart';

class PostTradeCollectionRepoImpl implements PostTradeCollectionRepo {
  PostTradeCollectionDataSource postTradeCollectionDataSource;
  PostTradeCollectionRepoImpl({required this.postTradeCollectionDataSource});
  @override
  Future<Either<Failures, TradeCollectionEntity>> postTradeCollectionData(
      {required String token,
      required TradeCollectionRequest tradeCollectionRequest}) {
    return postTradeCollectionDataSource.postTradeCollectionData(
        token: token, tradeCollectionRequest: tradeCollectionRequest);
  }

  @override
  Future<Either<Failures, String>> postUnRegisteredTradeCollectionData(
      {required UnRegisteredCollectionsResponse
          unRegisteredTradeCollectionRequest}) {
    return postTradeCollectionDataSource.postUnRegisteredTradeCollectionData(
        unRegisteredTradeCollectionRequest: unRegisteredTradeCollectionRequest);
  }

  @override
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>>
      getUnRegisteredTradeCollectionData() {
    return postTradeCollectionDataSource.getUnRegisteredTradeCollectionData();
  }
}
