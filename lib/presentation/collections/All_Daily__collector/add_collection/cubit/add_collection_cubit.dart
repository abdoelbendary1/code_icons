import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/request/trade_collection_request.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/fetch_paymnetValues.dart';
import 'package:code_icons/domain/use_cases/post-payment_values_by_ID_usecase.dart';
import 'package:code_icons/domain/use_cases/post_trade_collection_use_case.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_collection_state.dart';

class AddCollectionCubit extends Cubit<AddCollectionState> {
  AddCollectionCubit({
    required this.fetchCustomerDataUseCase,
    required this.fetchCustomerDataByIDUseCase,
    required this.fetchPaymentValuesUseCase,
    required this.postTradeCollectionUseCase,
    required this.paymentValuesByIdUseCase,
  }) : super(GetAllCustomerDataInitial());
  FetchCustomerDataUseCase fetchCustomerDataUseCase;
  FetchCustomerDataByIDUseCase fetchCustomerDataByIDUseCase;
  FetchPaymentValuesUseCase fetchPaymentValuesUseCase;
  PostTradeCollectionUseCase postTradeCollectionUseCase;
  PostPaymentValuesByIdUseCase paymentValuesByIdUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<CustomerDataEntity> customerData = [
    CustomerDataEntity(),
  ];
  //! check the selectedCustomer ID
  CustomerDataEntity selectedCustomer = CustomerDataEntity();
  String yearsOfRepaymentBl = "";

  TradeCollectionRequest intializeTradeRequest(
      {required CustomerDataEntity selectedCustomer,
      required BuildContext context}) {
    return TradeCollectionRequest(
      activityBl: 4.0,
      addressBl: ControllerManager().addCollectionAddressController.text,
      collectionDateBl:
          ControllerManager().addCollectionRegistryDateController.text,
      compensationBl: double.tryParse(
          ControllerManager().addCollectionCompensationController.text),
      currentBl: double.tryParse(
          ControllerManager().addCollectionCurrentFinanceController.text),
      customerDataIdBl: selectedCustomer.idBl,
      differentBl: double.tryParse(
          ControllerManager().addCollectionDiffrentFinanaceController.text),
      divisionBl: ControllerManager().addCollectionDivisionController.text,
      lateBl: double.tryParse(
          ControllerManager().addCollectionLateFinanceController.text),
      paymentReceiptNumBl: int.tryParse(
          ControllerManager().addCollectionPaymentReceitController.text),
      phoneBl: ControllerManager().addCollectionPhoneNumController.text,
      totalBl: double.tryParse(
          ControllerManager().addCollectionTotalFinanceController.text),
      tradeRegistryBl:
          ControllerManager().addCollectionRegisrtyNumController.text,
      yearsOfRepaymentBl: context.read<AddCollectionCubit>().yearsOfRepaymentBl,
    );
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
/*       getSavedPaymentReceiept();
 */
      print(years);
      ControllerManager().updateAddCollectionControllers(
          customerDataEntity: customerDataEntity,
          paymentValuesEntity: paymentValuesEntity,
          payementReceipt: 0);
      selectedCustomer.idBl = customerDataEntity.idBl;

      emit(GetCustomerDataByIDSuccess(
          customerData: customerDataEntity,
          controllers: addCollectionControllers));
    });
  }

  List<Map<String, dynamic>> years = [
    /* {'year': "2020", 'isPaid': false},
      {'year': "2021", 'isPaid': false},
      {'year': "2022", 'isPaid': false},
      {'year': "2023", 'isPaid': false}, */
    {'year': DateTime.now().year.toString(), 'isPaid': false},
  ];

  List<int> updatePaidYears(List<Map<String, dynamic>> years) {
    List<int> paidYears = [];
    for (var element in years) {
      if (element['isPaid'] == true) {
        paidYears.add(int.parse(element['year']));
      }
      yearsOfRepaymentBl = paidYears.join();
      print('paid years join : ${paidYears.join()}');
    }
    return paidYears;
  }

  List<Map<String, dynamic>> updateCheckedStatus(
      {required List<Map<String, dynamic>> years,
      required List<dynamic> paidYears}) {
    if (paidYears.isNotEmpty) {
      for (var year in years) {
        if (paidYears.contains(int.parse(year['year']))) {
          year['isPaid'] = true;
        }
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
        Map<String, dynamic> yearsMap = {'year': year.trim(), 'isPaid': false};
        years.add(yearsMap);
      });
    } else {
      years.clear();
    }
  }

  void updateYearsOfPayment(PaymentValuesEntity paymentValuesEntity) {
    years = [
      /* {'year': "2020", 'isPaid': false},
      {'year': "2021", 'isPaid': false},
      {'year': "2022", 'isPaid': false},
      {'year': "2023", 'isPaid': false}, */
      {'year': DateTime.now().year.toString(), 'isPaid': false},
    ];
    updateYearsList(
      paymentValuesEntity.yearsOfRepayment!,
    );
    years = updateCheckedStatus(
        years: years,
        paidYears: paymentValuesEntity.paidYears ?? [] as dynamic);
  }

  void toggleYearSelection(int index, bool isSelected) {
    if (allPreviousYearsChecked(index)) {
      years[index]['isPaid'] = isSelected;

      for (int i = index + 1; i < years.length; i++) {
        years[i]['isPaid'] = false;
      }

      emit(YearsUpdatedState(years: List.from(years)));
    } else {
      // Feedback to UI should be handled in the onSelected function
    }
  }

  bool anyForwardYearsChecked(int index) {
    return years.sublist(index + 1).any((year) => year['isPaid'] == true);
  }

  bool allPreviousYearsChecked(int index) {
    for (int i = 0; i < index; i++) {
      if (!years[i]['isPaid']) {
        return false;
      }
    }
    return true;
  }

  void markAllYearsAsPaid(int upToIndex) {
    for (int i = 0; i <= upToIndex; i++) {
      years[i]['isPaid'] = true;
    }

    emit(YearsUpdatedState(years: List.from(years)));
  }

  Future<PaymentValuesEntity> fetchPaymentValues(
      {required String customerId}) async {
    var either = await fetchPaymentValuesUseCase.invoke(customerId: customerId);
    return either.fold(
        (failure) => Future.error(
            failure), // Handle the error case by returning a Future with an error
        (paymentValues) {
      return paymentValues;
    } // Handle the success case by returning a Future with the value
        );
  }

  /*  Future<List<RecietCollectionDataModel>> getReciets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';

    String? existingReceiptsMap = prefs.getString('receiptsMap');
    if (existingReceiptsMap != null) {
      Map<String, List<dynamic>> receiptsMap =
          Map<String, List<dynamic>>.from(json.decode(existingReceiptsMap));
      List<dynamic> existingReceipts = receiptsMap[token] ?? [];

      var receipts = existingReceipts
          .map((i) => RecietCollectionDataModel.fromJson(i))
          .toList();

      if (receipts.isNotEmpty) {
/*         lastRecietCollection = receipts.last;
 */
      }
      emit(GetAllCustomerDataSuccess(receipts: receipts));
