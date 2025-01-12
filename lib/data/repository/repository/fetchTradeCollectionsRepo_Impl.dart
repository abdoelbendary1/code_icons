// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/data/model/response/collections/TradeCollectionResponse.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/fetchTradeCollectionsDataSource.dart';
import 'package:code_icons/domain/repository/repository/fetchTradeCollectionsRepo.dart';

class FetchTradeCollectionsRepoImpl implements FetchTradeCollectionsRepo {
  FetchTradeCollectionsDataSource fetchTradeCollectionsDataSource;
  FetchTradeCollectionsRepoImpl({
    required this.fetchTradeCollectionsDataSource,
  });
  @override
  Future<Either<Failures, List<TradeCollectionEntity>>>
      fetchTradeCollectionData({
    required int skip,
    required int take,
    String? filter,
    List<dynamic>? filterConditions,
  }) {
    return fetchTradeCollectionsDataSource.fetchTradeCollectionData(
        skip: skip, take: take, filter: filter, filterConditions: filterConditions);
  }
}
