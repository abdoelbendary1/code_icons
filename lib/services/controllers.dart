// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:code_icons/data/model/data_model/reciet_DataModel.dart';
import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerManager {
  // Static variable to hold the single instance of ControllerManager
  static final ControllerManager _instance = ControllerManager._internal();

  // Factory constructor to return the same instance every time it's called
  factory ControllerManager() {
    return _instance;
  }

  // Private constructor to prevent external instantiation
  ControllerManager._internal() {
    addCollectionDiffrentFinanaceController.addListener(_updateTotalFinance);
    addCollectionDivisionController.addListener(_updateTotalFinance);
    unlimitedCurrentFinanceController.addListener(calculateAndSetTotal);
    unlimitedDivisionController.addListener(calculateAndSetTotal);
  }
  final customerCubit = CustomersCubit.customersCubit;
  // Method to update the total finance controller based on other values
  double _originalTotal = 0;
  double _previousDifferentFinance = 0;
  double _previousDivisionFinance = 0;
  void calculateDivisionAndSetTotal() {
    try {
      // Parse the current and division values from the text controllers
      double current = 0.0;
      double division =
          double.tryParse(addCollectionDivisionController.text) ?? 0.0;

      // Calculate the total
      double total = double.parse(addCollectionTotalFinanceController.text);
      total = current + division;

      // Set the total value in the total finance controller
      addCollectionTotalFinanceController.text = total.toString();
    } catch (e) {
      print("Error calculating total: $e");
      addCollectionTotalFinanceController.text = "Error";
    }
  }

  void calculateAndSetTotal() {
    try {
      // Parse the current and division values from the text controllers
      double current =
          double.tryParse(unlimitedCurrentFinanceController.text) ?? 0.0;
      double division =
          double.tryParse(unlimitedDivisionController.text) ?? 0.0;

      // Calculate the total
      double total = current + division;

      // Set the total value in the total finance controller
      unlimitedTotalFinanceController.text = total.toString();
    } catch (e) {
      print("Error calculating total: $e");
      unlimitedTotalFinanceController.text = "Error";
    }
  }

  void _updateTotalFinance() {
    try {
      // Parse the different finance and division values from the text controllers
      final differentFinance =
          double.tryParse(addCollectionDiffrentFinanaceController.text) ?? 0;
      final division =
          double.tryParse(addCollectionDivisionController.text) ?? 0;

      // Reset to the original total and add the current different finance value
      double totalFinance = _originalTotal + differentFinance;

      // Update the total with division
      totalFinance += division;

      // Update the total finance controller
      addCollectionTotalFinanceController.text = totalFinance.toString();
    } catch (e) {
      addCollectionTotalFinanceController.text = "Error";
    }
  }

  /* void _updateTotalFinanceController() {
    try {
      // Parse the new value of diffrentFinanaceController
      /*   final divisonFinance =
          double.tryParse(addCollectionDivisionController.text) ?? 0; */
      final differentFinance =
          double.tryParse(addCollectionDiffrentFinanaceController.text) ?? 0;

      // Reset to the original total and add the current different finance value
      final totalFinance = _originalTotal + differentFinance;

      // Update the total finance controller
      addCollectionTotalFinanceController.text = totalFinance.toString();
    } catch (e) {
      addCollectionTotalFinanceController.text = "Error";
    }
  }
 */
