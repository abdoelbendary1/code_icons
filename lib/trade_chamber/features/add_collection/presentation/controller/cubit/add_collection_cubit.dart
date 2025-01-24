import 'package:code_icons/data/api/tradeChamber/customers/customers_manager.dart';
import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/services/service_locator.dart';
import 'package:code_icons/trade_chamber/core/utils/auth_utils.dart';
import 'package:code_icons/trade_chamber/core/utils/date_utils.dart';
import 'package:code_icons/trade_chamber/core/utils/parse_utils.dart';
import 'package:code_icons/trade_chamber/features/show_all_reciepts/presentation/controller/ReceiptManager%20.dart';
import 'package:code_icons/trade_chamber/features/show_all_reciepts/presentation/view/all_reciets.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/trade_chamber/core/services/alert_service/alert_service.dart';
import 'package:code_icons/trade_chamber/features/add_collection/domain/use_case/add_collection_use_case.dart';
import 'package:code_icons/trade_chamber/view/collections_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_request.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/fetch_paymnetValues.dart';
import 'package:code_icons/domain/use_cases/post-payment_values_by_ID_usecase.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  CustomersManager customersManager = CustomersManager(
    authManager: injectAuthManagerInterface(),
    httpRequestHelper: injectHttpRequestHelper(),
    handleResponseHelper: injectHandleResponseHelper(),
  );
  Map<String, String> dateStorageMap = {
    'addCollectionPaymentReceitController': '',
  };
  ReceiptManager receiptManager = getIt<ReceiptManager>();
  final FocusNode divisionFocusNode = FocusNode();
  final FocusNode diffrentFocusNode = FocusNode();
  List<CustomerDataEntity> customerData = [];
  List<CustomerDataEntity> filteredData = [];
  OverlayPortalController overlayPortalNameController =
      OverlayPortalController();
  OverlayPortalController overlayPortalRegistryController =
      OverlayPortalController();
  ControllerManager controllerManager = getIt<ControllerManager>();
  late List<String> customersNames;
  //! check the selectedCustomer ID
  CustomerDataEntity selectedCustomer = CustomerDataEntity();
  String yearsOfRepaymentBL = '';
  late int paymentReceipt;
  final ScrollController scrollController = ScrollController();
  List<CustomerDataEntity> customers = [];
  int skip = 0;
  final int take = 20;
  bool isLoading = false;
  bool hasMoreData = true;
  String searchQuery = '';
  late PaymentValuesEntity paymentValuesEntity;
  bool isButtonEnabled = true; // Initial state
  List<int> paidYears = [];
  int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  late RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();
  List<Map<String, dynamic>> years = [
    {'year': DateTime.now().year.toString(), 'isPaid': false},
  ];
  static AddCollectionCubit initializeCubit() {
    return AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase(),
    );
  }

  void handleErrorState(BuildContext context, dynamic state,
      AddCollectionCubit addCollectionCubit) {
    // Use a Set to collect unique error messages
    Set<String> errorMessages = {};

    if (state is GetAllCustomerDataError) {
      addCollectionCubit.isLoading = false;
      addCollectionCubit.hasMoreData = false;
      errorMessages.add(state.errorMsg); // Add error to the Set
    } else if (state is GetCustomerDataByIDError) {
      errorMessages.add(state.errorMsg); // Add error to the Set
    } else if (state is AddCollectionError) {
      errorMessages.add(state.errorMsg); // Add error to the Set
    } else if (state is GetRecieptError) {
      AlertService.showError(
        context: context,
        showConfirmBtn: true,
        showCancelBtn: true,
        cancelBtnText: "رجوع",
        confirmBtnText: "اضافة دفتر",
        errorMsg: state.errorMsg,
        onCancelBtnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
          Navigator.pushNamed(context, AllRecietsScreen.routeName);
        },
      );
    }

    // Display unique errors in a single alert if there are any
    if (errorMessages.isNotEmpty) {
      AlertService.showError(
        context: context,
        errorMsg: errorMessages
            .join('\n'), // Combine unique errors into a single message
      );
    }
  }

  void handleSuccessStates(
      BuildContext context, dynamic state, AddCollectionCubit cubit) {
    // Use a Set to collect unique error messages
    Set<String> successMessages = {};

    if (state is GetAllCustomerDataSuccess) {
      cubit.customerData = state.customerData!;
      cubit.receipts = state.receipts ?? [];
      cubit.skip += cubit.take;
      cubit.customerData = List.from(cubit.customerData)
        ..addAll(state.customerData!);
      cubit.hasMoreData = state.customerData!.length == cubit.take;
      cubit.isLoading = false;
    } else if (state is AddCollectionSucces) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
      Navigator.pushNamed(
        context,
        CollectionsScreen.routeName,
        arguments:
            context.read<HomeScreenViewModel>().menus['collections']?.items,
      );
      AlertService.showSuccess(
        context: context,
        successMsg: "تمت العملية بنجاح",
      );
    }

    // Display unique errors in a single alert if there are any
    /* if (successMessages.isNotEmpty) {
      AlertService.showSuccess(
        onConfirmBtnTap: () {},
        context: context,
        successMsg: successMessages
            .join('\n'), // Combine unique errors into a single message
      );
    } */
  }

  TradeCollectionRequest initializeTradeRequest({
    required CustomerDataEntity selectedCustomer,
  }) {
    return TradeCollectionRequest(
      activityBl:
          parseDouble(controllerManager.addCollectionDivisionController.text),
      addressBl: controllerManager.addCollectionAddressController.text.trim(),
      compensationBl: parseDouble(
          controllerManager.addCollectionCompensationController.text),
      currentBl: parseDouble(
          controllerManager.addCollectionCurrentFinanceController.text),
      customerDataIdBl: selectedCustomer.idBl,
      differentBl: parseDouble(
          controllerManager.addCollectionDiffrentFinanaceController.text),
      divisionBl: controllerManager.addCollectionDivisionController.text.trim(),
      lateBl: parseDouble(
          controllerManager.addCollectionLateFinanceController.text),
      paymentReceiptNumBl:
          parseInt(controllerManager.addCollectionPaymentReceitController.text),
      phoneBl: controllerManager.addCollectionPhoneNumController.text.trim(),
      totalBl: parseDouble(
          controllerManager.addCollectionTotalFinanceController.text),
      tradeRegistryBl:
          controllerManager.addCollectionRegisrtyNumController.text.trim(),
      collectionDateBl: convertStringToDate(
          inputString:
              controllerManager.addCollectionRegistryDateController.text),
      yearsOfRepaymentLstBL: updatePaidYears(years),
    );
  }

  Future<void> addRegisteredCollection({
    required GlobalKey<FormState> formKey,
    required TradeCollectionRequest Function() initializeTradeRequest,
    void Function(String message)? showError,
    VoidCallback? onSuccess,
  }) async {
    if (!isButtonEnabled) return;

    try {
      // Check if years of repayment are provided
      if (yearsOfRepaymentBL.isEmpty) {
        showError?.call("يجب اضافه سنوات السداد");
        return;
      }

      // Validate form inputs
      if (!formKey.currentState!.validate()) {
        showError?.call("برجاء ادخال جميع البيانات");
        return;
      }

      // Prepare the trade collection request
      final tradeCollectionRequest = initializeTradeRequest();

      if (tradeCollectionRequest.paymentReceiptNumBl == null) {
        showError?.call("برجاء المحاولة مرة اخرى");
        return;
      }

      isButtonEnabled = false;

      // Perform the API call or business logic
      await postTradeCollection(tradeCollectionRequest: tradeCollectionRequest);

      // Trigger success callback
      onSuccess?.call();
    } catch (e) {
      showError?.call("An error occurred: $e");
    } finally {
      isButtonEnabled = true;
    }
  }

  void recalculateTotal(PaymentValuesEntity paymentValuesEntity) {
    // Step 2: Override values with the current text values from the controllers
    double updatedActivity = double.tryParse(
            controllerManager.addCollectionDivisionController.text) ??
        paymentValuesEntity.activity ??
        0;

    double updatedDifferent = double.tryParse(
            controllerManager.addCollectionDiffrentFinanaceController.text) ??
        paymentValuesEntity.different ??
        0;

    // Step 3: Recalculate the total using the updated values
    paymentValuesEntity.total = updatedActivity +
        (double.tryParse(
                controllerManager.addCollectionCurrentFinanceController.text) ??
            0) +
        (double.tryParse(
                controllerManager.addCollectionCompensationController.text) ??
            0) +
        (double.tryParse(
                controllerManager.addCollectionLateFinanceController.text) ??
            0) +
        updatedDifferent +
        (double.tryParse(
                controllerManager.addCollectionLatePayController.text) ??
            0) -
        (double.tryParse(
                controllerManager.addCollectionAdvPayController.text) ??
            0);

    // Step 4: Update the total in the total finance controller
    controllerManager.addCollectionTotalFinanceController.text =
        paymentValuesEntity.total?.toStringAsFixed(2) ?? "0.00";
  }

  Future<void> loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    emit(GetAllCustomerDataLoading());

    try {
      final either = await fetchCustomerDataUseCase.fetchCustomerData(
          skip: skip, take: take, filter: "محمد");
      either.fold(
          (l) => emit(GetAllCustomerDataError(errorMsg: "No more data")), (r) {
        customers.addAll(r);
        hasMoreData = r.length == take;
        skip += take;
        isLoading = false;

        emit(GetAllCustomerDataSuccess(customerData: customers));
      });
    } catch (e) {
      emit(GetAllCustomerDataError(errorMsg: e.toString()));
      isLoading = false;
      hasMoreData = false;
    }
  }

  void initializePagination() {
    scrollController.addListener(onScroll);
    loadMoreCustomers();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMoreData) {
      loadMoreCustomers(filter: searchQuery);
    }
  }

  Future<List<CustomerDataEntity>> fetchCustomerDataPages({
    required int skip,
    required int take,
    String? filter,
  }) async {
    var either = await fetchCustomerDataUseCase.fetchCustomerData(
      skip: skip,
      take: take,
      filter: filter,
    );

    // Handle the result
    return either.fold((failure) {
      throw Exception(failure.errorMessege);
    }, (response) {
      customerData = response;
      return response; // Return the fetched data
    });
  }

  void fetchCustomerDataByID({required String customerId}) async {
    final addCollectionControllers = controllerManager.addCollectionControllers;
/*     emit(GetAllCustomerDataLoading());
 */
    emit(GetCustomerDataByIDLoading());

    var either =
        await fetchCustomerDataByIDUseCase.invoke(customerId: customerId);

    either.fold((failure) {
      emit(GetCustomerDataByIDError(errorMsg: failure.errorMessege));
    }, (customerDataEntity) async {
      Either<Failures, PaymentValuesEntity> either =
          await fetchPaymentValues(customerId: customerId);
      either.fold(
          (l) => emit(GetpaymentValuesByIDError(errorMsg: l.errorMessege)),
          (r) {
        paymentValuesEntity = r;
        updateYearsOfPayment(paymentValuesEntity);

/*       getSavedPaymentReceiept();
 */
        controllerManager.updateAddCollectionControllers(
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

  List<int> updatePaidYears(List<Map<String, dynamic>> years) {
    List<int> paidYears = [];

    for (var element in years) {
      if (element['isPaid'] == true) {
        paidYears.add(int.parse(element['year']));
      }
      yearsOfRepaymentBL = paidYears.join(",").toString();
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
      {'year': DateTime.now().year.toString(), 'isPaid': false},
    ];
    if (paymentValuesEntity.paidYears!.isNotEmpty ||
        paymentValuesEntity.yearsOfRepayment!.trim().isNotEmpty) {
      updateYearsList(
        paymentValuesEntity.yearsOfRepayment!,
      );
      years = updateCheckedStatus(
          years: years, paidYears: paymentValuesEntity.paidYears!);
      paidYears = updatePaidYears(years);
      print(years);
    } else {
      updateYearsList(
        DateTime.now().year.toString(),
      );
      years = updateCheckedStatus(years: years, paidYears: []);
    }
  }

  void toggleYearSelection(int index, bool isSelected) {
    // Update the selected year's isPaid status
    years[index]['isPaid'] = isSelected;

    // Emit the updated state to reflect changes
    emit(YearsUpdatedState(years: List.from(years)));
  }

  Future<RecietCollectionDataModel> selectReciet(int paymentReceipt) async {
    try {
      receipts = await getReciets();
      for (var reciept in receipts) {
        if (reciept.paperNum! + reciept.totalPapers! > paymentReceipt) {
          reciept.valid = true;
        } else {
          reciept.valid = false;
        }
      }
      if (!receipts.any((element) => element.valid == true)) {
        await receiptManager.addReciet(
            receipts: receipts, storedPaymentReceipt: paymentReceipt);
      }
      /*  await getReciets(); */
      selectedReceit = receipts.firstWhere((receipt) => receipt.valid == true);
      /* await addReciet(); */
      return selectedReceit;
    } catch (e) {
      print(e.toString());
      return receipts.last;
    }
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
    int userId = await AuthUtils().getUserId();
    int? storedPaymentReceipt =
        await receiptManager.getPaymentReceipt(userId: userId);
    if (storedPaymentReceipt != null) {
      paymentReceipt = storedPaymentReceipt + 1;

      await receiptManager.storePaymentNumber(
          receipt: paymentReceipt, userId: userId);
      controllerManager
          .getControllerByName('addCollectionPaymentReceitController')
          .text = paymentReceipt.toString();
    } else {
      // Initialize with the selected receipt's paper number if no payment receipt is stored
      paymentReceipt = selectedReceit.paperNum!;
      await receiptManager.storePaymentNumber(
          receipt: paymentReceipt, userId: userId);
      controllerManager
          .getControllerByName('addCollectionPaymentReceitController')
          .text = paymentReceipt.toString();
    }
  }

  Future<List<RecietCollectionDataModel>> getReciets() async {
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    AuthRepoEntity? user = userBox.get('user');
    int userID = user!.id!;

    List<dynamic> existingReceipts = receiptsBox.get(userID, defaultValue: []);

    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();

    return receipts;
  }

  Future<void> initialize({required BuildContext context}) async {
    try {
      await getReciets();
      int userId = await AuthUtils().getUserId();
      if (storedPaymentReceipt == null && receipts.isEmpty) {
        await receiptManager.storePaymentNumber(receipt: 1, userId: userId);
      }

      if (receipts.isNotEmpty) {
        storedPaymentReceipt =
            await receiptManager.getPaymentReceipt(userId: userId);

        if (storedPaymentReceipt == null) {
          await receiptManager.storePaymentNumber(receipt: 1, userId: userId);
          storedPaymentReceipt =
              await receiptManager.getPaymentReceipt(userId: userId);
        }

        selectedReceit = await selectReciet(storedPaymentReceipt!);
        if (storedPaymentReceipt != null) {
          if (selectedReceit.valid!) {
            if (storedPaymentReceipt! <
                    selectedReceit.paperNum! + selectedReceit.totalPapers! &&
                storedPaymentReceipt! > selectedReceit.paperNum!) {
              paymentReceipt = storedPaymentReceipt!;
              await receiptManager.storePaymentNumber(
                  receipt: paymentReceipt, userId: userId);
            } else if (storedPaymentReceipt! < selectedReceit.paperNum!) {
              paymentReceipt = selectedReceit.paperNum!;
              await receiptManager.storePaymentNumber(
                  receipt: paymentReceipt, userId: userId);
            } else {
              selectedReceit = await selectReciet(storedPaymentReceipt!);
              paymentReceipt = selectedReceit.paperNum!;

              await receiptManager.storePaymentNumber(
                  receipt: paymentReceipt, userId: userId);
              if (storedPaymentReceipt! < selectedReceit.paperNum!) {
                selectedReceit = await selectReciet(storedPaymentReceipt!);

                paymentReceipt = selectedReceit.paperNum!;
                await receiptManager.storePaymentNumber(
                    receipt: paymentReceipt, userId: userId);
              } else {
                selectedReceit = await selectReciet(storedPaymentReceipt!);

                paymentReceipt = storedPaymentReceipt!;
                await receiptManager.storePaymentNumber(
                    receipt: paymentReceipt, userId: userId);
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
            await receiptManager.storePaymentNumber(
                receipt: paymentReceipt, userId: userId);
          }
        }
        updateController();
      } else {
        emit(GetRecieptError(errorMsg: "لا يوجد دفاتر متاحه"));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void updateController() {
    controllerManager
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
    required TradeCollectionRequest tradeCollectionRequest,
  }) async {
    try {
      emit(AddCollectionLoading());
      var either = await postTradeCollectionUseCase.invoke(
          tradeCollectionRequest: tradeCollectionRequest);

      either.fold((l) {
        emit(AddCollectionError(errorMsg: l.errorMessege));
      }, (r) async {
        int userId = await AuthUtils().getUserId();
        await receiptManager.storePaymentNumber(
            receipt: int.parse(
                controllerManager.addCollectionPaymentReceitController.text),
            userId: userId);

        await incrementPaymentReceipt();
        emit(AddCollectionSucces(tradeCollectionEntity: r));
      });
    } catch (e) {
      emit(AddCollectionError(errorMsg: e.toString()));
    }
  }

  void postPaymentValuesByID({int? customerId, List<int>? paidYears}) async {
    if (paidYears!.isNotEmpty) {
      var either = await paymentValuesByIdUseCase.invoke(
          customerId: customerId, paidYears: paidYears);
      print("Paid years : $paidYears");
      either.fold(
          (l) => Left(emit(GetCustomerDataByIDError(errorMsg: l.errorMessege))),
          (r) {
        controllerManager.updateAddCollectionControllers(
            customerDataEntity: selectedCustomer,
            paymentValuesEntity: r,
            payementReceipt: paymentReceipt);
        emit(GetCustomerDataByIDSuccess(
            customerData: selectedCustomer,
            controllers: controllerManager.addCollectionControllers));
      });
    }
  }

  void handleYearSelection(BuildContext context, int index, bool value) {
    toggleYearSelection(index, value);
    List<int> paidYears =
        updatePaidYears(context.read<AddCollectionCubit>().years);

    if (paidYears.isNotEmpty) {
      postPaymentValuesByID(
        customerId: context.read<AddCollectionCubit>().selectedCustomer.idBl,
        paidYears: paidYears,
      );
    }
  }
}
