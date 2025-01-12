import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FecthUnregisteredTradeDataSource {
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>> fetchCollections({
    required int skip,
    required int take,
    String? filter,
  });
}

class FecthUnregisteredTradeDataSourceImpl
    implements FecthUnregisteredTradeDataSource {
  ApiManager apiManager;
  FecthUnregisteredTradeDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>> fetchCollections({
    required int skip,
    required int take,
    String? filter,
  }) async {
    var either = await apiManager.getUnRegisteredTradeCollectionData(
      skip: skip,
      take: take,
      filter: filter,
    );
    return either.fold((l) => left(l), (response) => right(response));
  }
}
