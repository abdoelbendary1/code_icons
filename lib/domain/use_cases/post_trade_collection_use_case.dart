// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/post_trade_collection_repo.dart';
import 'package:dartz/dartz.dart';

class PostTradeCollectionUseCase {
  PostTradeCollectionRepo postTradeCollectionRepo;
  PostTradeCollectionUseCase({
    required this.postTradeCollectionRepo,
  });
  Future<Either<Failures, TradeCollectionEntity>> invoke({
    required String token,
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    return await postTradeCollectionRepo.postTradeCollectionData(
        token: token, tradeCollectionRequest: tradeCollectionRequest);
  }
}
