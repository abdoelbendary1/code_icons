import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/fetchTradeCollectionsDataSource.dart';
import 'package:dartz/dartz.dart';

class FetchTradeCollectionsDataSourceImpl
    implements FetchTradeCollectionsDataSource {
  ApiManager apiManager;
  FetchTradeCollectionsDataSourceImpl({
    required this.apiManager,
  });

  @override
  Future<Either<Failures, List<TradeCollectionEntity>>>
      fetchTradeCollectionData() async {
    var either = await apiManager.fetchTradeCollectionData();
    return either.fold((l) => Left(l), (r) => right(r));
  }
}
