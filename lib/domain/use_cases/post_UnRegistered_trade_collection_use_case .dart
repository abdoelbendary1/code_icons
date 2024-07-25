// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/data_model/unlimited_Data_model.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/data/model/response/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/domain/repository/repository/post_trade_collection_repo.dart';
import 'package:dartz/dartz.dart';

class PostUnRegisteredTradeCollectionUseCase {
  PostTradeCollectionRepo postTradeCollectionRepo;
  PostUnRegisteredTradeCollectionUseCase({
    required this.postTradeCollectionRepo,
  });
  Future<Either<Failures, String>> invoke({
    required UnRegisteredCollectionsResponse unRegisteredCollectionEntity,
  }) async {
    return await postTradeCollectionRepo.postUnRegisteredTradeCollectionData(
        unRegisteredTradeCollectionRequest: unRegisteredCollectionEntity);
  }
}