/*       emit(GetRecietCollctionSuccess(reciets: receipts));
 */
      return receipts;
    } else {
/*       emit(GetRecietCollctionError(errorMsg: "لا يوجد ايصالات حاليا"));
 */
      return [];
    }
  }

  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();

  // Function to select a receipt based on the conditions

  void selectReceitBasedOnConditions(List<RecietCollectionDataModel> receipts) {
    for (var receipt in receipts) {
      if (paymentReceipt >= selectedReceit.paymentReceipt! &&
          paymentReceipt <
              selectedReceit.paperNum! + selectedReceit.totalPapers!) {
        selectedReceit = receipt;
        break;
      }
    }
  } // Function to set paymentReceipt to selectedReceit's paperNum and save it locally

  // Function to save the selected receipt to local storage
  Future<void> saveSelectedReceit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedReceit', json.encode(selectedReceit.toJson()));
  }

// Function to retrieve the selected receipt from local storage
  Future<void> retrieveSelectedReceit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedReceitJson = prefs.getString('selectedReceit');
    if (selectedReceitJson != null) {
      selectedReceit =
          RecietCollectionDataModel.fromJson(json.decode(selectedReceitJson));
    } else {
      selectedReceit = RecietCollectionDataModel();
    }
  }

  late int paymentReceipt = 1;
  Future<void> getSavedPaymentReceiept() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    paymentReceipt = prefs.getInt('paymentReceipt') ?? 0;
  }

  Future<void> increasePaymentReceiptAndSave() async {
    paymentReceipt += 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('paymentReceipt', paymentReceipt);
  }
 */
  Future<void> postTradeCollection({
    required String token,
    required TradeCollectionRequest tradeCollectionRequest,
    required BuildContext context,
  }) async {
    try {
      emit(AddCollectionLoading());
      if (formKey.currentState!.validate()) {
        var either = await postTradeCollectionUseCase.invoke(
            token: token, tradeCollectionRequest: tradeCollectionRequest);

        either.fold((l) {
          emit(AddCollectionError(errorMsg: l.errorMessege));
        }, (r) async {
          emit(AddCollectionSucces(tradeCollectionEntity: r));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "برجاء ادخال جميع البيانات",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: AppColors.redColor,
          duration: Durations.extralong1,
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<RecietCollectionDataModel> receipts = [];

  void postPaymentValuesByID({int? customerId, List<int>? paidYears}) async {
    if (paidYears!.isNotEmpty) {
      var either = await paymentValuesByIdUseCase.invoke(
          customerId: customerId, paidYears: paidYears);

      either.fold(
          (l) => Left(emit(GetCustomerDataByIDError(errorMsg: l.errorMessege))),
          (r) {
        /*   getReciets();
        selectReceitBasedOnConditions(receipts);
        saveSelectedReceit();
        retrieveSelectedReceit();
        getSavedPaymentReceiept(); */
        ControllerManager().updateAddCollectionControllers(
            customerDataEntity: selectedCustomer,
            paymentValuesEntity: r,
            payementReceipt: 0);
        emit(GetCustomerDataByIDSuccess(
            customerData: selectedCustomer,
            controllers: ControllerManager().addCollectionControllers));
      });
    }
  }

  void handleYearSelection(BuildContext context, int index, bool value) {
    if (value) {
      // When marking a year as paid
      if (allPreviousYearsChecked(index)) {
        toggleYearSelection(index, value);
        List<int> paidYears =
            updatePaidYears(context.read<AddCollectionCubit>().years);

        if (paidYears.isNotEmpty) {
          postPaymentValuesByID(
            customerId:
                context.read<AddCollectionCubit>().selectedCustomer.idBl,
            paidYears: paidYears,
          );
        } else {
          var emptyPaymentValues = PaymentValuesEntity(
              compensation: 0,
              current: 0,
              different: 0,
              late: 0,
              paidYears: [],
              total: 0,
              yearsOfRepayment: "");
/*           getSavedPaymentReceiept();
 */
          ControllerManager().updateAddCollectionControllers(
              customerDataEntity:
                  context.read<AddCollectionCubit>().selectedCustomer,
              paymentValuesEntity: emptyPaymentValues,
              payementReceipt: 0);
        }
      } else {
        // Show SnackBar if previous years are not paid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: AppLocalizations.of(context)!
                  .snackBar_label_year_of_payment_pay_action,
              textColor: AppColors.whiteColor,
              backgroundColor: AppColors.lightBlueColor,
              onPressed: () {
                markAllYearsAsPaid(index);
                List<int> paidYears =
                    updatePaidYears(context.read<AddCollectionCubit>().years);

                if (paidYears.isNotEmpty) {
                  postPaymentValuesByID(
                    customerId: context
                        .read<AddCollectionCubit>()
                        .selectedCustomer
                        .idBl,
                    paidYears: paidYears,
                  );
                }
              },
            ),
            duration: const Duration(milliseconds: 2000),
            backgroundColor: AppColors.blueColor,
            content: Text(
              AppLocalizations.of(context)!.snackBar_error_year_of_payment_pay,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
      }
    } else {
      // When marking a year as unpaid
      if (anyForwardYearsChecked(index)) {
        // Show SnackBar if forward years are paid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: "تأكيد الإلغاء",
              textColor: AppColors.whiteColor,
              backgroundColor: AppColors.lightBlueColor,
              onPressed: () {
                toggleYearSelection(index, value);
                List<int> paidYears =
                    updatePaidYears(context.read<AddCollectionCubit>().years);

                if (paidYears.isNotEmpty) {
                  postPaymentValuesByID(
                    customerId: context
                        .read<AddCollectionCubit>()
                        .selectedCustomer
                        .idBl,
                    paidYears: paidYears,
                  );
                } else {
                  var emptyPaymentValues = PaymentValuesEntity(
                      compensation: 0,
                      current: 0,
                      different: 0,
                      late: 0,
                      paidYears: [],
                      total: 0,
                      yearsOfRepayment: "");
/*                   getSavedPaymentReceiept();
 */
                  ControllerManager().updateAddCollectionControllers(
                      customerDataEntity:
                          context.read<AddCollectionCubit>().selectedCustomer,
                      payementReceipt: 0,
                      paymentValuesEntity: emptyPaymentValues);
                }
              },
            ),
            duration: const Duration(milliseconds: 2000),
            backgroundColor: AppColors.blueColor,
            content: Text(
              "هل تريد وضع علامة على هذه السنة كغير مدفوعة؟",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
      } else {
        toggleYearSelection(index, value);
        List<int> paidYears =
            updatePaidYears(context.read<AddCollectionCubit>().years);

        if (paidYears.isNotEmpty) {
          postPaymentValuesByID(
            customerId:
                context.read<AddCollectionCubit>().selectedCustomer.idBl,
            paidYears: paidYears,
          );
        } else {
          var emptyPaymentValues = PaymentValuesEntity(
              compensation: 0,
              current: 0,
              different: 0,
              late: 0,
              paidYears: [],
              total: 0,
              yearsOfRepayment: "");
/*           getSavedPaymentReceiept();
 */
          ControllerManager().updateAddCollectionControllers(
              customerDataEntity:
                  context.read<AddCollectionCubit>().selectedCustomer,
              payementReceipt: 0,
              paymentValuesEntity: emptyPaymentValues);
        }
      }
    }
  }
}
