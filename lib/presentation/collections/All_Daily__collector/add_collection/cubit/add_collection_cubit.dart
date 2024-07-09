import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/fetch_paymnetValues.dart';
import 'package:code_icons/domain/use_cases/post_trade_collection_use_case.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
part 'add_collection_state.dart';

class AddCollectionCubit extends Cubit<AddCollectionState> {
  AddCollectionCubit({
    required this.fetchCustomerDataUseCase,
    required this.fetchCustomerDataByIDUseCase,
    required this.fetchPaymentValuesUseCase,
    required this.postTradeCollectionUseCase,
  }) : super(GetAllCustomerDataInitial());
  FetchCustomerDataUseCase fetchCustomerDataUseCase;
  FetchCustomerDataByIDUseCase fetchCustomerDataByIDUseCase;
  FetchPaymentValuesUseCase fetchPaymentValuesUseCase;
  PostTradeCollectionUseCase postTradeCollectionUseCase;

  List<CustomerDataEntity> customerData = [
    CustomerDataEntity(),
  ];
  //! check the selectedCustomer ID
  CustomerDataEntity selectedCustomer = CustomerDataEntity(idBl: 21);

  late TradeCollectionRequest tradeCollectionRequest = TradeCollectionRequest(
    activityBl: 4.0,
    addressBl: ControllerManager().addressController.text,
    collectionDateBl: ControllerManager().registryDateController.text,
    compensationBl:
        double.parse(ControllerManager().compensationController.text),
    currentBl: double.parse(ControllerManager().currentFinanceController.text),
    customerDataIdBl: selectedCustomer.idBl!,
    differentBl:
        double.parse(ControllerManager().diffrentFinanaceController.text),
    divisionBl: ControllerManager().divisionController.text,
    lateBl: double.parse(ControllerManager().lateFinanceController.text),
    paymentReceiptNumBl: 5,
    phoneBl: ControllerManager().phoneNumController.text,
    totalBl: double.parse(ControllerManager().totalFinanceController.text),
    tradeRegistryBl: ControllerManager().regisrtyNumController.text,
    yearsOfRepaymentBl: "",
  );
  /* TradeCollectionRequest intializeTradeRequest() {
    return TradeCollectionRequest(
      activityBl: 4.0,
      addressBl: ControllerManager().addressController.text,
      collectionDateBl: ControllerManager().registryDateController.text,
      compensationBl:
          double.parse(ControllerManager().compensationController.text),
      currentBl:
          double.parse(ControllerManager().currentFinanceController.text),
      customerDataIdBl: selectedCustomer.idBl!.toDouble(),
      differentBl:
          double.parse(ControllerManager().diffrentFinanaceController.text),
      divisionBl: ControllerManager().divisionController.text,
      lateBl: double.parse(ControllerManager().lateFinanceController.text),
      paymentReceiptNumBl: 5,
      phoneBl: ControllerManager().phoneNumController.text,
      totalBl: double.parse(ControllerManager().totalFinanceController.text),
      tradeRegistryBl: ControllerManager().regisrtyNumController.text,
      yearsOfRepaymentBl: "",
    );
  } */

  List<Map<String, dynamic>> years = [
    {'year': "2020", 'isChecked': false},
    {'year': "2021", 'isChecked': false},
    {'year': "2022", 'isChecked': false},
    {'year': "2023", 'isChecked': false},
    {'year': "2024", 'isChecked': false},
  ];
  List<Map<String, dynamic>> updateCheckedStatus(
      {required List<Map<String, dynamic>> years,
      required List<int> paidYears}) {
    for (var year in years) {
      if (paidYears.contains(int.parse(year['year']))) {
        year['isChecked'] = true;
      }
    }
    return years;
  }

  void updateYearsList(String yearsString) {
    if (yearsString.isNotEmpty) {
      List<String> yearsList = yearsString.split(",");

      // Clear the existing list
      years.clear();

      // Add new items to the list
      yearsList.forEach((year) {
        Map<String, dynamic> yearsMap = {
          'year': year.trim(),
          'isChecked': false
        };
        years.add(yearsMap);
      });
    }
  }

  void fetchCustomerData() async {
    emit(GetAllCustomerDataInitial());
    var either = await fetchCustomerDataUseCase.invoke();
    either.fold((failure) {
      print(failure.errorMessege);
      emit(GetAllCustomerDataError(errorMsg: failure.errorMessege));
    }, (response) {
      emit(GetAllCustomerDataSuccess(
          customerData: response, selectedCustomer: response.first));
      customerData = response;
    });
  }

  void fetchCustomerDataByID({required String customerId}) async {
    final addCollectionControllers =
        ControllerManager().addCollectionControllers;
    emit(GetCustomerDataByIDInitial(controllers: addCollectionControllers));
    var either =
        await fetchCustomerDataByIDUseCase.invoke(customerId: customerId);

    either.fold((failure) {
      print(failure.errorMessege);
      emit(GetCustomerDataByIDError(errorMsg: failure.errorMessege));
    }, (customerDataEntity) async {
      PaymentValuesEntity paymentValuesEntity =
          await fetchPaymentValues(customerId: customerId);
      print("customer ID : $customerId");
      updateYearsOfPayment(paymentValuesEntity);
      print(years);
      ControllerManager().updateAddCollectionControllers(
        customerDataEntity: customerDataEntity,
        paymentValuesEntity: paymentValuesEntity,
      );
      selectedCustomer.idBl = customerDataEntity.idBl;
      emit(GetCustomerDataByIDSuccess(
          customerData: customerDataEntity,
          controllers: addCollectionControllers));
    });
  }

  void updateYearsOfPayment(PaymentValuesEntity paymentValuesEntity) {
    years = [
      {'year': "2020", 'isChecked': false},
      {'year': "2021", 'isChecked': false},
      {'year': "2022", 'isChecked': false},
      {'year': "2023", 'isChecked': false},
      {'year': "2024", 'isChecked': false},
    ];
    updateYearsList(
      paymentValuesEntity.yearsOfRepayment!,
    );
    years = updateCheckedStatus(
        years: years, paidYears: paymentValuesEntity.paidYears!);
  }

  Future<PaymentValuesEntity> fetchPaymentValues(
      {required String customerId}) async {
    var either = await fetchPaymentValuesUseCase.invoke(customerId: customerId);
    return either.fold(
        (failure) => Future.error(
            failure), // Handle the error case by returning a Future with an error
        (paymentValues) {
      print(paymentValues.yearsOfRepayment);
      return paymentValues;
    } // Handle the success case by returning a Future with the value
        );
  }

  Future<void> postTradeCollection({
    required String token,
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    emit(AddCollectionLoading());

    var either = await postTradeCollectionUseCase.invoke(
        token: token, tradeCollectionRequest: tradeCollectionRequest);

    either.fold((l) {
      emit(AddCollectionError(errorMsg: l.errorMessege));
    }, (r) {
      print("collection Id :$r");
      emit(AddCollectionSucces(tradeCollectionEntity: r));
    });
  }
}
