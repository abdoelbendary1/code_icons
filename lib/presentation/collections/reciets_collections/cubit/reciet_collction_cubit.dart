import 'dart:convert';

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
}
