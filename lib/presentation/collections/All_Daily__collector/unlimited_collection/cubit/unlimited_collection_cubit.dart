import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/data/model/data_model/unlimited_Data_model.dart';
import 'package:code_icons/data/model/response/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/domain/use_cases/get_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/domain/use_cases/post_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'unlimited_collection_state.dart';

class UnlimitedCollectionCubit extends Cubit<UnlimitedCollectionState>
    with EquatableMixin {
  UnlimitedCollectionCubit({
    required this.postUnRegisteredTradeCollectionUseCase,
    required this.getUnRegisteredTradeCollectionUseCase,
  }) : super(UnlimitedCollectionInitial());
  PostUnRegisteredTradeCollectionUseCase postUnRegisteredTradeCollectionUseCase;
  GetUnRegisteredTradeCollectionUseCase getUnRegisteredTradeCollectionUseCase;

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
  @override
  List<Object?> get props => [identityHashCode(this)];

  UnRegisteredCollectionsResponse createCollectionDataModel() {
    UnRegisteredCollectionsResponse collectionRequest =
        UnRegisteredCollectionsResponse(
      brandNameBl: ControllerManager()
          .getControllerByName("unlimitedNameController")
          .text,
      activityBl: ControllerManager()
          .getControllerByName("unlimitedActivityController")
          .text,
      addressBl: ControllerManager()
          .getControllerByName("unlimitedAddressController")
          .text,
      currentBl: double.parse(ControllerManager()
          .getControllerByName("unlimitedCurrentFinanceController")
          .text),
      divisionBl: double.parse(ControllerManager()
          .getControllerByName("unlimitedDivisionController")
          .text),
      receiptBl: ControllerManager()
          .getControllerByName("unlimitedPaymentReceitController")
          .text,
      receiptDateBl: convertStringToDate(
          inputString: ControllerManager()
              .getControllerByName("unlimitedPaymentReceitDateController")
              .text),
      totalBl: double.parse(ControllerManager()
          .getControllerByName("unlimitedTotalFinanceController")
          .text),
    );
    return collectionRequest;
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

  List<UnRegisteredCollectionEntity> collections = [];

  Future<void> getAllCollctions() async {
    emit(GetCollectionsLoading());
    var either = await getUnRegisteredTradeCollectionUseCase.invoke();
    either.fold(
      (l) => emit(
        GetUnlimitedCollectionsError(errorMsg: l.errorMessege),
      ),
      (r) => emit(
        GetUnlimitedCollectionsSuccess(collectiion: r),
      ),
    );

    /* either.fold(
        (l) => emit(GetUnlimitedCollectionsError(errorMsg: l.errorMessege)),
        (r) {
      
      GetUnlimitedCollectionsSuccess(collectiion: r);
    }); */
  }

  Future<void> addCustomer(
      /* CustomerDataModel customerData, */ BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var either = await postUnRegisteredTradeCollectionUseCase.invoke(
          unRegisteredCollectionEntity: createCollectionDataModel());
      either.fold(
          (l) => emit(AddUnlimitedCollectionError(errorMsg: l.errorMessege)),
          (r) async {
        await incrementPaymentReceipt();
        emit(AddUnlimitedCollectionSuccess(collectionID: r));
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
  }

  void selectRow(UnRegisteredCollectionEntity selectedRow) {
/*     emit(RowSelectedState(selectedRow: selectedRow));
 */
  }

  void deselectRow() {
    getAllCollctions(); // This is to reset the state to the initial list
  }

  Future<List<RecietCollectionDataModel>> getReciets() async {
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    String token = userBox.get('accessToken') ?? '';

    List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);

    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();

    return receipts;
  }

  Future<int?> getPaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.get('paymentReceipt');
  }

  RecietCollectionDataModel selectReciet(int paymentReceipt) {
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
  }

  late int paymentReceipt;
  Future<void> storePaymentReceipt(int receipt) async {
    var userBox = Hive.box('userBox');
    userBox.put('paymentReceipt', receipt);
  }

  int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();
  Future<void> initialize() async {
    await getReciets();
    /*  if (storedPaymentReceipt == null) {
      storePaymentReceipt(
          receipts.firstWhere((element) => element.valid == true).paperNum!);
    } */

    storedPaymentReceipt = await getPaymentReceipt();
    if (storedPaymentReceipt == null) {
      await storePaymentReceipt(1);
      storedPaymentReceipt = await getPaymentReceipt();
    }
    selectedReceit = selectReciet(storedPaymentReceipt!);

    if (receipts.isNotEmpty) {
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
            selectedReceit = selectReciet(storedPaymentReceipt!);
            paymentReceipt = selectedReceit.paperNum!;

            await storePaymentReceipt(paymentReceipt);
            if (storedPaymentReceipt! < selectedReceit.paperNum!) {
              paymentReceipt = selectedReceit.paperNum!;
              await storePaymentReceipt(paymentReceipt);
            } else {
              paymentReceipt = storedPaymentReceipt!;
              await storePaymentReceipt(paymentReceipt);
            }
          }
/*           await storePaymentReceipt(paymentReceipt);
 */
        } /* else {
          if (storedPaymentReceipt <
              selectedReceit.paperNum! + selectedReceit.totalPapers!) {
            paymentReceipt = storedPaymentReceipt;
          }
        } */

        /*  if (paymentReceipt <
            selectedReceit.paperNum! + selectedReceit.totalPapers!) {
          paymentReceipt = storedPaymentReceipt;
        } else {
          paymentReceipt = selectedReceit.paperNum!;
        }
        paymentReceipt = storedPaymentReceipt; */
      } else {
        selectedReceit =
            receipts.firstWhere((element) => element.valid == true);
        paymentReceipt = selectedReceit.paperNum!;
        await storePaymentReceipt(paymentReceipt);
      }
      updateController();
    }
  }

  void updateController() {
    ControllerManager()
        .getControllerByName('unlimitedPaymentReceitController')
        .text = paymentReceipt.toString();
  }

  Future<void> incrementPaymentReceipt() async {
    int? storedPaymentReceipt = await getPaymentReceipt();
    if (storedPaymentReceipt != null) {
      paymentReceipt = storedPaymentReceipt + 1;
      /* if (paymentReceipt >=
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
          .getControllerByName('unlimitedPaymentReceitController')
          .text = paymentReceipt.toString();
    } else {
      // Initialize with the selected receipt's paper number if no payment receipt is stored
      paymentReceipt = selectedReceit.paperNum!;
      await storePaymentReceipt(paymentReceipt);
      ControllerManager()
          .getControllerByName('unlimitedPaymentReceitController')
          .text = paymentReceipt.toString();
    }
  }
}
