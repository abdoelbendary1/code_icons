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
  

  final formKey = GlobalKey<FormState>();
  void addReciet(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        if (int.parse(
                ControllerManager().getControllerByName('paperNum').text) <=
            lastRecietCollection.paperNum!) {
          SnackBarUtils.hideCurrentSnackBar(context: context);
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

  /* void addReciet(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        // Retrieve existing receipts
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? existingReceipts = prefs.getString('receipts');
        List<RecietCollectionDataModel> receipts = existingReceipts != null
            ? (json.decode(existingReceipts) as List)
                .map((i) => RecietCollectionDataModel.fromJson(i))
                .toList()
            : [];

        // Create new receipt
        RecietCollectionDataModel newReciet = RecietCollectionDataModel(
          paperNum: int.tryParse(
              ControllerManager().getControllerByName('paperNum').text),
          totalPapers: int.tryParse(
              ControllerManager().getControllerByName('totalPapers').text),
        );

        // Add new receipt to the list
        receipts.add(newReciet);

        // Save the updated list
        prefs.setString('receipts', json.encode(receipts));

        emit(AddRecietCollctionSuccess());
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
 */
  /*  Future<List<RecietCollectionDataModel>> getReciets() async {
    emit(GetRecietCollctionLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? existingReceipts = prefs.getString('receipts');
    if (existingReceipts != null) {
      List<RecietCollectionDataModel> receipts =
          (json.decode(existingReceipts) as List)
              .map((i) => RecietCollectionDataModel.fromJson(i))
              .toList();
      lastRecietCollection = receipts.last;
      emit(GetRecietCollctionSuccess(reciets: receipts));
      return receipts;
    } else {
      emit(GetRecietCollctionError(errorMsg: "There is no Reciets."));
      return [];
    }
  } */
}
