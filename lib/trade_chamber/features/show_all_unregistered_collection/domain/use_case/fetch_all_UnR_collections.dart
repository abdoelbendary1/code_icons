// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/domain/repo/show_all_UnRegisgered_collections.dart';
import 'package:dartz/dartz.dart';

class FetchAllUnRegisteredCollectionsUseCase {
  FetchUnregisteredCollectionRepo fetchUnregisteredCollectionRepo;
  FetchAllUnRegisteredCollectionsUseCase({
    required this.fetchUnregisteredCollectionRepo,
  });
  Future<Either<Failures, List<UnRegisteredCollectionEntity>>> invoke({
    required int skip,
    required int take,
    String? filter,
  }) async {
    return await fetchUnregisteredCollectionRepo.fetchCollections(
        skip: skip, take: take, filter: filter);
  }
}
