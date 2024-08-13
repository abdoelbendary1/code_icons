import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'reciet_collction_state.dart';

class RecietCollctionCubit extends Cubit<RecietCollctionState> {
  RecietCollctionCubit() : super(RecietCollctionInitial());
  RecietCollectionDataModel lastRecietCollection =
      RecietCollectionDataModel(id: 0, paperNum: 0, totalPapers: 0);
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();

  final formKey = GlobalKey<FormState>();

  static Future<void> initHive() async {
    await Hive.initFlutter();
/*     Hive.registerAdapter(RecietCollectionDataModelAdapter());
 */
    await Hive.openBox('userBox');
    await Hive.openBox('receiptsBox');
  }

  int? paymentReceipt;
  int? storedPaymentReciet;
  Future<void> storePaymentReceipt(int receipt) async {
    var userBox = Hive.box('userBox');
    userBox.put('paymentReceipt', receipt);
  }

  Future<int?> getPaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.get('paymentReceipt');
  }

  Future<void> deletePaymentReceipt() async {
    var userBox = Hive.box('userBox');
    return userBox.delete('paymentReceipt');
  }

  Future<void> addReciet(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        if (int.parse(
                ControllerManager().getControllerByName('paperNum').text) <=
            lastRecietCollection.paperNum!) {
          SnackBarUtils.showSnackBar(
            context: context,
            backgroundColor: AppColors.redColor,
            label:
                "لا يمكن اضافه اول ورقه اقل من ${lastRecietCollection.paperNum! + lastRecietCollection.totalPapers!}",
          );
          emit(AddRecietCollctionError(
              errorMsg:
                  "لا يمكن اضافه اول ورقه اقل من ${lastRecietCollection.paperNum! + 1}"));
        } else {
          var userBox = Hive.box('userBox');
          var receiptsBox = Hive.box('receiptsBox');

          // Retrieve user token
          String token = userBox.get('accessToken') ?? '';

          // Retrieve existing receipts list
          List<dynamic> existingReceipts =
              receiptsBox.get(token, defaultValue: []);

          // Create new receipt
          RecietCollectionDataModel newReciet = RecietCollectionDataModel(
            id: lastRecietCollection.id! + 1,
            paperNum: int.tryParse(
                ControllerManager().getControllerByName('paperNum').text),
            totalPapers: int.tryParse(
                ControllerManager().getControllerByName('totalPapers').text),
            valid: true,
          );

          // Add new receipt to the list
          existingReceipts.add(newReciet.toJson());

          // Save the updated receipts list
          receiptsBox.put(token, existingReceipts);
          storedPaymentReciet = await getPaymentReceipt();
          if (storedPaymentReciet == null) {
            await storePaymentReceipt(receipts
                .firstWhere((element) => element.valid == true)
                .paperNum!);

            /*  storedPaymentReciet = await getPaymentReceipt(); */
          }
          emit(AddRecietCollctionSuccess());
        }
      } catch (e) {
        emit(AddRecietCollctionError(errorMsg: e.toString()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "برجاء ادخال جميع البيانات",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.redColor,
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<List<RecietCollectionDataModel>> getReciets() async {
    emit(GetRecietCollctionLoading());
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    String token = userBox.get('accessToken') ?? '';

    List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);

    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();

    if (receipts.isNotEmpty) {
      lastRecietCollection = receipts.last;
      paymentReceipt = await getPaymentReceipt();
      if (paymentReceipt != null) {
        for (var reciept in receipts) {
          if (reciept.paperNum! + reciept.totalPapers! > paymentReceipt!) {
            reciept.valid = true;
          } else {
            reciept.valid = false;
          }
        }
      }
      emit(GetRecietCollctionSuccess(reciets: receipts));
    } else if (receipts.isEmpty) {
      emit(GetRecietCollctionError(errorMsg: "لا يوجد دفاتر حاليه"));
    }

    return receipts;
  }

  RecietCollectionDataModel? selectReciet(int paymentReceipt) {
    try {
      for (var reciept in receipts) {
        if (reciept.paperNum! + reciept.totalPapers! < paymentReceipt) {
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
      return null;
    }
  }

  Future<RecietCollectionDataModel?> getLastReciet() async {
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    String token = userBox.get('accessToken') ?? '';

    List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);

    if (existingReceipts.isNotEmpty) {
      lastRecietCollection =
          RecietCollectionDataModel.fromJson(existingReceipts.last);
      ControllerManager().getControllerByName('paperNum').text =
          (lastRecietCollection.paperNum! + lastRecietCollection.totalPapers!)
              .toString();
      return RecietCollectionDataModel.fromJson(existingReceipts.last);
    }

    emit(GetRecietCollctionError(errorMsg: "There is no last receipt."));
    return null;
  }

  Future<void> removeReciet(int id) async {
    emit(RemoveRecietLoading());
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    String token = userBox.get('accessToken') ?? '';

    List<dynamic> existingReceipts = receiptsBox.get(token, defaultValue: []);

    existingReceipts.removeWhere((receipt) => receipt['id'] == id);

    receiptsBox.put(token, existingReceipts);

    emit(RemoveRecietSuccess());
    getReciets();
  }

  Future<void> removeAllReciets() async {
    emit(RemoveAllRecietsLoading());
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    String token = userBox.get('accessToken') ?? '';

    receiptsBox.delete(token);
    deletePaymentReceipt();

    emit(RemoveAllRecietsSuccess());
    getReciets();
  }
}

/* import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'reciet_collction_state.dart';

class RecietCollctionCubit extends Cubit<RecietCollctionState> {
  RecietCollctionCubit() : super(RecietCollctionInitial());
  RecietCollectionDataModel lastRecietCollection =
      RecietCollectionDataModel(id: 0, paperNum: 0, totalPapers: 0);
  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel selectedReceit = RecietCollectionDataModel();
  late int paymentReceipt;
final formKey = GlobalKey<FormState>();
  void addReciet(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        if (int.parse(
                ControllerManager().getControllerByName('paperNum').text) <=
            lastRecietCollection.paperNum!) {
          SnackBarUtils.showSnackBar(
            context: context,
            backgroundColor: AppColors.redColor,
            label:
                "لا يمكن اضافه اول ورقه اقل من ${lastRecietCollection.paperNum! + 1}",
          );
          emit(AddRecietCollctionError(
              errorMsg:
                  "لا يمكن اضافه اول ورقه اقل من ${lastRecietCollection.paperNum! + 1}"));
        } else {
          // Retrieve user token
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = prefs.getString('accessToken') ?? '';

          // Retrieve existing receipts map
          String? existingReceiptsMap = prefs.getString('receiptsMap');
          Map<String, List<dynamic>> receiptsMap = existingReceiptsMap != null
              ? Map<String, List<dynamic>>.from(
                  json.decode(existingReceiptsMap))
              : {};

          // Retrieve receipts for the current user
          List<dynamic> existingReceipts = receiptsMap[token] ?? [];

          // Create new receipt
          RecietCollectionDataModel newReciet = RecietCollectionDataModel(
            id: lastRecietCollection.id! + 1,
            paperNum: int.tryParse(
                ControllerManager().getControllerByName('paperNum').text),
            totalPapers: int.tryParse(
                ControllerManager().getControllerByName('totalPapers').text),
          );

          // Add new receipt to the list
          existingReceipts.add(newReciet.toJson());

          // Update the receipts map
          receiptsMap[token] = existingReceipts;

          // Save the updated receipts map
          prefs.setString('receiptsMap', json.encode(receiptsMap));
          emit(AddRecietCollctionSuccess());
        }

        /*   if (int.parse(
                ControllerManager().getControllerByName('paperNum').text) >
            lastRecietCollection.paperNum!) {
        } else {} */
      } catch (e) {
        emit(AddRecietCollctionError(errorMsg: e.toString()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "برجاء ادخال جميع البيانات",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.redColor,
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<List<RecietCollectionDataModel>> getReciets() async {
    emit(GetRecietCollctionLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';

    String? existingReceiptsMap = prefs.getString('receiptsMap');
    if (existingReceiptsMap != null) {
      Map<String, List<dynamic>> receiptsMap =
          Map<String, List<dynamic>>.from(json.decode(existingReceiptsMap));
      List<dynamic> existingReceipts = receiptsMap[token] ?? [];

      receipts = existingReceipts
          .map((i) => RecietCollectionDataModel.fromJson(i))
          .toList();

      if (receipts.isNotEmpty) {
        lastRecietCollection = receipts.last;
      }

      emit(GetRecietCollctionSuccess(reciets: receipts));
      return receipts;
    } else {
      emit(GetRecietCollctionError(errorMsg: "لا يوجد ايصالات حاليا"));
      return [];
    }
  }

  Future<RecietCollectionDataModel?> getLastReciet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';

    String? existingReceiptsMap = prefs.getString('receiptsMap');
    if (existingReceiptsMap != null) {
      Map<String, List<dynamic>> receiptsMap =
          Map<String, List<dynamic>>.from(json.decode(existingReceiptsMap));
      List<dynamic> existingReceipts = receiptsMap[token] ?? [];

      if (existingReceipts.isNotEmpty) {
        lastRecietCollection =
            RecietCollectionDataModel.fromJson(existingReceipts.last);
        ControllerManager().getControllerByName('paperNum').text =
            lastRecietCollection.paperNum.toString();
        return RecietCollectionDataModel.fromJson(existingReceipts.last);
      }
    }

    emit(GetRecietCollctionError(errorMsg: "There is no last receipt."));
    return null;
  }

  Future<void> removeReciet(int id) async {
    emit(RemoveRecietLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';

    String? existingReceiptsMap = prefs.getString('receiptsMap');
    if (existingReceiptsMap != null) {
      Map<String, List<dynamic>> receiptsMap =
          Map<String, List<dynamic>>.from(json.decode(existingReceiptsMap));
      List<dynamic> existingReceipts = receiptsMap[token] ?? [];

      existingReceipts.removeWhere((receipt) => receipt['id'] == id);

      receiptsMap[token] = existingReceipts;
      prefs.setString('receiptsMap', json.encode(receiptsMap));

      emit(RemoveRecietSuccess());
      getReciets();
    } else {
      emit(RemoveRecietError(errorMsg: "لا يوجد ايصالات حاليا"));
    }
  }

  Future<void> removeAllReciets() async {
    emit(RemoveAllRecietsLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';

    String? existingReceiptsMap = prefs.getString('receiptsMap');
    if (existingReceiptsMap != null) {
      Map<String, List<dynamic>> receiptsMap =
          Map<String, List<dynamic>>.from(json.decode(existingReceiptsMap));

      receiptsMap.remove(token);
      prefs.setString('receiptsMap', json.encode(receiptsMap));

      emit(RemoveAllRecietsSuccess());
      getReciets();
    } else {
      emit(RemoveAllRecietsError(errorMsg: "لا يوجد ايصالات حاليا"));
    }
  }

/* // Function to select a receipt based on the conditions
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

  Future<void> setPaymentReceiptAndSave() async {
    paymentReceipt = selectedReceit.paperNum ?? 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('paymentReceipt', paymentReceipt);
  }

// Function to increase paymentReceipt by 1 and update it locally
  Future<void> increasePaymentReceiptAndSave() async {
    paymentReceipt += 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('paymentReceipt', paymentReceipt);
  }

// Function to retrieve paymentReceipt from local storage
  Future<void> retrievePaymentReceipt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    paymentReceipt = prefs.getInt('paymentReceipt') ?? 0;
  }

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
 */
  }
 */