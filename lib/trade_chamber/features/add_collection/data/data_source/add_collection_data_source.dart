import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AddTradeCollectionDataSource {
  Future<Either<Failures, TradeCollectionEntity>> addCollection({
    required TradeCollectionRequest tradeCollectionRequest,
  });
}

class TradeCollectionDataSourceImpl implements AddTradeCollectionDataSource {
  ApiManager apiManager;
  TradeCollectionDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, TradeCollectionEntity>> addCollection(
      {required TradeCollectionRequest tradeCollectionRequest}) async {
    var either = await apiManager.postTradeCollectionData(
        tradeCollectionRequest: tradeCollectionRequest);
    return either.fold((l) => left(l), (response) => right(response));
  }
}
