// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/data/model/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/domain/repo/add_unregistered_collection_repo.dart';
import 'package:dartz/dartz.dart';

class AddUnregisteredCollectionUseCase {
  AddUnregisteredCollectionRepo addUnregisteredCollectionRepo;
  AddUnregisteredCollectionUseCase({
    required this.addUnregisteredCollectionRepo,
  });
  Future<Either<Failures, int>> invoke({
    required UnRegisteredCollectionsResponse unRegisteredCollectionEntity,
  }) async {
    return await addUnregisteredCollectionRepo.addCollction(
        unRegisteredTradeCollectionRequest: unRegisteredCollectionEntity);
  }
}
