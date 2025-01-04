/* import 'dart:async';

import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: unused_import
import 'package:code_icons/presentation/utils/shared_prefrence.dart';

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

  Future<int> getUserId() async {
    var userBox = Hive.box('userBox');
    AuthRepoEntity? user = userBox.get('user');
    int userId = user!.id!;
    return userId;
  }

  int? paymentReceipt;
  int? storedPaymentReciet;
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
    Map<dynamic, dynamic>? userData =
        userBox.get(userId.toString()) as Map<dynamic, dynamic>?;

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
          /*  String token = userBox.get('accessToken') ?? ''; */
          /*   String token = SharedPrefrence.getData(key: "accessToken") as String; */

          // Retrieve existing receipts list
          AuthRepoEntity? user = userBox.get('user');
          int userID = user!.id!;

          List<dynamic> existingReceipts =
              receiptsBox.get(userID, defaultValue: []);

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
          receiptsBox.put(userID, existingReceipts);

          storedPaymentReciet = await getPaymentReceipt(userId: userID);
          receipts = existingReceipts
              .map((e) => RecietCollectionDataModel.fromJson(e))
              .toList();

          if (storedPaymentReciet == null) {
            await storePaymentReceipt(
                receipt: receipts
                    .firstWhere((element) => element.valid == true)
                    .paperNum!,
                userId: userID);

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

    /*   String token = userBox.get('accessToken') ?? ''; */
    AuthRepoEntity? user = userBox.get('user');
    int userID = user!.id!;

    List<dynamic> existingReceipts = receiptsBox.get(userID, defaultValue: []);

    receipts = existingReceipts
        .map((i) => RecietCollectionDataModel.fromJson(i))
        .toList();

    if (receipts.isNotEmpty) {
      lastRecietCollection = receipts.last;
      paymentReceipt = await getPaymentReceipt(userId: userID);
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

    AuthRepoEntity? user = userBox.get('user');
    int userID = user!.id!;

    List<dynamic> existingReceipts = receiptsBox.get(userID, defaultValue: []);

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
    try {
      emit(RemoveRecietLoading());
      var userBox = Hive.box('userBox');
      var receiptsBox = Hive.box('receiptsBox');

      AuthRepoEntity? user = userBox.get('user');
      int userID = user!.id!;

      List<dynamic> existingReceipts =
          receiptsBox.get(userID, defaultValue: []);

      RecietCollectionDataModel selectedReciept =
          RecietCollectionDataModel.fromJson(
              existingReceipts.firstWhere((receipt) => receipt['id'] == id));
      if (selectedReciept.valid == true &&
          paymentReceipt! > selectedReciept.paperNum! &&
          paymentReceipt! <=
              selectedReciept.paperNum! + selectedReciept.totalPapers!) {
        emit(RemoveRecietError(
            errorMsg: " لا يمكن حذف هذا الدفتر حاليا لانه مستخدم"));
      } else {
        existingReceipts.removeWhere((receipt) => receipt['id'] == id);
        emit(RemoveRecietSuccess());
      }

      receiptsBox.put(userID, existingReceipts);

      /* emit(RemoveRecietSuccess()); */
      getReciets();
    } catch (e) {
      emit(RemoveRecietError(errorMsg: e.toString()));
    }
  }

  Future<void> removeAllReciets() async {
    emit(RemoveAllRecietsLoading());
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');
    AuthRepoEntity? user = userBox.get('user');
    int userID = user!.id!;
    List<dynamic> existingReceipts = receiptsBox.get(userID, defaultValue: []);
    bool hasUnremovableReceipts = false;

    for (var receiptData in existingReceipts) {
      // Convert receipt data to the model
      RecietCollectionDataModel receipt =
          RecietCollectionDataModel.fromJson(receiptData);
      if (_isReceiptInUse(receipt, paymentReceipt)) {
        hasUnremovableReceipts = true;
        existingReceipts = [];
        existingReceipts.add(receiptData);
        continue; // Skip this receipt
      }
    }
    receiptsBox.put(userID, existingReceipts);

/*     receiptsBox.delete(userID);
 */
/*     deletePaymentReceipt(userId: userID);
 */
    emit(RemoveAllRecietsSuccess());
    getReciets();
  }

  bool _isReceiptInUse(RecietCollectionDataModel receipt, int? paymentReceipt) {
    if (receipt.valid == true &&
        paymentReceipt != null &&
        paymentReceipt > receipt.paperNum! &&
        paymentReceipt <= receipt.paperNum! + receipt.totalPapers!) {
      return true;
    }
    return false;
  }
}
 */

import 'dart:async';

import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'reciet_collction_state.dart';

class RecietCollctionCubit extends Cubit<RecietCollctionState> {
  RecietCollctionCubit() : super(RecietCollctionInitial());

  // Dependency Injection for better testability
  final Box userBox = Hive.box('userBox');
  final Box receiptsBox = Hive.box('receiptsBox');
  static Future<void> initHive() async {
    await Hive.initFlutter();
/*     Hive.registerAdapter(RecietCollectionDataModelAdapter());
 */
    await Hive.openBox('userBox');
    await Hive.openBox('receiptsBox');
  }

  List<RecietCollectionDataModel> receipts = [];
  RecietCollectionDataModel lastRecietCollection =
      RecietCollectionDataModel(id: 0, paperNum: 0, totalPapers: 0);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Store and retrieve cached payment receipt
  Future<void> storePaymentReceipt(int userId, int receipt) async {
    final userData = userBox.get(userId.toString(), defaultValue: {}) as Map;
    userData['paymentReceipt'] = receipt;
    await userBox.put(userId.toString(), userData);
  }

