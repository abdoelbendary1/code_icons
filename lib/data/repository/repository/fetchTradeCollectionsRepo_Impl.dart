// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
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
      fetchTradeCollectionData() {
    return fetchTradeCollectionsDataSource.fetchTradeCollectionData();
  }
}
