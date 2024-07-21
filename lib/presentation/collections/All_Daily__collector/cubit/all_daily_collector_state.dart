part of 'all_daily_collector_cubit.dart';

@immutable
abstract class AllDailyCollectorState {}

class AllDailyCollectorInitial extends AllDailyCollectorState {}

class GetAllCollectionsError extends AllDailyCollectorState {
  final String errorMsg;
  GetAllCollectionsError({required this.errorMsg});
}

class GetAllCollectionsSuccess extends AllDailyCollectorState {
  final List<TradeCollectionEntity> dataList;
  GetAllCollectionsSuccess({required this.dataList});
}

class RowSelectedState extends AllDailyCollectorState {
  final TradeCollectionEntity selectedRow;
  RowSelectedState({required this.selectedRow});
}

final class GetAllCustomerDataError extends AllDailyCollectorState {
  String errorMsg;
  GetAllCustomerDataError({required this.errorMsg});
}

// ignore: must_be_immutable
final class GetAllCustomerDataSuccessDaily extends AllDailyCollectorState {
  List<CustomerDataEntity> customerData;

  GetAllCustomerDataSuccessDaily({
    required this.customerData,
  });
}
