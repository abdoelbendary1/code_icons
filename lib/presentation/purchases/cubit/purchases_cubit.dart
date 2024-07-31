import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'purchases_state.dart';

class PurchasesCubit extends Cubit<PurchasesState> {
  PurchasesCubit() : super(PurchasesInitial());

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'birthDayBL': '',
    'licenseDateBL': '',
  };
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

  final List<Map<String, dynamic>> tradeRegistryTypes = [
    {'id': 1, 'type': "رئيسي"},
    {'id': 2, 'type': "فرعي"},
    {'id': 3, 'type': "رئيسي اخر"},
    {'id': 4, 'type': "فرع محافظة اخري"},
    {'id': 5, 'type': "رئيسي محافظة اخري"},
  ];
  List<String> tradeList = [];
  void fetchTradeList() {
    for (var element in tradeRegistryTypes) {
      tradeList.add(element['type']);
    }
  }

  List<dynamic> purchases = [];

  Map<String, dynamic>? selectedTradeRegistryType;
  void updateSelectedTradeRegistryType(Map<String, dynamic>? value) {
    emit(UpdateTradeRegistryTypeLoading());

    /* isSubBranchSelected = value?['type'] == "فرعي"; */
    emit(UpdateTradeRegistryTypeSuccess(
        selectedTradeRegistryType: selectedTradeRegistryType));
  }

  void addItem() {
    emit(AddPurchasesItemloading());
  }

  void getPurchasesList() {
    emit(GetPurchasesListloading());
    emit(GetPurchasesListSuccess(purchases: purchases));
  }

  void saveItem() {
    emit(AddPurchasesItemSuccess());
    emit(PurchasesInitial());
  }

  void updateTradeRegistryType(String value) {
    emit(UpdateTradeRegistryTypeLoading());
    String type = value;
    print(type);
    /* isSubBranchSelected = value?['type'] == "فرعي"; */
    emit(UpdateTradeRegistryTypeSuccess(
        selectedTradeRegistryType: selectedTradeRegistryType, type: type));
  }

  void addPurchaseRequest() {}
}
