part of 'customers_cubit.dart';

@immutable
sealed class CustomersState {}

final class CustomersInitial extends CustomersState {}

final class AddCustomerLoading extends CustomersState {}

final class AddCustomerError extends CustomersState {
  String errorMsg;
  AddCustomerError({required this.errorMsg});
}

final class AddCustomerSuccess extends CustomersState {
  String proccessId;
  AddCustomerSuccess({required this.proccessId});
}

final class FetchCustomersSuccess extends CustomersState {
  List<CustomerDataEntity> customers;
  FetchCustomersSuccess({required this.customers});
}

final class FetchCustomersError extends CustomersState {
  String errorMsg;
  FetchCustomersError({required this.errorMsg});
}

final class LoadCustomerByID extends CustomersState {}

final class LoadedCustomerByIDError extends CustomersState {
  String errorMsg;
  LoadedCustomerByIDError({required this.errorMsg});
}

final class LoadedCustomerByID extends CustomersState {
  CustomerDataEntity customerDataEntity;
  LoadedCustomerByID({required this.customerDataEntity});
}

final class LoadCurrency extends CustomersState {}

final class FetchCurrencyError extends CustomersState {
  String errorMsg;
  FetchCurrencyError({required this.errorMsg});
}

final class FetchCurrencySuccess extends CustomersState {
  List<CurrencyEntity> currencies;
  FetchCurrencySuccess({required this.currencies});
}

final class LoadedCurrency extends CustomersState {
  CurrencyEntity currencyEntity;
  LoadedCurrency({required this.currencyEntity});
}

// Additional states for Trade Office
final class LoadTradeOffice extends CustomersState {}

final class FetchTradeOfficeError extends CustomersState {
  String errorMsg;
  FetchTradeOfficeError({required this.errorMsg});
}

final class FetchTradeOfficeSuccess extends CustomersState {
  List<TradeOfficeEntity> tradeOffices;
  FetchTradeOfficeSuccess({required this.tradeOffices});
}

final class LoadedTradeOffice extends CustomersState {
  TradeOfficeEntity tradeOfficeEntity;
  LoadedTradeOffice({required this.tradeOfficeEntity});
}

// Additional states for General Central
final class LoadGeneralCentral extends CustomersState {}

final class FetchGeneralCentralError extends CustomersState {
  String errorMsg;
  FetchGeneralCentralError({required this.errorMsg});
}

final class FetchGeneralCentralSuccess extends CustomersState {
  List<GeneralCentralEntity> generalCentrals;
  FetchGeneralCentralSuccess({required this.generalCentrals});
}

final class LoadedGeneralCentral extends CustomersState {
  GeneralCentralEntity generalCentralEntity;
  LoadedGeneralCentral({required this.generalCentralEntity});
}

// Additional states for Activity
final class LoadActivity extends CustomersState {}

final class FetchActivityError extends CustomersState {
  String errorMsg;
  FetchActivityError({required this.errorMsg});
}

final class FetchActivitySuccess extends CustomersState {
  List<ActivityEntity> activities;
  FetchActivitySuccess({required this.activities});
}

final class FetchStationError extends CustomersState {
  String errorMsg;
  FetchStationError({required this.errorMsg});
}

final class FetchStationSuccess extends CustomersState {
  List<StationEntity> stations;
  FetchStationSuccess({required this.stations});
}

final class LoadStation extends CustomersState {
  LoadStation();
}

final class LoadedActivity extends CustomersState {
  ActivityEntity activityEntity;
  LoadedActivity({required this.activityEntity});
}

class FetchTradeRegistryTypesError extends CustomersState {
  String errorMsg;
  FetchTradeRegistryTypesError({required this.errorMsg});
}
