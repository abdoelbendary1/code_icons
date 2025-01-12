import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/data_source/add_collection_data_source.dart';
import 'package:code_icons/trade_chamber/features/add_collection/domain/repo/add_collection_repo.dart';
import 'package:dartz/dartz.dart';

class AddTradeCollectionRepoImpl implements AddTradeCollectionRepo {
  AddTradeCollectionDataSource postTradeCollectionDataSource;
  AddTradeCollectionRepoImpl({required this.postTradeCollectionDataSource});
  @override
  Future<Either<Failures, TradeCollectionEntity>> addCollection(
      {required TradeCollectionRequest tradeCollectionRequest}) {
    return postTradeCollectionDataSource.addCollection(
        tradeCollectionRequest: tradeCollectionRequest);
  }
}
