import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AddTradeCollectionRepo {
  Future<Either<Failures, TradeCollectionEntity>> addCollection({
    required TradeCollectionRequest tradeCollectionRequest,
  });
}
