// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customers_cubit.dart';

@immutable
sealed class CustomersState {}

class UpdateTradeRegistryTypeLoading extends CustomersState {}

class UpdateTradeRegistryTypeSuccess extends CustomersState {
  Map<String, dynamic>? selectedTradeRegistryType;
  UpdateTradeRegistryTypeSuccess({required this.selectedTradeRegistryType});
}

class UpdateValidTypeSuccess extends CustomersState {
  Map<String, dynamic>? selectedValidType;
  UpdateValidTypeSuccess({
    this.selectedValidType,
  });
}

class UpdateValidTypeLoading extends CustomersState {}

class UpdateCompanyTypeSuccess extends CustomersState {
  Map<String, dynamic>? selectedCopmanyyType;
  UpdateCompanyTypeSuccess({
    this.selectedCopmanyyType,
  });
}

class UpdateCompanyTypeLoading extends CustomersState {}

class CustomersInitial extends CustomersState {}

class AddCustomerLoading extends CustomersState {}

class AddCustomerError extends CustomersState {
  String errorMsg;
  AddCustomerError({required this.errorMsg});
}

class AddCustomerSuccess extends CustomersState {
  String proccessId;
  AddCustomerSuccess({required this.proccessId});
}

class FetchCustomersSuccess extends CustomersState {
  List<CustomerDataEntity> customers;
  FetchCustomersSuccess({required this.customers});
}

class FetchCustomersError extends CustomersState {
  String errorMsg;
  FetchCustomersError({required this.errorMsg});
}

class LoadCustomerByID extends CustomersState {}

class LoadedCustomerByIDError extends CustomersState {
  String errorMsg;
  LoadedCustomerByIDError({required this.errorMsg});
}

class LoadedCustomerByID extends CustomersState {
  CustomerDataEntity customerDataEntity;
  LoadedCustomerByID({required this.customerDataEntity});
}

class LoadCurrency extends CustomersState {}

class FetchCurrencyError extends CustomersState {
  String errorMsg;
  FetchCurrencyError({required this.errorMsg});
}

class FetchCurrencySuccess extends CustomersState {
  List<CurrencyEntity> currencies;
  FetchCurrencySuccess({required this.currencies});
}

class LoadedCurrency extends CustomersState {
  CurrencyEntity currencyEntity;
  LoadedCurrency({required this.currencyEntity});
}

// Additional states for Trade Office
class LoadTradeOffice extends CustomersState {}

class FetchTradeOfficeError extends CustomersState {
  String errorMsg;
  FetchTradeOfficeError({required this.errorMsg});
}

class FetchTradeOfficeSuccess extends CustomersState {
  List<TradeOfficeEntity> tradeOffices;
  FetchTradeOfficeSuccess({required this.tradeOffices});
}

class LoadedTradeOffice extends CustomersState {
  TradeOfficeEntity tradeOfficeEntity;
  LoadedTradeOffice({required this.tradeOfficeEntity});
}

// Additional states for General Central
class LoadGeneralCentral extends CustomersState {}

class FetchGeneralCentralError extends CustomersState {
  String errorMsg;
  FetchGeneralCentralError({required this.errorMsg});
}

class FetchGeneralCentralSuccess extends CustomersState {
  List<GeneralCentralEntity> generalCentrals;
  FetchGeneralCentralSuccess({required this.generalCentrals});
}

class LoadedGeneralCentral extends CustomersState {
  GeneralCentralEntity generalCentralEntity;
  LoadedGeneralCentral({required this.generalCentralEntity});
}

// Additional states for Activity
class LoadActivity extends CustomersState {}

class FetchActivityError extends CustomersState {
  String errorMsg;
  FetchActivityError({required this.errorMsg});
}

class FetchActivitySuccess extends CustomersState {
  List<ActivityEntity> activities;
  FetchActivitySuccess({required this.activities});
}

class FetchStationError extends CustomersState {
  String errorMsg;
  FetchStationError({required this.errorMsg});
}

class FetchStationSuccess extends CustomersState {
  List<StationEntity> stations;
  FetchStationSuccess({required this.stations});
}

class LoadedStation extends CustomersState {
  StationEntity station;
  LoadedStation({required this.station});
}

class LoadStation extends CustomersState {
  LoadStation();
}

class LoadedActivity extends CustomersState {
  ActivityEntity activityEntity;
  LoadedActivity({required this.activityEntity});
}

class FetchTradeRegistryTypesError extends CustomersState {
  String errorMsg;
  FetchTradeRegistryTypesError({required this.errorMsg});
}
