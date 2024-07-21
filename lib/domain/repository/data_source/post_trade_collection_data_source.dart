import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PostTradeCollectionDataSource {
  Future<Either<Failures, TradeCollectionEntity>> postTradeCollectionData({
    required String token,
    required TradeCollectionRequest tradeCollectionRequest,
  });
}