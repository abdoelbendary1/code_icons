import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
part 'add_collection_state.dart';

class AddCollectionCubit extends Cubit<AddCollectionState> {
  AddCollectionCubit({
    required this.fetchCustomerDataUseCase,
    required this.fetchCustomerDataByIDUseCase,
    required this.fetchPaymentValuesUseCase,
    required this.postTradeCollectionUseCase,
    required this.paymentValuesByIdUseCase,
/*     required this.receiptManager,
 */
  }) : super(GetAllCustomerDataInitial());
  FetchCustomerDataUseCase fetchCustomerDataUseCase;
  FetchCustomerDataByIDUseCase fetchCustomerDataByIDUseCase;
  FetchPaymentValuesUseCase fetchPaymentValuesUseCase;
  PostTradeCollectionUseCase postTradeCollectionUseCase;
  PostPaymentValuesByIdUseCase paymentValuesByIdUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /*  List<CustomerDataEntity> customerData = [
    CustomerDataEntity(),
  ]; */
  List<CustomerDataEntity> customerData = [];
/*   final ReceiptManager receiptManager;
 */
  late List<String> customersNames;
  //! check the selectedCustomer ID
  CustomerDataEntity selectedCustomer = CustomerDataEntity();
  String yearsOfRepaymentBL = '';
  late int paymentReceipt;

  TradeCollectionRequest intializeTradeRequest(
      {required CustomerDataEntity selectedCustomer,
      required BuildContext context}) {
    return TradeCollectionRequest(
      activityBl: double.tryParse(
          ControllerManager().addCollectionDivisionController.text),
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
      yearsOfRepaymentLstBL: /* context.read<AddCollectionCubit>(). */
          updatePaidYears(years),
    );
  }

  void fetchCustomerData() async {
    /* emit(GetAllCustomerDataInitial()); */
    emit(GetAllCustomerDataLoading());
    var either = await fetchCustomerDataUseCase.invoke();
    either.fold((failure) {
      print(failure.errorMessege);
      emit(GetAllCustomerDataError(errorMsg: failure.errorMessege));
    }, (response) {
      customersNames = response.map((e) => e.brandNameBl!).toList();
      emit(GetAllCustomerDataSuccess(
          customerData: response, selectedCustomer: response.first));
      customerData = response;
    });
  }

// Function to get registry numbers by id
  String getRegistryNumbersById(
      String id, List<CustomerDataEntity> customerData) {
    CustomerDataEntity? selectedCustomer;
    for (var customer in customerData) {
      if (customer.idBl.toString() == id) {
        selectedCustomer = customer;
        break;
      }
    }
    return selectedCustomer?.tradeRegistryBl ?? '';
  }

// Function to get CustomerDataEntity by tradeRegistryBl
  CustomerDataEntity? getCustomerByTradeRegistryBl(
      String tradeRegistryBl, List<CustomerDataEntity> customerData) {
    for (var customer in customerData) {
      if (customer.tradeRegistryBl == tradeRegistryBl) {
        selectedCustomer = customer;
        emit(GetCustomerDataByIDSuccess(
            customerData: selectedCustomer,
            controllers: ControllerManager().addCollectionControllers));
        return customer;
      }
    }
    return null; // Return null if not found
  }

  CustomerDataEntity getCustomerByName({required String name}) {
    return customerData.firstWhere((element) => element.brandNameBl == name);
  }

  void selectCustomer({required int id}) {
    final addCollectionControllers =
        ControllerManager().addCollectionControllers;
    emit(GetCustomerDataByIDInitial(controllers: addCollectionControllers));
  }

