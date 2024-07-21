// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/data/model/response/TradeCollectionResponse.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/fetchTradeCollectionsRepo.dart';
import 'package:dartz/dartz.dart';

class FetchTradeCollectionDataUseCase {
  FetchTradeCollectionsRepo fetchTradeCollectionsRepo;
  FetchTradeCollectionDataUseCase({
    required this.fetchTradeCollectionsRepo,
  });

  Future<Either<Failures, List<TradeCollectionEntity>>>
      fetchTradeCollectionData() async {
    return await fetchTradeCollectionsRepo.fetchTradeCollectionData();
  }
}
