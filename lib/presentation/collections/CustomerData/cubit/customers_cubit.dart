import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/General_central/general_central_entity.dart';
import 'package:code_icons/domain/entities/station/station.dart';
import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';
import 'package:code_icons/domain/use_cases/fetch_Station_usecase.dart';
import 'package:code_icons/domain/use_cases/fetch_currency_byID_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_currency_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/post_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_trade_office_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_general_central_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_activity_useCase.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/activity/activity_entity.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit({
    required this.postCustomerDataUseCase,
    required this.fetchCustomerDataUseCase,
    required this.fetchCustomerDataByIDUseCase,
    required this.fetchCurrencyUseCase,
    required this.fetchCurrencyByIDUseCase,
    required this.fetchActivityUseCase,
    required this.fetchGeneralCentralUseCase,
    required this.fetchTradeOfficeUseCase,
    required this.fetchStationListUseCase,
  }) : super(CustomersInitial());

  static CustomersCubit get customersCubit => CustomersCubit(
        postCustomerDataUseCase: injectPostCustomerDataUseCase(),
        fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
        fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
        fetchCurrencyByIDUseCase: injectFetchCurrencyDataByIDUseCase(),
        fetchCurrencyUseCase: iinjectFetchCurrencyUseCase(),
        fetchActivityUseCase: injectFetchActivityListUseCase(),
        fetchGeneralCentralUseCase: injectFetchGeneralCentralListUseCase(),
        fetchTradeOfficeUseCase: injectFetchTradeOfficeListUseCase(),
        fetchStationListUseCase: injectFetchStationListUseCase(),
      );
  PostCustomerDataUseCase postCustomerDataUseCase;
  FetchCustomerDataUseCase fetchCustomerDataUseCase;
  FetchCustomerDataByIDUseCase fetchCustomerDataByIDUseCase;
  FetchCurrencyUseCase fetchCurrencyUseCase;
  FetchCurrencyByIDUseCase fetchCurrencyByIDUseCase;
  FetchTradeOfficeListUseCase fetchTradeOfficeUseCase;
  FetchGeneralCentralListUseCase fetchGeneralCentralUseCase;
  FetchActivityListUseCase fetchActivityUseCase;
  FetchStationListUseCase fetchStationListUseCase;
  List<CurrencyEntity> currencyData = [];
  List<CustomerDataEntity> customerData = [];
  List<TradeOfficeEntity> tradeOfficeData = [];
  List<GeneralCentralEntity> generalCentralData = [];
  List<ActivityEntity> activityData = [];
  List<StationEntity> stationData = [];
  CurrencyEntity selectedCurrency = CurrencyEntity();
  StationEntity selectedStation = StationEntity();
  TradeOfficeEntity selectedTradeOffice = TradeOfficeEntity();
  GeneralCentralEntity selectedGeneralCentral = GeneralCentralEntity();
  ActivityEntity selectedActivity = ActivityEntity();
  Map<String, dynamic>? selectedTradeRegistryType;
  Map<String, dynamic>? selectedCopmanyyType;
  Map<String, dynamic>? selectedValidType;
  //! check the selectedCustomer ID
  CustomerDataEntity selectedCustomer = CustomerDataEntity();
  final List<Map<String, dynamic>> tradeRegistryTypes = [
    {'id': 1, 'type': "رئيسي"},
    {'id': 2, 'type': "فرعي"},
    {'id': 3, 'type': "رئيسي اخر"},
    {'id': 4, 'type': "فرع محافظة اخري"},
    {'id': 5, 'type': "رئيسي محافظة اخري"},
  ];
  final List<Map<String, dynamic>> companyTypeList = [
    {"idBL": 1, "companyTypeBL": "شركة"},
    {"idBL": 2, "companyTypeBL": "فردي"},
    {'idBL': 3, "companyTypeBL": "إستثمار"}
  ];
  final List<Map<String, dynamic>> validtypes = [
    {"id": 1, "type": "ساري"},
    {"id": 2, "type": "مشطوب"}
  ];
  int getKeyByValue(
      {required List<Map<String, dynamic>> mapList,
      String? value,
      String? mapKey,
      String? mapValue}) {
    if (value != null) {
      for (var map in mapList) {
        if (map[value] == value) {
          return map[value];
        }
      }
    }

    return 1; // Default value if no match is found
  }

  String convertStringToDate({required String inputString}) {
    if (inputString.isNotEmpty) {
      DateFormat inputFormat = DateFormat('yyyy/MM/dd');
      // Parse the input string into a DateTime object
      DateTime dateTime = inputFormat.parse(inputString);

      // Define the output format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      // Format the DateTime object into the desired output format
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    }
    return "";
  }

  CurrencyEntity changeCurrency(CurrencyEntity newCurrencyEntity) {
    selectedCurrency = newCurrencyEntity;
    return selectedCurrency;
  }

  bool isSubBranchSelected = false;
  void showTradeRegistryTypes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: tradeRegistryTypes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(tradeRegistryTypes[index]['type']),
              onTap: () {
                ControllerManager()
                    .getControllerByName('tradeRegistryTypeBL')
                    .text = tradeRegistryTypes[index]['type'];
                isSubBranchSelected =
                    tradeRegistryTypes[index]['type'] == "فرعي";

                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  int? tryParseInt(String? text, {int? defaultValue}) {
    if (text == null || text.isEmpty) {
      return defaultValue;
    }
    try {
      return int.parse(text);
    } catch (e) {
      return defaultValue;
    }
  }

  Map<String, String> dateStorageMap = {
    'birthDayBL': '',
    'licenseDateBL': '',
  };
  CustomerDataModel createCustomerDataModelFromControllers(
      List<TextEditingController> controllers, BuildContext context) {
    return CustomerDataModel(
      idBl: tryParseInt(controllers[0].text,
          defaultValue: 1), // Assuming 1 is the default ID
      brandNameBl: controllers[1].text,
      nationalIdBl:
          ControllerManager().getControllerByName('nationalIdBL').text,
      birthDayBl: convertStringToDate(
          inputString:
              ControllerManager().getControllerByName("birthDayBL").text),
      tradeRegistryBl:
          ControllerManager().getControllerByName('tradeRegistryBL').text,
      licenseDateBl: convertStringToDate(
          inputString:
              ControllerManager().getControllerByName('licenseDateBL').text),
      licenseYearBl: tryParseInt(controllers[6].text, defaultValue: 0),
      capitalBl: double.parse(controllers[7].text),
      validBl: getKeyByValue(
          mapList: validtypes,
          value: selectedValidType?['type'],
          mapKey: "id",
          mapValue: "type"),
      companyTypeBl: selectedCopmanyyType != null
          ? getKeyByValue(
              mapList: companyTypeList,
              value: selectedCopmanyyType?['companyTypeBL'],
              mapKey: "companyTypeBL",
              mapValue: "companyTypeBL")
          : 1,
      companyTypeNameBl: getKeyByValue(
              mapList: companyTypeList,
              value: selectedCopmanyyType?['companyTypeBL'],
              mapKey: "companyTypeBL",
              mapValue: "companyTypeBL")
          .toString(),
      currencyIdBl: selectedCurrency.id,
      tradeOfficeBl: selectedTradeOffice.idBl,
      tradeOfficeNameBl: selectedTradeOffice.tradeOfficeBl,
      activityBl: selectedActivity.idBl,
      activityNameBl: selectedActivity.activityBl,
      /* expiredBl: ControllerManager().getControllerByName('expiredBL').text, */
      divisionBl: ControllerManager().getControllerByName('divisionBL').text,
      tradeTypeBl: ControllerManager().getControllerByName('tradeTypeBL').text,
      ownerBl: ControllerManager().getControllerByName('ownerBL').text,
      addressBl: ControllerManager().getControllerByName('addressBL').text,
      stationBl: selectedStation.idBl,
      stationNameBl: selectedStation.stationBl,
      phoneBl: ControllerManager().getControllerByName('phoneBL').text,
      numExpiredBl:
          ControllerManager().getControllerByName('numExpiredBL').text,
      tradeRegistryTypeBl: getKeyByValue(
        mapList: tradeRegistryTypes,
        value: selectedTradeRegistryType!['type'],
      ),
    );
  }

  void fetchTradeOffices() async {
    var either = await fetchTradeOfficeUseCase.invoke();
    either.fold((l) => emit(FetchTradeOfficeError(errorMsg: l.errorMessege)),
        (r) {
      tradeOfficeData = r;
      emit(FetchTradeOfficeSuccess(tradeOffices: r));
    });
  }

  void fetchStations() async {
    var either = await fetchStationListUseCase.invoke();
    either.fold((l) => emit(FetchStationError(errorMsg: l.errorMessege)), (r) {
      stationData = r;
      emit(FetchStationSuccess(stations: r));
    });
  }

  void fetchGeneralCentrals() async {
    var either = await fetchGeneralCentralUseCase.invoke();
    either.fold((l) => emit(FetchGeneralCentralError(errorMsg: l.errorMessege)),
        (r) {
      generalCentralData = r;
      emit(FetchGeneralCentralSuccess(generalCentrals: r));
    });
  }

  void fetchActivities() async {
    var either = await fetchActivityUseCase.invoke();
    either.fold((l) => emit(FetchActivityError(errorMsg: l.errorMessege)), (r) {
      activityData = r;
      emit(FetchActivitySuccess(activities: r));
    });
  }

  void fetchCurrencies() async {
    var either = await fetchCurrencyUseCase.invoke();
    either.fold((l) => emit(FetchCurrencyError(errorMsg: l.errorMessege)), (r) {
      currencyData = r;
      emit(FetchCurrencySuccess(currencies: r));
    });
  }

  Future<void> fetchCurrencyDataByID({required String currencyId}) async {
    emit(LoadCurrency());
    var either = await fetchCurrencyByIDUseCase.invoke(
        currencyId: int.parse(currencyId));

    either.fold((failure) {
      print(failure.errorMessege);
      emit(FetchCurrencyError(errorMsg: failure.errorMessege));
    }, (currencyEntity) {
      ControllerManager().updateCurrencyController(currencyEntity);
      selectedCurrency.id = currencyEntity.id;
      emit(LoadedCurrency(currencyEntity: currencyEntity));
    });
  }

  void addCustomer(CustomerDataModel customerData) async {
    var either = await postCustomerDataUseCase.invoke(customerData);
    either.fold((l) => emit(AddCustomerError(errorMsg: l.errorMessege)),
        (r) => emit(AddCustomerSuccess(proccessId: r)));
  }

  void fetchCustomers() async {
    var either = await fetchCustomerDataUseCase.invoke();
    either.fold((l) => emit(FetchCustomersError(errorMsg: l.errorMessege)),
        (r) {
      customerData = r;
      emit(FetchCustomersSuccess(customers: r));
    });
  }

  Future<void> fetchCustomerDataByID({required String customerId}) async {
    emit(LoadCustomerByID());
    var either =
        await fetchCustomerDataByIDUseCase.invoke(customerId: customerId);

    either.fold((failure) {
      print(failure.errorMessege);
      emit(LoadedCustomerByIDError(errorMsg: failure.errorMessege));
    }, (customerDataEntity) async {
      ControllerManager().updateControllersWithCustomerData(customerDataEntity);
      selectedCustomer.brandNameBl = customerDataEntity.brandNameBl;
      /* await fetchCurrencyDataByID(
          currencyId: customerDataEntity.currencyIdBl.toString()); */
      emit(LoadedCustomerByID(customerDataEntity: customerDataEntity));
    });
  }

  String getCurrencyNameById(int currencyId) {
    try {
      final currency =
          currencyData.firstWhere((currency) => currency.id == currencyId);
      return currency.currencyNameAr ?? "Unknown Currency";
    } catch (e) {
      return "Unknown Currency";
    }
  }
}