  void fetchCustomerDataByID({required String customerId}) async {
    final addCollectionControllers =
        ControllerManager().addCollectionControllers;
    emit(GetAllCustomerDataLoading());
    /*  emit(GetCustomerDataByIDInitial(controllers: addCollectionControllers)); */

    var either =
        await fetchCustomerDataByIDUseCase.invoke(customerId: customerId);

    either.fold((failure) {
      print(failure.errorMessege);
      emit(GetCustomerDataByIDError(errorMsg: failure.errorMessege));
    }, (customerDataEntity) async {
      PaymentValuesEntity paymentValuesEntity;
      Either<Failures, PaymentValuesEntity> either =
          await fetchPaymentValues(customerId: customerId);
      either.fold(
          (l) => emit(GetpaymentValuesByIDError(errorMsg: l.errorMessege)),
          (r) {
        paymentValuesEntity = r;
        updateYearsOfPayment(paymentValuesEntity);

/*       getSavedPaymentReceiept();
 */
        ControllerManager().updateAddCollectionControllers(
            customerDataEntity: customerDataEntity,
            paymentValuesEntity: paymentValuesEntity,
            payementReceipt: paymentReceipt);
        selectedCustomer.idBl = customerDataEntity.idBl;

        emit(GetCustomerDataByIDSuccess(
            customerData: customerDataEntity,
            controllers: addCollectionControllers));
      });
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
      yearsOfRepaymentBL = paidYears.join(",").toString();
      print('yearsOfRepaymentBL : ${yearsOfRepaymentBL}');
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
    if (paymentValuesEntity.paidYears!.isNotEmpty ||
        paymentValuesEntity.yearsOfRepayment!.trim().isNotEmpty) {
      updateYearsList(
        paymentValuesEntity.yearsOfRepayment!,
      );
      years = updateCheckedStatus(
          years: years, paidYears: paymentValuesEntity.paidYears!);
    } else {
      updateYearsList(
        DateTime.now().year.toString(),
      );
      years = updateCheckedStatus(years: years, paidYears: []);
    }
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

  Future<void> addReciet() async {
    try {
      var userBox = Hive.box('userBox');
      var receiptsBox = Hive.box('receiptsBox');

      // Retrieve user token
      String token = userBox.get('accessToken') ?? '';

      // Retrieve existing receipts list
      List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);
      RecietCollectionDataModel newReciept;
      // Create new receipt
      if (receipts.isNotEmpty) {
        newReciept = RecietCollectionDataModel(
            valid: true,
            id: receipts.last.id! + 1,
            paperNum: storedPaymentReceipt,
            totalPapers: 50);
      } else {
        newReciept = RecietCollectionDataModel(
            valid: true, id: 1, paperNum: 1, totalPapers: 50);
      }

      // Add new receipt to the list
      existingReceipts.add(newReciept.toJson());

      // Save the updated receipts list
      receiptsBox.put(token, existingReceipts);
      var storedPaymentReciet = await getPaymentReceipt();
      if (storedPaymentReciet == null) {
        await storePaymentReceipt(
            receipts.firstWhere((element) => element.valid == true).paperNum!);
      }
    } catch (e) {}
  }

  Future<RecietCollectionDataModel> selectReciet(int paymentReceipt) async {
    /*   return await ReceiptManager.selectReceipt(paymentReceipt); */
    try {
      for (var reciept in receipts) {
        if (reciept.paperNum! + reciept.totalPapers! > paymentReceipt) {
          reciept.valid = true;
        } else {
          reciept.valid = false;
        }
      }
      if (!receipts.any((element) => element.valid == true)) {
        addReciet();
      }
      /*  await getReciets(); */
      selectedReceit = receipts.firstWhere((receipt) => receipt.valid == true);
      /* await addReciet(); */
      return selectedReceit;
    } catch (e) {
      return receipts.last;
    }
  }
  /* RecietCollectionDataModel selectReciet(int paymentReceipt) {
    /*   return receiptManager.selectReceipt(paymentReceipt); */
    try {
      for (var reciept in receipts) {
        if (reciept.paperNum! + reciept.totalPapers! > paymentReceipt) {
          reciept.valid = true;
        } else {
          reciept.valid = false;
        }
      }
      /*   selectedReceit = receipts.firstWhere((receipt) =>
          paymentReceipt >= receipt.paperNum! &&
          paymentReceipt < receipt.paperNum! + receipt.totalPapers!); */
      selectedReceit = receipts.firstWhere((receipt) => receipt.valid == true);
      return selectedReceit;
    } catch (e) {
      /*  emit(RecietSelectionError(errorMsg: "No matching receipt found.")); */
      var newReciept = RecietCollectionDataModel(
          valid: true,
          id: receipts.last.id! + 1,
          paperNum: receipts.last.paperNum! + 1,
          totalPapers: 20);
      receipts.add(newReciept);
      return newReciept;
    }
  } */

  /*  late int paymentReceipt; */
  Future<void> storePaymentReceipt(int receipt) async {
    /*  await receiptManager.storePaymentReceipt(receipt); */
    var userBox = Hive.box('userBox');
    userBox.put('paymentReceipt', receipt);
  }

  Future<int?> getPaymentReceipt() async {
    /*  return await receiptManager.getPaymentReceipt(); */
    var userBox = Hive.box('userBox');
    return userBox.get('paymentReceipt');
  }

  RecietCollectionDataModel? selectNextReciet(int currentPaymentReceipt) {
    for (var receipt in receipts) {
      if (currentPaymentReceipt > receipt.paperNum! &&
          currentPaymentReceipt < receipt.paperNum! + receipt.totalPapers!) {
        selectedReceit = receipt;
        return selectedReceit;
      }
    }
    return null;
  }

  Future<void> incrementPaymentReceipt() async {
/*     await receiptManager.incrementPaymentReceipt();
 */
    int? storedPaymentReceipt = await getPaymentReceipt();
    if (storedPaymentReceipt != null) {
      paymentReceipt = storedPaymentReceipt + 1;
      /*  if (paymentReceipt >=
          selectedReceit.paperNum! + selectedReceit.totalPapers!) {
        // Select another receipt
        int? newPaymentReceipt = selectNextReciet(paymentReceipt);
        if (newPaymentReceipt != null) {
          paymentReceipt = newPaymentReceipt;
        } else {
          // Handle case where no more receipts are available
          return;
        }
      } */
      await storePaymentReceipt(paymentReceipt);
      ControllerManager()
          .getControllerByName('addCollectionPaymentReceitController')
          .text = paymentReceipt.toString();
    } else {
      // Initialize with the selected receipt's paper number if no payment receipt is stored
      paymentReceipt = selectedReceit.paperNum!;
      await storePaymentReceipt(paymentReceipt);
      ControllerManager()
          .getControllerByName('addCollectionPaymentReceitController')
          .text = paymentReceipt.toString();
    }
  }

  Future<List<RecietCollectionDataModel>> getReciets() async {
/*     return await receiptManager.getReceipts();
 */
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    String token = userBox.get('accessToken') ?? '';

    List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);

    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();

    return receipts;
  }

