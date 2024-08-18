part of 'all_daily_collector_cubit.dart';

@immutable
abstract class AllDailyCollectorState {}

class AllDailyCollectorInitial extends AllDailyCollectorState {}

class GetAllCollectionsError extends AllDailyCollectorState {
  String errorMsg;
  GetAllCollectionsError({required this.errorMsg});
}

class GetAllCollectionsSuccess extends AllDailyCollectorState {
  List<TradeCollectionEntity> dataList;
  GetAllCollectionsSuccess({required this.dataList});
}

class RowSelectedState extends AllDailyCollectorState {
  TradeCollectionEntity selectedRow;
  RowSelectedState({required this.selectedRow});
}

class GetAllCustomerDataError extends AllDailyCollectorState {
  String errorMsg;
  GetAllCustomerDataError({required this.errorMsg});
}

// ignore: must_be_immutable
class GetAllCustomerDataSuccessDaily extends AllDailyCollectorState {
  List<CustomerDataEntity> customerData;

  GetAllCustomerDataSuccessDaily({
    required this.customerData,
  });
}
