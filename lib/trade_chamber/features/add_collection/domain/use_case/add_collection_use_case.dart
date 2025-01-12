// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/add_collection/domain/repo/add_collection_repo.dart';
import 'package:dartz/dartz.dart';

class PostTradeCollectionUseCase {
  AddTradeCollectionRepo postTradeCollectionRepo;
  PostTradeCollectionUseCase({
    required this.postTradeCollectionRepo,
  });
  Future<Either<Failures, TradeCollectionEntity>> invoke({
    required String token,
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    return await postTradeCollectionRepo.addCollection(
        tradeCollectionRequest: tradeCollectionRequest);
  }
}
