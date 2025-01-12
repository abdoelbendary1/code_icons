import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class FetchTradeCollectionsDataSource {
  Future<Either<Failures, List<TradeCollectionEntity>>>
      fetchTradeCollectionData({
    required int skip,
    required int take,
    String? filter,
    List<dynamic>? filterConditions,
  });
}