  int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();
  Future<void> initialize({required controller}) async {
    await getReciets();
    if (storedPaymentReceipt == null && receipts.isEmpty) {
      await storePaymentReceipt(1);
    }

    if (receipts.isNotEmpty) {
      storedPaymentReceipt = await getPaymentReceipt();

      if (storedPaymentReceipt == null) {
        await storePaymentReceipt(1);
        storedPaymentReceipt = await getPaymentReceipt();
      }

      selectedReceit = await selectReciet(storedPaymentReceipt!);
      if (storedPaymentReceipt != null) {
        if (selectedReceit.valid!) {
          if (storedPaymentReceipt! <
                  selectedReceit.paperNum! + selectedReceit.totalPapers! &&
              storedPaymentReceipt! > selectedReceit.paperNum!) {
            paymentReceipt = storedPaymentReceipt!;
            await storePaymentReceipt(paymentReceipt);
          } else if (storedPaymentReceipt! < selectedReceit.paperNum!) {
            paymentReceipt = selectedReceit.paperNum!;
            await storePaymentReceipt(paymentReceipt);
          } else {
            selectedReceit = await selectReciet(storedPaymentReceipt!);
            paymentReceipt = selectedReceit.paperNum!;

            await storePaymentReceipt(paymentReceipt);
            if (storedPaymentReceipt! < selectedReceit.paperNum!) {
              selectedReceit = await selectReciet(storedPaymentReceipt!);

              paymentReceipt = selectedReceit.paperNum!;
              await storePaymentReceipt(paymentReceipt);
            } else {
              selectedReceit = await selectReciet(storedPaymentReceipt!);

              paymentReceipt = storedPaymentReceipt!;
              await storePaymentReceipt(paymentReceipt);
            }
          }
        } else {
          await getReciets();
          selectedReceit = await selectReciet(storedPaymentReceipt!);
          paymentReceipt = selectedReceit.paperNum!;
          updateController();
        }
      } else {
        selectedReceit = receipts.firstWhere(
          (element) => element.valid == true,
          orElse: () => RecietCollectionDataModel(
              id: 0, paperNum: 0, totalPapers: 0, valid: false),
        );
        if (selectedReceit.id != 0) {
          paymentReceipt = selectedReceit.paperNum!;
          await storePaymentReceipt(paymentReceipt);
        }
      }
      updateController();
    } else {
      await storePaymentReceipt(1);
      await addReciet();
      receipts = await getReciets();
      selectedReceit = receipts.firstWhere(
        (element) => element.valid == true,
        orElse: () => RecietCollectionDataModel(
            id: 0, paperNum: 0, totalPapers: 0, valid: false),
      );
      if (selectedReceit.id != 0) {
        paymentReceipt = selectedReceit.paperNum!;
        await storePaymentReceipt(paymentReceipt);
      }
      updateController();
    }
  }

