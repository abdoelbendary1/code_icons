import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/data_source/show_all_UnRegistered_TC.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/domain/repo/show_all_UnRegisgered_collections.dart';
import 'package:dartz/dartz.dart';

class FetchUnregisteredCollectionRepoImpl
    implements FetchUnregisteredCollectionRepo {
  FecthUnregisteredTradeDataSource fecthUnregisteredTradeDataSource;
  FetchUnregisteredCollectionRepoImpl(
      {required this.fecthUnregisteredTradeDataSource});

  @override
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>>
      fetchCollections({
    required int skip,
    required int take,
    String? filter,
  }) {
    return fecthUnregisteredTradeDataSource.fetchCollections(
        skip: skip, take: take, filter: filter);
  }
}