  Future<RecietCollectionDataModel?> getLastReciet() async {
    var userBox = Hive.box('userBox');
    var receiptsBox = Hive.box('receiptsBox');

    AuthRepoEntity? user = userBox.get('user');
    int userID = user!.id!;

    List<dynamic> existingReceipts = receiptsBox.get(userID, defaultValue: []);

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

  Future<int> getUserId() async {
    var userBox = Hive.box('userBox');
    AuthRepoEntity? user = userBox.get('user');
    int userId = user!.id!;
    return userId;
  }

  Future<int?> getPaymentReceipt(int userId) async {
    final userData = userBox.get(userId.toString()) as Map?;
    return userData?['paymentReceipt'];
  }

  Future<void> deletePaymentReceipt(int userId) async {
    final userData = userBox.get(userId.toString()) as Map?;
    if (userData != null) {
      userData.remove('paymentReceipt');
      userData.isEmpty
          ? await userBox.delete(userId.toString())
          : await userBox.put(userId.toString(), userData);
    }
  }

  // Add a receipt with validation and error handling
  /*  Future<void> addReceipt(BuildContext context, int userId,
      RecietCollectionDataModel newReceipt) async {
    try {
      if (!formKey.currentState!.validate()) {
        _showErrorSnackBar(context, "Please fill in all fields");
        return;
      }

      final existingReceipts =
          receiptsBox.get(userId, defaultValue: []) as List;
      final lastPaperNum =
          lastRecietCollection.paperNum! + lastRecietCollection.totalPapers!;

      if (newReceipt.paperNum! <= lastPaperNum) {
        _showErrorSnackBar(
            context, "Paper number must be greater than $lastPaperNum");
        return;
      }

      existingReceipts.add(newReceipt.toJson());
      await receiptsBox.put(userId, existingReceipts);
      lastRecietCollection = newReceipt;

      if (await getPaymentReceipt(userId) == null) {
        await storePaymentReceipt(userId, newReceipt.paperNum!);
      }

      emit(AddRecietCollctionSuccess());
    } catch (e) {
      emit(AddRecietCollctionError(errorMsg: e.toString()));
    }
  } */

  Future<void> addReceipt(BuildContext context,
      {required int userId,
      required RecietCollectionDataModel newReceipt}) async {
    try {
      // Validate form inputs
      if (!formKey.currentState!.validate()) {
        _showErrorSnackBar(context, "Please fill in all fields");
        return;
      }

      // Retrieve existing receipts (should only be one)
      final existingReceipts =
          receiptsBox.get(userId, defaultValue: []) as List;

      if (existingReceipts.isNotEmpty) {
        // Remove the existing receipt
        existingReceipts.clear();
      }

      // Add the new receipt
      existingReceipts.add(newReceipt.toJson());
      await receiptsBox.put(userId, existingReceipts);

      // Update the last receipt reference
      lastRecietCollection = newReceipt;

      // Update the cached payment receipt
      await storePaymentReceipt(userId, newReceipt.paperNum!);

      emit(AddRecietCollctionSuccess());
    } catch (e) {
      emit(AddRecietCollctionError(errorMsg: e.toString()));
    }
  }

  // Remove a specific receipt
  Future<void> removeReceipt(int userId, int receiptId) async {
    try {
      emit(RemoveRecietLoading());
      final existingReceipts =
          receiptsBox.get(userId, defaultValue: []) as List;
      existingReceipts.removeWhere((receipt) =>
          RecietCollectionDataModel.fromJson(receipt).id == receiptId);
      await receiptsBox.put(userId, existingReceipts);
      emit(RemoveRecietSuccess());
    } catch (e) {
      emit(RemoveRecietError(errorMsg: e.toString()));
    }
  }

  // Remove all receipts with validation
  Future<void> removeAllReceipts(int userId) async {
    try {
      emit(RemoveAllRecietsLoading());
      final existingReceipts =
          receiptsBox.get(userId, defaultValue: []) as List;
      final validReceipts = existingReceipts
          .where((receipt) async {
            final model = RecietCollectionDataModel.fromJson(receipt);
            return !_isReceiptInUse(model, await getPaymentReceipt(userId));
          } as bool Function(dynamic element))
          .toList();

      await receiptsBox.put(userId, validReceipts);
      emit(RemoveAllRecietsSuccess());
    } catch (e) {
      emit(RemoveAllRecietsError(errorMsg: e.toString()));
    }
  }

  // Helper to check if receipt is in use
  bool _isReceiptInUse(RecietCollectionDataModel receipt, int? paymentReceipt) {
    return receipt.valid == true &&
        paymentReceipt != null &&
        paymentReceipt > receipt.paperNum! &&
        paymentReceipt <= receipt.paperNum! + receipt.totalPapers!;
  }

  // Utility for showing error messages
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}

class RecietCollectionDataModel {
  final int? id;
  final int? paperNum;
  final int? totalPapers;
  final bool? valid;

  RecietCollectionDataModel(
      {this.id, this.paperNum, this.totalPapers, this.valid});

  Map<String, dynamic> toJson() => {
        'id': id,
        'paperNum': paperNum,
        'totalPapers': totalPapers,
        'valid': valid,
      };

  factory RecietCollectionDataModel.fromJson(Map<String, dynamic> json) =>
      RecietCollectionDataModel(
        id: json['id'],
        paperNum: json['paperNum'],
        totalPapers: json['totalPapers'],
        valid: json['valid'],
      );
}
