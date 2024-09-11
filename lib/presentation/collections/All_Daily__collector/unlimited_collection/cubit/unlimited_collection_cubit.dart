import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/data/model/response/collections/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/domain/use_cases/get_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/domain/use_cases/post_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'unlimited_collection_state.dart';

class UnlimitedCollectionCubit extends Cubit<UnlimitedCollectionState>
    with EquatableMixin {
  UnlimitedCollectionCubit({
    required this.postUnRegisteredTradeCollectionUseCase,
    required this.getUnRegisteredTradeCollectionUseCase,
    required this.authManager,
  }) : super(UnlimitedCollectionInitial());
  PostUnRegisteredTradeCollectionUseCase postUnRegisteredTradeCollectionUseCase;
  GetUnRegisteredTradeCollectionUseCase getUnRegisteredTradeCollectionUseCase;
  AuthManagerInterface authManager;

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
  void clearControllers() {
    ControllerManager().clearControllers(
        controllers: ControllerManager().unRegestriedCollectionControllers);
  }

  int? paymentReceipt;
  int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();
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
          .getControllerByName("unlimitedPaymentReceiptController")
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
        emit(AddUnlimitedCollectionSuccess(collectionID: r.toString()));
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

  /*  Future<void> storePaymentReceipt(int receipt) async {
    var userBox = Hive.box('userBox');
    userBox.put('paymentReceipt', receipt);
  } */
  Future<int?> getPaymentReceipt({required int userId}) async {
    var userBox = Hive.box('userBox');

    // Get the user's data
    Map<dynamic, dynamic>? userData =
        userBox.get(userId.toString()) as Map<dynamic, dynamic>?;

    // Return the paymentReceipt if it exists
    return userData?['paymentReceipt'];
  }

  /*  Future<int?> getPaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.get('paymentReceipt');
  } */

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

/*   Future<void> deletePaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.delete('paymentReceipt');
  } */

  Future<List<RecietCollectionDataModel>> getReciets() async {
    /*  return await ReceiptManager.getReceipts(); */
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

  /*  Future<int?> getPaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.get('paymentReceipt');
  }
 */
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
      selectedReceit = receipts.firstWhere((receipt) => receipt.valid == true);
      /* await addReciet(); */
      return selectedReceit;
    } catch (e) {
      return receipts.last;
    }
  }

  /*  late int paymentReceipt; */
/*   Future<void> storePaymentReceipt(int receipt) async {
    /* await ReceiptManager.storePaymentReceipt(receipt); */
    var userBox = Hive.box('userBox');
    userBox.put('paymentReceipt', receipt);
  } */

/*   int? storedPaymentReceipt;
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel(); */

  /*  Future<void> initialize({required controller}) async {
    /*  await ReceiptManager.initialize(controller: controller); */
    await getReciets();
    if (storedPaymentReceipt == null && receipts.isEmpty) {
      storePaymentReceipt(1);
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
              paymentReceipt = selectedReceit.paperNum!;
              await storePaymentReceipt(paymentReceipt);
            } else {
              paymentReceipt = storedPaymentReceipt!;
              await storePaymentReceipt(paymentReceipt);
            }
          }
        }
      } else {
        selectedReceit =
            receipts.firstWhere((element) => element.valid == true);
        paymentReceipt = selectedReceit.paperNum!;
        await storePaymentReceipt(paymentReceipt);
      }
      updateController();
    } else {
      storePaymentReceipt(1);
      await addReciet();
      receipts = await getReciets();
      selectedReceit = receipts.firstWhere((element) => element.valid == true);
      paymentReceipt = selectedReceit.paperNum!;
      await storePaymentReceipt(paymentReceipt);
    }
  } */
  Future<int> getUserId() async {
    var userBox = Hive.box('userBox');
    AuthRepoEntity? user = userBox.get('user');
    int userId = user!.id!;
    return userId;
  }

  Future<void> initialize({required controller}) async {
    /* if (paymentReceipt == null) {
      paymentReceipt = storedPaymentReceipt;
    } */

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
        /*  if (paymentReceipt == null) {
          paymentReceipt = storedPaymentReceipt;
          emit(GetPaymentRecietValueError(
              paymentReciept: storedPaymentReceipt!));
        } */
        if (selectedReceit.valid!) {
          if (storedPaymentReceipt! <
                  selectedReceit.paperNum! + selectedReceit.totalPapers! &&
              storedPaymentReceipt! > selectedReceit.paperNum!) {
            paymentReceipt = storedPaymentReceipt!;
            await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
          } else if (storedPaymentReceipt! < selectedReceit.paperNum!) {
            paymentReceipt = selectedReceit.paperNum!;
            await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
          } else {
            selectedReceit = await selectReciet(storedPaymentReceipt!);
            paymentReceipt = selectedReceit.paperNum!;

            await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
            if (storedPaymentReceipt! < selectedReceit.paperNum!) {
              paymentReceipt = selectedReceit.paperNum!;
              await storePaymentReceipt(
                  receipt: paymentReceipt!, userId: userId);
            } else {
              paymentReceipt = storedPaymentReceipt!;
              await storePaymentReceipt(
                  receipt: paymentReceipt!, userId: userId);
            }
          }
        } else {
          await getReciets();
          selectedReceit = await selectReciet(storedPaymentReceipt!);
          paymentReceipt = selectedReceit.paperNum;
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
          await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
        }
      }
      updateController();
    } else {
      await storePaymentReceipt(receipt: 1, userId: userId);
      await addReciet();
      receipts = await getReciets();
      selectedReceit = receipts.firstWhere(
        (element) => element.valid == true,
        orElse: () => RecietCollectionDataModel(
            id: 0, paperNum: 0, totalPapers: 0, valid: false),
      );
      if (selectedReceit.id != 0) {
        paymentReceipt = selectedReceit.paperNum!;
        await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
      }
      updateController();
    }
  }

  void updateController() {
    ControllerManager()
        .getControllerByName('unlimitedPaymentReceiptController')
        .text = paymentReceipt.toString();
  }

  Future<void> incrementPaymentReceipt() async {
    int userId = await getUserId();
    /* await ReceiptManager.incrementPaymentReceipt(); */
    int? storedPaymentReceipt = await getPaymentReceipt(userId: userId);
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
      await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
      ControllerManager()
          .getControllerByName('unlimitedPaymentReceiptController')
          .text = paymentReceipt.toString();
    } else {
      // Initialize with the selected receipt's paper number if no payment receipt is stored
      paymentReceipt = selectedReceit.paperNum!;
      await storePaymentReceipt(receipt: paymentReceipt!, userId: userId);
      ControllerManager()
          .getControllerByName('unlimitedPaymentReceiptController')
          .text = paymentReceipt.toString();
    }
  }
}
