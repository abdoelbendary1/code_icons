import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';

sealed class UnlimitedCollectionState {}

class UnlimitedCollectionInitial extends UnlimitedCollectionState {}

class AddCollectionLoading extends UnlimitedCollectionState {}

class AddUnlimitedCollectionError extends UnlimitedCollectionState {
  String errorMsg;
  AddUnlimitedCollectionError({required this.errorMsg});
}

class AddUnlimitedCollectionSuccess extends UnlimitedCollectionState {
  String? collectionID;
  AddUnlimitedCollectionSuccess({
    required this.collectionID,
  });
}

class GetPaymentRecietValueError extends UnlimitedCollectionState {
  int paymentReciept;
  GetPaymentRecietValueError({required this.paymentReciept});
}

class GetCollectionsLoading extends UnlimitedCollectionState {}

class GetUnlimitedCollectionsError extends UnlimitedCollectionState {
  String errorMsg;
  GetUnlimitedCollectionsError({required this.errorMsg});
}

class GetUnlimitedCollectionsSuccess extends UnlimitedCollectionState {
  List<UnRegisteredCollectionEntity> collectiion;
  bool isLastPage;
  GetUnlimitedCollectionsSuccess(
      {required this.collectiion, required this.isLastPage});
}