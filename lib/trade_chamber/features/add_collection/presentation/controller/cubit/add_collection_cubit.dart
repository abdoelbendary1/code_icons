import 'package:code_icons/data/api/tradeChamber/customers/customers_manager.dart';
import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
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
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
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
  final FocusNode divisionFocusNode = FocusNode();
  final FocusNode diffrentFocusNode = FocusNode();
  List<CustomerDataEntity> customerData = [];
  List<CustomerDataEntity> filteredData = [];
  OverlayPortalController overlayPortalNameController =
      OverlayPortalController();
  OverlayPortalController overlayPortalRegistryController =
      OverlayPortalController();

/*   final ReceiptManager receiptManager;
 */
  late List<String> customersNames;
  //! check the selectedCustomer ID
  CustomerDataEntity selectedCustomer = CustomerDataEntity();
  String yearsOfRepaymentBL = '';
  late int paymentReceipt;
  static AddCollectionCubit initializeCubit() {
    return AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase(),
    );
  }

  static void clearControllers() {
    ControllerManager().clearControllers(
      controllers: ControllerManager().addCollectionControllers,
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

  TradeCollectionRequest intializeTradeRequest(
      {required CustomerDataEntity selectedCustomer,
      required BuildContext context}) {
    return TradeCollectionRequest(
      activityBl: double.tryParse(
          ControllerManager().addCollectionDivisionController.text),
      addressBl: ControllerManager().addCollectionAddressController.text,
      collectionDateBl: convertStringToDate(
          inputString:
              ControllerManager().addCollectionRegistryDateController.text),
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
      yearsOfRepaymentLstBL: updatePaidYears(years),
    );
  }

  Future<void> addRegisteredCollection({
    required BuildContext context,
    required AddCollectionCubit cubit,
    required GlobalKey<FormState> formKey,
  }) async {
    // Prevent double execution if the button is already disabled
    if (!cubit.isButtonEnabled) return;

    try {
      // Validate if years of repayment are provided
      if (context.read<AddCollectionCubit>().yearsOfRepaymentBL.isEmpty) {
        AlertService.showError(
            context: context, errorMsg: "يجب اضافه سنوات السداد");
        return;
      }

      // Validate form inputs
      if (!formKey.currentState!.validate()) {
        AlertService.showError(
            context: context, errorMsg: "برجاء ادخال جميع البيانات");
        return;
      }

      // Proceed with trade collection request
      CustomerDataEntity selectedCustomer =
          context.read<AddCollectionCubit>().selectedCustomer;
      TradeCollectionRequest tradeCollectionRequest =
          cubit.intializeTradeRequest(
        selectedCustomer: selectedCustomer,
        context: context,
      );
      if (cubit.selectedCustomer.idBl == null ||
          tradeCollectionRequest.paymentReceiptNumBl == null) {
        AlertService.showError(
            context: context, errorMsg: "برجاء المحاولة مرة اخرى");
        emit(GetAllCustomerDataInitial());
        return;
      }
      cubit.isButtonEnabled = false; // Disable the button immediately

      await cubit.postTradeCollection(
        token: "token",
        tradeCollectionRequest: tradeCollectionRequest,
        context: context,
      );
    } catch (e) {
      AlertService.showError(
          context: context, errorMsg: "An error occurred: $e");
    } finally {
      // Re-enable the button after processing
      cubit.isButtonEnabled = true;
    }
  }

  final ScrollController scrollController = ScrollController();
  List<CustomerDataEntity> customers = [];
  int skip = 0;
  final int take = 20;
  bool isLoading = false;
  bool hasMoreData = true;
  String searchQuery = '';

  void initializePagination() {
    scrollController.addListener(onScroll);
    loadMoreCustomers();
  }

  late PaymentValuesEntity paymentValuesEntity;
  bool isButtonEnabled = true; // Initial state

  void recalculateTotal(PaymentValuesEntity paymentValuesEntity) {
    // Step 2: Override values with the current text values from the controllers
    double updatedActivity = double.tryParse(
            ControllerManager().addCollectionDivisionController.text) ??
        paymentValuesEntity.activity ??
        0;

    double updatedDifferent = double.tryParse(
            ControllerManager().addCollectionDiffrentFinanaceController.text) ??
        paymentValuesEntity.different ??
        0;

    // Step 3: Recalculate the total using the updated values
    paymentValuesEntity.total = updatedActivity +
        (double.tryParse(ControllerManager()
                .addCollectionCurrentFinanceController
                .text) ??
            0) +
        (double.tryParse(
                ControllerManager().addCollectionCompensationController.text) ??
            0) +
        (double.tryParse(
                ControllerManager().addCollectionLateFinanceController.text) ??
            0) +
        updatedDifferent +
        (double.tryParse(
                ControllerManager().addCollectionLatePayController.text) ??
            0) -
        (double.tryParse(
                ControllerManager().addCollectionAdvPayController.text) ??
            0);

    // Step 4: Update the total in the total finance controller
    ControllerManager().addCollectionTotalFinanceController.text =
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

  void onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMoreData) {
      loadMoreCustomers(filter: searchQuery);
    }
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    resetPagination();
  }

  void resetPagination() {
    customers.clear();
    skip = 0;
    hasMoreData = true;
    loadMoreCustomers(filter: searchQuery);
  }

  Future<List<CustomerDataEntity>> searchCustomerData({
    required int skip,
    required int take,
    String? filter,
  }) async {
    var either = await fetchCustomerDataUseCase.fetchCustomerData(
        skip: skip, take: take, filter: filter);
    return either.fold(
      (failure) {
        return [];
      },
      (response) async {
        customerData = response;
        return customerData;
      },
    );
  }

  void fetchCustomerData({
    required int skip,
    required int take,
    String? filter,
  }) async {
    /* emit(GetAllCustomerDataInitial()); */
    emit(GetAllCustomerDataLoading());
    var either = await fetchCustomerDataUseCase.fetchCustomerData(
      skip: skip,
      take: take,
      filter: filter,
    );
    either.fold((failure) {
      emit(GetAllCustomerDataError(errorMsg: failure.errorMessege));
    }, (response) {
      customersNames = response.map((e) => e.brandNameBl!).toList();
      customerData = response;
      customers = response;
      emit(GetAllCustomerDataSuccess(
          customerData: response, selectedCustomer: response.first));
    });
  }

  Future<List<CustomerDataEntity>> fetchCustomerDataPages({
    required int skip,
    required int take,
    String? filter,
  }) async {
    // No emit here, we handle data directly.
    var either = await fetchCustomerDataUseCase.fetchCustomerData(
      skip: skip,
      take: take,
      filter: filter,
    );

    // Handle the result
    return either.fold((failure) {
      // Handle the error here (for example, throw an exception or return an empty list)
      throw Exception(
          failure.errorMessege); // Or return an empty list if preferred
    }, (response) {
      /*  emit(GetAllCustomerDataSuccess(
          customerData: response, selectedCustomer: response.first)); */
      // Process the successful response, for example:
      customerData = response;
      return response; // Return the fetched data
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
    {'year': DateTime.now().year.toString(), 'isPaid': false},
  ];

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

  /*  void toggleYearSelection(int index, bool isSelected) {
    if (allPreviousYearsChecked(index)) {
      years[index]['isPaid'] = isSelected;

      for (int i = index + 1; i < years.length; i++) {
        years[i]['isPaid'] = false;
      }

      emit(YearsUpdatedState(years: List.from(years)));
    } else {
      // Feedback to UI should be handled in the onSelected function
    }
   
    emit(YearsUpdatedState(years: List.from(years)));
  } */

  void toggleYearSelection(int index, bool isSelected) {
    // Update the selected year's isPaid status
    years[index]['isPaid'] = isSelected;

    // Emit the updated state to reflect changes
    emit(YearsUpdatedState(years: List.from(years)));
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

  Future<void> storePaymentReceipt(
      {required int userId, required int receipt}) async {
    var userBox = Hive.box('userBox');

    // Get existing user data or create a new map
    Map<dynamic, dynamic> userData = userBox
        .get(userId.toString(), defaultValue: {}) as Map<dynamic, dynamic>;

    // Update the paymentReceipt
    userData['paymentReceipt'] = receipt;

    // Save the updated user data
    userBox.put(userId.toString(), userData);
  }

  Future<int?> getPaymentReceipt({required int userId}) async {
    var userBox = Hive.box('userBox');

    // Get the user's data
    Map<dynamic, dynamic>? userData =
        userBox.get(userId.toString()) as Map<dynamic, dynamic>?;

    // Return the paymentReceipt if it exists
    return userData?['paymentReceipt'];
  }

  Future<void> deletePaymentReceipt({required int userId}) async {
    var userBox = Hive.box('userBox');

    // Get existing user data
    Map<String, dynamic>? userData =
        userBox.get(userId.toString()) as Map<String, dynamic>?;

    if (userData != null) {
      // Remove the paymentReceipt entry
      userData.remove('paymentReceipt');

      // Update the user data or delete the user if no other data exists
      if (userData.isEmpty) {
        userBox.delete(userId.toString());
      } else {
        userBox.put(userId.toString(), userData);
      }
    }
  }

  Future<void> addReciet() async {
    try {
      var userBox = Hive.box('userBox');
      var receiptsBox = Hive.box('receiptsBox');

      // Retrieve user token

      AuthRepoEntity? user = userBox.get('user');
      int userID = user!.id!;

      List<dynamic> existingReceipts =
          receiptsBox.get(userID, defaultValue: []);
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
      receiptsBox.put(userID, existingReceipts);
      var storedPaymentReciet = await getPaymentReceipt(userId: userID);
      if (storedPaymentReciet == null) {
        await storePaymentReceipt(
            receipt: receipts
                .firstWhere((element) => element.valid == true)
                .paperNum!,
            userId: userID);
      }
    } catch (e) {}
  }

  Future<RecietCollectionDataModel> selectReciet(int paymentReceipt) async {
    /*   return await ReceiptManager.selectReceipt(paymentReceipt); */
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
        await addReciet();
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
/*     await receiptManager.incrementPaymentReceipt();
 */
    int userId = await getUserId();
    int? storedPaymentReceipt = await getPaymentReceipt(userId: userId);
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
      await storePaymentReceipt(receipt: paymentReceipt, userId: userId);
      ControllerManager()
          .getControllerByName('addCollectionPaymentReceitController')
          .text = paymentReceipt.toString();
    } else {
      // Initialize with the selected receipt's paper number if no payment receipt is stored
      paymentReceipt = selectedReceit.paperNum!;
      await storePaymentReceipt(receipt: paymentReceipt, userId: userId);
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

    AuthRepoEntity? user = userBox.get('user');
    int userID = user!.id!;

    List<dynamic> existingReceipts = receiptsBox.get(userID, defaultValue: []);

    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();

    return receipts;
  }

  int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  late RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();
  Future<void> initialize({required BuildContext context}) async {
    try {
      await getReciets();
      int userId = await getUserId();
      if (storedPaymentReceipt == null && receipts.isEmpty) {
        await storePaymentReceipt(receipt: 1, userId: userId);
      }

      if (receipts.isNotEmpty) {
        storedPaymentReceipt = await getPaymentReceipt(userId: userId);

        if (storedPaymentReceipt == null) {
          await storePaymentReceipt(receipt: 1, userId: userId);
          storedPaymentReceipt = await getPaymentReceipt(userId: userId);
        }

        selectedReceit = await selectReciet(storedPaymentReceipt!);
        if (storedPaymentReceipt != null) {
          if (selectedReceit.valid!) {
            if (storedPaymentReceipt! <
                    selectedReceit.paperNum! + selectedReceit.totalPapers! &&
                storedPaymentReceipt! > selectedReceit.paperNum!) {
              paymentReceipt = storedPaymentReceipt!;
              await storePaymentReceipt(
                  receipt: paymentReceipt, userId: userId);
            } else if (storedPaymentReceipt! < selectedReceit.paperNum!) {
              paymentReceipt = selectedReceit.paperNum!;
              await storePaymentReceipt(
                  receipt: paymentReceipt, userId: userId);
            } else {
              selectedReceit = await selectReciet(storedPaymentReceipt!);
              paymentReceipt = selectedReceit.paperNum!;

              await storePaymentReceipt(
                  receipt: paymentReceipt, userId: userId);
              if (storedPaymentReceipt! < selectedReceit.paperNum!) {
                selectedReceit = await selectReciet(storedPaymentReceipt!);

                paymentReceipt = selectedReceit.paperNum!;
                await storePaymentReceipt(
                    receipt: paymentReceipt, userId: userId);
              } else {
                selectedReceit = await selectReciet(storedPaymentReceipt!);

                paymentReceipt = storedPaymentReceipt!;
                await storePaymentReceipt(
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
            await storePaymentReceipt(receipt: paymentReceipt, userId: userId);
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

  Future<int> getUserId() async {
    var userBox = Hive.box('userBox');
    AuthRepoEntity? user = userBox.get('user');
    int userId = user!.id!;
    return userId;
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

  String convertStringToDate({required String inputString}) {
    if (inputString.isNotEmpty) {
      DateFormat inputFormat = DateFormat('MMM d, y, h:mm:ss a');
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
          int userId = await getUserId();
          await storePaymentReceipt(
              receipt: int.parse(ControllerManager()
                  .addCollectionPaymentReceitController
                  .text),
              userId: userId);

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
      print("Paid years : $paidYears");
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

  List<int> paidYears = [];
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

  /* void handleYearSelection(BuildContext context, int index, bool value) {
    if (value) {
      /*   // When marking a year as paid
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
      } */
      toggleYearSelection(index, value);
      List<int> paidYears =
          updatePaidYears(context.read<AddCollectionCubit>().years);
      showCustomSnackBar(
          context: context,
          message: paidYears.toString(),
          type: SnackBarType.success);
      if (paidYears.isNotEmpty) {
        postPaymentValuesByID(
          customerId: context.read<AddCollectionCubit>().selectedCustomer.idBl,
          paidYears: paidYears,
        );
      }
    } else {
      // When marking a year as unpaid
      /*   if (anyForwardYearsChecked(index)) {
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
      } */
      toggleYearSelection(index, value);
      List<int> paidYears =
          updatePaidYears(context.read<AddCollectionCubit>().years);
      showCustomSnackBar(
          context: context,
          message: paidYears.toString(),
          type: SnackBarType.error);

      if (paidYears.isNotEmpty) {
        postPaymentValuesByID(
          customerId: context.read<AddCollectionCubit>().selectedCustomer.idBl,
          paidYears: paidYears,
        );
      }
    }
  }
 */
}