import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/data/model/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AddUnregisteredTradeDataSource {
  Future<Either<Failures, int>> addCollection({
    required UnRegisteredCollectionsResponse unRegisteredTradeCollectionRequest,
  });
}

class AddUnregisteredTradeDataSourceImpl
    implements AddUnregisteredTradeDataSource {
  ApiManager apiManager;
  AddUnregisteredTradeDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, int>> addCollection(
      {required UnRegisteredCollectionsResponse
          unRegisteredTradeCollectionRequest}) async {
    var either = await apiManager.postUnRegisteredTradeCollectionData(
        unRegisteredTradeCollectionRequest: unRegisteredTradeCollectionRequest);
    return either.fold((l) => left(l), (response) => right(response));
  }
}
