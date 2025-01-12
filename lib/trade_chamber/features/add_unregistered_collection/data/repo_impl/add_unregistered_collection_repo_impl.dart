import 'package:code_icons/trade_chamber/features/add_unregistered_collection/data/model/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/data/data_source/add_unregistered_collection_data_source.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/domain/repo/add_unregistered_collection_repo.dart';
import 'package:dartz/dartz.dart';

class AddUnregisteredCollectionRepoImpl
    implements AddUnregisteredCollectionRepo {
  AddUnregisteredTradeDataSource addUnregisteredTradeDataSource;
  AddUnregisteredCollectionRepoImpl(
      {required this.addUnregisteredTradeDataSource});

  @override
  Future<Either<Failures, int>> addCollction(
      {required UnRegisteredCollectionsResponse
          unRegisteredTradeCollectionRequest}) {
    return addUnregisteredTradeDataSource.addCollection(
        unRegisteredTradeCollectionRequest: unRegisteredTradeCollectionRequest);
  }
}
