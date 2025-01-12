import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FetchUnregisteredCollectionRepo {
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>>
      fetchCollections({
    required int skip,
    required int take,
    String? filter,
  });
}
