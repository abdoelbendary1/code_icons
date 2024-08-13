import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';

sealed class UnlimitedCollectionState {}

final class UnlimitedCollectionInitial extends UnlimitedCollectionState {}

final class AddCollectionLoading extends UnlimitedCollectionState {}

final class AddUnlimitedCollectionError extends UnlimitedCollectionState {
  String errorMsg;
  AddUnlimitedCollectionError({required this.errorMsg});
}

final class AddUnlimitedCollectionSuccess extends UnlimitedCollectionState {
  String? collectionID;
  AddUnlimitedCollectionSuccess({
    required this.collectionID,
  });
}

final class GetPaymentRecietValueError extends UnlimitedCollectionState {
  int paymentReciept;
  GetPaymentRecietValueError({required this.paymentReciept});
}

final class GetCollectionsLoading extends UnlimitedCollectionState {}

final class GetUnlimitedCollectionsError extends UnlimitedCollectionState {
  String errorMsg;
  GetUnlimitedCollectionsError({required this.errorMsg});
}

final class GetUnlimitedCollectionsSuccess extends UnlimitedCollectionState {
  List<UnRegisteredCollectionEntity> collectiion;
  GetUnlimitedCollectionsSuccess({required this.collectiion});
}
