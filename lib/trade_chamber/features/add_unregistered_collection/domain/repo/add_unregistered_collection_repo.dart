import 'package:code_icons/trade_chamber/features/add_unregistered_collection/data/model/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AddUnregisteredCollectionRepo {
  Future<Either<Failures, int>> addCollction({
    required UnRegisteredCollectionsResponse unRegisteredTradeCollectionRequest,
  });
}