// List of TextEditingControllers managed by this class
  final TextEditingController idBLController = TextEditingController();
  final TextEditingController brandNameBLController = TextEditingController();
  final TextEditingController nationalIdBLController = TextEditingController();
  final TextEditingController birthDayBLController = TextEditingController();
  final TextEditingController tradeRegistryBLController =
      TextEditingController();
  final TextEditingController licenseDateBLController = TextEditingController();
  final TextEditingController licenseYearBLController = TextEditingController();
  final TextEditingController capitalBLController = TextEditingController();
  final TextEditingController validBLController = TextEditingController();
  final TextEditingController companyTypeBLController = TextEditingController();
  final TextEditingController companyTypeNameBLController =
      TextEditingController();
  final TextEditingController currencyIdBLController = TextEditingController();
  final TextEditingController tradeOfficeBLController = TextEditingController();
  final TextEditingController tradeOfficeNameBLController =
      TextEditingController();
  final TextEditingController activityBLController = TextEditingController();
  final TextEditingController activityNameBLController =
      TextEditingController();
  final TextEditingController expiredBLController = TextEditingController();
  final TextEditingController divisionBLController = TextEditingController();
  final TextEditingController tradeTypeBLController = TextEditingController();
  final TextEditingController ownerBLController = TextEditingController();
  final TextEditingController addressBLController = TextEditingController();
  final TextEditingController stationBLController = TextEditingController();
  final TextEditingController stationNameBLController = TextEditingController();
  final TextEditingController phoneBLController = TextEditingController();
  final TextEditingController numExpiredBLController = TextEditingController();
  final TextEditingController tradeRegistryTypeBLController =
      TextEditingController();
  final TextEditingController customerDataIdBLController =
      TextEditingController();
  final TextEditingController addCollectionPhoneNumController =
      TextEditingController();
  final TextEditingController addCollectionAddressController =
      TextEditingController();
  final TextEditingController addCollectionRegisrtyNumController =
      TextEditingController();
  final TextEditingController addCollectionRegistryDateController =
      TextEditingController();
  final TextEditingController addCollectionActivityController =
      TextEditingController();
  final TextEditingController addCollectionPaymentReceitController =
      TextEditingController();
  final TextEditingController addCollectionDivisionController =
      TextEditingController();
  final TextEditingController addCollectionCompensationController =
      TextEditingController();
  final TextEditingController addCollectionLateFinanceController =
      TextEditingController();
  final TextEditingController addCollectionCurrentFinanceController =
      TextEditingController();
  final TextEditingController addCollectionDiffrentFinanaceController =
      TextEditingController();
  final TextEditingController addCollectionTotalFinanceController =
      TextEditingController();
  //unreqistered
  final TextEditingController unlimitedNameController = TextEditingController();

  final TextEditingController unlimitedActivityController =
      TextEditingController();
  final TextEditingController unlimitedAddressController =
      TextEditingController();
  final TextEditingController unlimitedPaymentReceitDateController =
      TextEditingController();
  final TextEditingController unlimitedPaymentReceiptController =
      TextEditingController();
  final TextEditingController unlimitedDivisionController =
      TextEditingController();
  final TextEditingController unlimitedCurrentFinanceController =
      TextEditingController();
  final TextEditingController unlimitedTotalFinanceController =
      TextEditingController();

  // reciets
  final TextEditingController paperNum = TextEditingController();
  final TextEditingController totalPapers = TextEditingController();

//purchase request
  final TextEditingController purchaseCodeController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController purchaseAnswerDateController =
      TextEditingController();
  final TextEditingController purchaseNotesController = TextEditingController();
  final TextEditingController purchaseItemQuantitytemController =
      TextEditingController();
  final TextEditingController purchaseItemDiscriptionController =
      TextEditingController();
// Method to get the controller by field name
  List<TextEditingController> get purchaseRequestControllers => [
        purchaseCodeController,
        purchaseDateController,
        purchaseAnswerDateController,
        purchaseNotesController,
        purchaseItemQuantitytemController,
        purchaseItemDiscriptionController,
      ];