  void updateController() {
    ControllerManager()
        .getControllerByName('addCollectionPaymentReceitController')
        .text = paymentReceipt.toString();
  }

  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValues(
      {required String customerId}) async {
    var either = await fetchPaymentValuesUseCase.invoke(customerId: customerId);
    return either.fold((failure) {
      emit(GetCustomerDataByIDError(errorMsg: failure.errorMessege));
      return Left(failure);
    }, // Handle the error case by returning a Future with an error
        (paymentValues) {
      return right(paymentValues);
    } // Handle the success case by returning a Future with the value
        );
  }

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
          await incrementPaymentReceipt();
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
            payementReceipt: paymentReceipt);
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
        QuickAlert.show(
          showCancelBtn: true,
          cancelBtnText: "رجوع",
          context: context,
          type: QuickAlertType.error,
          confirmBtnColor: AppColors.greenColor,
          title:
              AppLocalizations.of(context)!.snackBar_error_year_of_payment_pay,
          titleColor: AppColors.redColor,
          confirmBtnText: AppLocalizations.of(context)!
              .snackBar_label_year_of_payment_pay_action,
          onConfirmBtnTap: () {
            markAllYearsAsPaid(index);
            List<int> paidYears =
                updatePaidYears(context.read<AddCollectionCubit>().years);

            if (paidYears.isNotEmpty) {
              postPaymentValuesByID(
                customerId:
                    context.read<AddCollectionCubit>().selectedCustomer.idBl,
                paidYears: paidYears,
              );
              Navigator.pop(context);
            }
          },
        );
        // Show SnackBar if previous years are not paid
        /*  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            action: SnackBarAction(
              label: AppLocalizations.of(context)!
                  .snackBar_label_year_of_payment_pay_action,
              textColor: AppColors.whiteColor,
              backgroundColor: AppColors.greenColor,
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
            backgroundColor: AppColors.lightBlueColor,
            content: Text(
              AppLocalizations.of(context)!.snackBar_error_year_of_payment_pay,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
       */
      }
    } else {
      // When marking a year as unpaid
      if (anyForwardYearsChecked(index)) {
        // Show SnackBar if forward years are paid
        QuickAlert.show(
          showCancelBtn: true,
          cancelBtnText: "رجوع",
          context: context,
          type: QuickAlertType.info,
          confirmBtnColor: AppColors.greenColor,
          title: "هل تريد وضع علامة على هذه السنة كغير مدفوعة؟",
          text: "سيتم حذف السنين المدفوعه بعد هذه السنه",
          titleAlignment: TextAlign.center,
          textAlignment: TextAlign.center,
          textColor: AppColors.greyColor,
          titleColor: AppColors.redColor,
          confirmBtnText: "نعم",
          onConfirmBtnTap: () {
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
/*                   getSavedPaymentReceiept();
 */
              ControllerManager().updateAddCollectionControllers(
                  customerDataEntity:
                      context.read<AddCollectionCubit>().selectedCustomer,
                  payementReceipt: 0,
                  paymentValuesEntity: emptyPaymentValues);
            }
            Navigator.pop(context);
          },
        );
        /*  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: "تأكيد الإلغاء",
              textColor: AppColors.whiteColor,
              backgroundColor: AppColors.lightRedColor,
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
       */
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
