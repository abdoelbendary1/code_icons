part of 'items_cubit.dart';

sealed class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

final class ItemsInitial extends ItemsState {}

final class getUomDataError extends ItemsState {
  String errorMsg;
  getUomDataError({required this.errorMsg});
}

final class GetUomDatSuccess extends ItemsState {
  List<UomEntity> uomlist;
  GetUomDatSuccess({required this.uomlist});
}

final class GetUomDataLoading extends ItemsState {}

final class AddItemCompanyError extends ItemsState {
  String errorMsg;
  AddItemCompanyError({required this.errorMsg});
}

final class AddItemCompanySuccess extends ItemsState {}

final class AddItemCompanyLoading extends ItemsState {}

final class AddItemCategoryError extends ItemsState {
  String errorMsg;
  AddItemCategoryError({required this.errorMsg});
}

final class AddItemCategorySuccess extends ItemsState {}

final class AddItemCategoryLoading extends ItemsState {}

final class getAllItemsError extends ItemsState {
  String errorMsg;
  getAllItemsError({required this.errorMsg});
}

final class getAllItemsSuccess extends ItemsState {
  List<SalesItemDm> items;
  getAllItemsSuccess({required this.items});
}

final class getAllItemsLoading extends ItemsState {}

final class getCompaniesDataError extends ItemsState {
  String errorMsg;
  getCompaniesDataError({required this.errorMsg});
}

final class GetCompaniesSuccess extends ItemsState {
  List<ItemCompanyEntity> companiesList;
  GetCompaniesSuccess({required this.companiesList});
}

final class GetCompaniesLoading extends ItemsState {}

final class getCategoriesDataError extends ItemsState {
  String errorMsg;
  getCategoriesDataError({required this.errorMsg});
}

final class GetCategoriesSuccess extends ItemsState {
  List<ItemCategoryEntity> categoriesList;
  GetCategoriesSuccess({required this.categoriesList});
}

final class GetCategoriesLoading extends ItemsState {}

final class AddItemError extends ItemsState {
  String errorMsg;
  AddItemError({required this.errorMsg});
}

final class AddItemSuccess extends ItemsState {}

final class AddItemLoading extends ItemsState {}