// Method to get the controller by field name
  List<TextEditingController> get recietCollectionController => [
        paperNum,
        totalPapers,
      ];
  // Getter to return the list of controllers
  List<TextEditingController> get addCollectionControllers => [
        addCollectionPhoneNumController,
        addCollectionAddressController,
        addCollectionRegisrtyNumController,
        addCollectionRegistryDateController,
        addCollectionActivityController,
        addCollectionPaymentReceitController,
        addCollectionDivisionController,
        addCollectionCompensationController,
        addCollectionLateFinanceController,
        addCollectionCurrentFinanceController,
        addCollectionDiffrentFinanaceController,
        addCollectionTotalFinanceController,
      ];
  List<TextEditingController> get unRegestriedCollectionControllers => [
        unlimitedNameController,
        unlimitedActivityController,
        unlimitedAddressController,
        unlimitedCurrentFinanceController,
        unlimitedDivisionController,
        unlimitedPaymentReceiptController,
        unlimitedPaymentReceitDateController,
        unlimitedTotalFinanceController,
      ];
  List<TextEditingController> get addCustomerControllers => [
        idBLController,
        brandNameBLController,
        nationalIdBLController,
        birthDayBLController,
        tradeRegistryBLController,
        licenseDateBLController,
        licenseYearBLController,
        capitalBLController,
        validBLController,
        companyTypeBLController,
        companyTypeNameBLController,
        currencyIdBLController,
        tradeOfficeBLController,
        tradeOfficeNameBLController,
        activityBLController,
        activityNameBLController,
        expiredBLController,
        divisionBLController,
        tradeTypeBLController,
        ownerBLController,
        addressBLController,
        stationBLController,
        stationNameBLController,
        phoneBLController,
        numExpiredBLController,
        tradeRegistryTypeBLController,
        customerDataIdBLController,
      ];
  TextEditingController getControllerByName(String name) {
    switch (name) {
      case 'purchaseCodeController':
        return purchaseCodeController;
      case 'purchaseDateController':
        return purchaseDateController;
      case 'purchaseAnswerDateController':
        return purchaseAnswerDateController;
      case 'purchaseItemQuantitytemController':
        return purchaseItemQuantitytemController;
      case 'purchaseItemDiscriptionController':
        return purchaseItemDiscriptionController;
      case 'purchaseNotesController':
        return purchaseNotesController;
      case 'paperNum':
        return paperNum;
      case "totalPapers":
        return totalPapers;
      case 'idBLController':
        return idBLController;
      case 'brandNameBL':
        return brandNameBLController;
      case 'nationalIdBL':
        return nationalIdBLController;
      case 'birthDayBL':
        return birthDayBLController;
      case 'tradeRegistryBL':
        return tradeRegistryBLController;
      case 'licenseDateBL':
        return licenseDateBLController;
      case 'licenseYearBL':
        return licenseYearBLController;
      case 'capitalBL':
        return capitalBLController;
      case 'validBL':
        return validBLController;
      case 'companyTypeBL':
        return companyTypeBLController;
      case 'companyTypeNameBL':
        return companyTypeNameBLController;
      case 'currencyIdBL':
        return currencyIdBLController;
      case 'tradeOfficeBL':
        return tradeOfficeBLController;
      case 'tradeOfficeNameBL':
        return tradeOfficeNameBLController;
      case 'activityBL':
        return activityBLController;
      case 'activityNameBL':
        return activityNameBLController;
      case 'expiredBL':
        return expiredBLController;
      case 'divisionBL':
        return divisionBLController;
      case 'tradeTypeBL':
        return tradeTypeBLController;
      case 'ownerBL':
        return ownerBLController;
      case 'addressBL':
        return addressBLController;
      case 'stationBL':
        return stationBLController;
      case 'stationNameBL':
        return stationNameBLController;
      case 'phoneBL':
        return phoneBLController;
      case 'numExpiredBL':
        return numExpiredBLController;
      case 'tradeRegistryTypeBL':
        return tradeRegistryTypeBLController;
      case 'customerDataIdBL':
        return customerDataIdBLController;
      case 'addCollectionPhoneNumController':
        return addCollectionPhoneNumController;
      case 'addCollectionAddressController':
        return addCollectionAddressController;
      case 'addCollectionRegisrtyNumController':
        return addCollectionRegisrtyNumController;
      case 'addCollectionRegistryDateController':
        return addCollectionRegistryDateController;
      case 'addCollectionActivityController':
        return addCollectionActivityController;
      case 'addCollectionPaymentReceitController':
        return addCollectionPaymentReceitController;
      case 'addCollectionDivisionController':
        return addCollectionDivisionController;
      case 'addCollectionCompensationController':
        return addCollectionCompensationController;
      case 'addCollectionLateFinanceController':
        return addCollectionLateFinanceController;
      case 'addCollectionCurrentFinanceController':
        return addCollectionCurrentFinanceController;
      case 'addCollectionDiffrentFinanaceController':
        return addCollectionDiffrentFinanaceController;
      case 'addCollectionTotalFinanceController':
        return addCollectionTotalFinanceController;
      case 'unlimitedNameController':
        return unlimitedNameController;
      case 'unlimitedAddressController':
        return unlimitedAddressController;
      case 'unlimitedPaymentReceitDateController':
        return unlimitedPaymentReceitDateController;
      case 'unlimitedActivityController':
        return unlimitedActivityController;
      case 'unlimitedPaymentReceiptController':
        return unlimitedPaymentReceiptController;
      case 'unlimitedDivisionController':
        return unlimitedDivisionController;
      case 'unlimitedCurrentFinanceController':
        return unlimitedCurrentFinanceController;
      case 'unlimitedTotalFinanceController':
        return unlimitedTotalFinanceController;
      default:
        throw ArgumentError('Invalid controller name: $name');
    }
  }

  void updateCurrencyController(CurrencyEntity currencyEntity) {
    currencyIdBLController.text = currencyEntity.currencyNameAr ?? "";
  }

  void updateControllersWithCustomerData(
      CustomerDataEntity customerDataEntity) {
    print(customerDataEntity.capitalBl);
    brandNameBLController.text = customerDataEntity.brandNameBl ?? ""; //!
    nationalIdBLController.text = customerDataEntity.nationalIdBl ?? ""; //!

    DateTime dateTime = DateTime.parse(customerDataEntity.birthDayBl!);
    var birthDayBl = DateFormat('yyyy/MM/dd').format(dateTime);
    birthDayBLController.text = birthDayBl; //!
    tradeRegistryBLController.text =
        customerDataEntity.tradeRegistryBl ?? ""; //!
    capitalBLController.text =
        customerDataEntity.capitalBl?.toString() ?? ""; //!
    companyTypeBLController.text =
        customerDataEntity.companyTypeBl.toString(); //!
    companyTypeNameBLController.text =
        customerDataEntity.companyTypeNameBl ?? ""; //!
    tradeOfficeBLController.text =
        customerDataEntity.tradeOfficeBl.toString(); //!
    tradeOfficeNameBLController.text =
        customerDataEntity.tradeOfficeNameBl ?? ""; //!
    phoneBLController.text = customerDataEntity.phoneBl ?? ""; //!
    /*  currencyIdBLController.text =
        customerDataEntity.currencyIdBl?.toString() ?? ""; */
    /*   idBLController.text = customerDataEntity.idBl?.toString() ?? ""; */
    /* licenseDateBLController.text = customerDataEntity.licenseDateBl ?? "";
    licenseYearBLController.text = customerDataEntity.licenseYearBl.toString(); */
    /*  validBLController.text = customerDataEntity.validBl?.toString() ?? ""; */
    /*  activityBLController.text = customerDataEntity.activityBl.toString();
    activityNameBLController.text = customerDataEntity.activityNameBl ?? "";
    expiredBLController.text = customerDataEntity.expiredBl?.toString() ?? "";
    divisionBLController.text = customerDataEntity.divisionBl ?? "";
    tradeTypeBLController.text = customerDataEntity.tradeTypeBl ?? "";
    ownerBLController.text = customerDataEntity.ownerBl ?? "";
    addressBLController.text = customerDataEntity.addressBl ?? "";
    stationBLController.text = customerDataEntity.stationBl.toString();
    stationNameBLController.text = customerDataEntity.stationNameBl ?? ""; */
    /* numExpiredBLController.text =
        customerDataEntity.numExpiredBl?.toString() ?? "";
    tradeRegistryTypeBLController.text =
        customerDataEntity.tradeRegistryTypeBl.toString();
    customerDataIdBLController.text =
        customerDataEntity.customerDataIdBl?.toString() ?? ""; */
  }

  // Method to update controllers with data
  void updateAddCollectionControllers({
    required CustomerDataEntity customerDataEntity,
    required PaymentValuesEntity paymentValuesEntity,
    required int payementReceipt,
  }) async {
    if (paymentValuesEntity.paidYears!.isNotEmpty) {
      addCollectionPhoneNumController.text = customerDataEntity.phoneBl ?? "";
      addCollectionAddressController.text = customerDataEntity.addressBl ?? "";
      addCollectionRegisrtyNumController.text =
          customerDataEntity.tradeRegistryBl ?? "";
      addCollectionRegistryDateController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      addCollectionActivityController.text =
          customerDataEntity.divisionBl ?? "";
      addCollectionPaymentReceitController.text = payementReceipt.toString();
      addCollectionDivisionController.text =
          paymentValuesEntity.activity.toString();
      addCollectionCompensationController.text =
          paymentValuesEntity.compensation?.toString() ?? "0";
      addCollectionLateFinanceController.text =
          paymentValuesEntity.late?.toString() ?? "0";
      addCollectionCurrentFinanceController.text =
          paymentValuesEntity.current?.toString() ?? "0";
      addCollectionDiffrentFinanaceController.text =
          paymentValuesEntity.different?.toString() ?? "0";
//calcualte original total without divison and different
      _originalTotal = (paymentValuesEntity.total! -
          paymentValuesEntity.activity! -
          paymentValuesEntity.different!);
      if (addCollectionDiffrentFinanaceController.text.isEmpty) {
        _previousDifferentFinance = 0;
      } else {
        _previousDifferentFinance =
            double.tryParse(addCollectionDiffrentFinanaceController.text) ?? 0;
      }
      if (addCollectionDivisionController.text.isEmpty) {
        _previousDivisionFinance = 0;
      } else {
        _previousDivisionFinance =
            double.tryParse(addCollectionDivisionController.text) ?? 0;
      }

      addCollectionTotalFinanceController.text = (_originalTotal +
              _previousDifferentFinance +
              _previousDivisionFinance)
          .toString();
    } else {
      addCollectionPhoneNumController.text = customerDataEntity.phoneBl ?? "";
      addCollectionAddressController.text = customerDataEntity.addressBl ?? "";
      addCollectionRegisrtyNumController.text =
          customerDataEntity.tradeRegistryBl ?? "";
      addCollectionRegistryDateController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      addCollectionActivityController.text =
          customerDataEntity.activityNameBl ?? "";
      addCollectionDivisionController.text = "0.0";
      addCollectionCompensationController.text = "0.0";
      addCollectionLateFinanceController.text = "0.0";
      addCollectionCurrentFinanceController.text = "0.0";
      addCollectionDiffrentFinanaceController.text = "0.0";
      addCollectionTotalFinanceController.text = "0.0";
      _originalTotal = 0;
      _previousDifferentFinance = 0;
    }
  }

  void clearControllers({required List<TextEditingController> controllers}) {
    for (var controller in controllers) {
      controller.clear();
    }
  }
}
