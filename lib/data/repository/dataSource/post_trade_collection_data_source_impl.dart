import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/post_trade_collection_data_source.dart';
import 'package:dartz/dartz.dart';

class PostTradeCollectionDataSourceImpl
    implements PostTradeCollectionDataSource {
  ApiManager apiManager;
  PostTradeCollectionDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, TradeCollectionEntity>> postTradeCollectionData(
      {required String token,
      required TradeCollectionRequest tradeCollectionRequest}) async {
    var either = await apiManager.postTradeCollectionData(
        token: token, tradeCollectionRequest: tradeCollectionRequest);
    return either.fold((l) => left(l), (respone) => right(respone));
  }
}
