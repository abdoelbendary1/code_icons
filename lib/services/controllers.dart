// ignore_for_file: unnecessary_null_comparison

import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ControllerManager {
  // Static variable to hold the single instance of ControllerManager
  static final ControllerManager _instance = ControllerManager._internal();

  // Factory constructor to return the same instance every time it's called
  factory ControllerManager() {
    return _instance;
  }

  // Private constructor to prevent external instantiation
  ControllerManager._internal() {
    diffrentFinanaceController.addListener(_updateTotalFinanceController);
  }
  final customerCubit = CustomersCubit.customersCubit;
  // Method to update the total finance controller based on other values
  double _originalTotal = 0;
  double _previousDifferentFinance = 0;

  void _updateTotalFinanceController() {
    try {
      // Parse the new value of diffrentFinanaceController
      final differentFinance =
          double.tryParse(diffrentFinanaceController.text) ?? 0;

      // Reset to the original total and add the current different finance value
      final totalFinance = _originalTotal + differentFinance;

      // Update the total finance controller
      totalFinanceController.text = totalFinance.toString();
    } catch (e) {
      totalFinanceController.text = "Error";
    }
  }

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

  // Getter to return the list of controllers
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
  // List of TextEditingControllers managed by this class
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController regisrtyNumController = TextEditingController();
  final TextEditingController registryDateController = TextEditingController();
  final TextEditingController activityController = TextEditingController();
  final TextEditingController paymentReceitController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController compensationController = TextEditingController();
  final TextEditingController lateFinanceController = TextEditingController();
  final TextEditingController currentFinanceController =
      TextEditingController();
  final TextEditingController diffrentFinanaceController =
      TextEditingController();
  final TextEditingController totalFinanceController = TextEditingController();
// Method to get the controller by field name
  TextEditingController getControllerByName(String name) {
    switch (name) {
      case 'idBL':
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
      default:
        throw Exception('Controller not found for $name');
    }
  }

  // Getter to return the list of controllers
  List<TextEditingController> get addCollectionControllers => [
        phoneNumController,
        addressController,
        regisrtyNumController,
        registryDateController,
        activityController,
        paymentReceitController,
        divisionController,
        compensationController,
        lateFinanceController,
        currentFinanceController,
        diffrentFinanaceController,
        totalFinanceController,
      ];

  /*  CustomerDataModel createCustomerDataModelFromControllers(
      List<TextEditingController> controllers) {
    return CustomerDataModel(
      idBl: tryParseInt(controllers[0].text,
          defaultValue: 1), // Assuming 1 is the default ID
      brandNameBl: controllers[1].text,
      nationalIdBl: controllers[2].text,
      birthDayBl: controllers[3].text,
      tradeRegistryBl: controllers[4].text,
      licenseDateBl: controllers[5].text,
      licenseYearBl: tryParseInt(controllers[6].text, defaultValue: 2019),
      capitalBl: double.parse(controllers[7].text),
      validBl: tryParseInt(controllers[8].text, defaultValue: 1),
      companyTypeBl: tryParseInt(controllers[9].text, defaultValue: 1),
      companyTypeNameBl: controllers[10].text,
      currencyIdBl: tryParseInt(controllers[11].text, defaultValue: 1),
      tradeOfficeBl: tryParseInt(controllers[12].text, defaultValue: 1),
      tradeOfficeNameBl: controllers[13].text,
      activityBl: tryParseInt(controllers[14].text, defaultValue: 1),
      activityNameBl: controllers[15].text,
      expiredBl: controllers[16].text.isEmpty ? null : controllers[16].text,
      divisionBl: controllers[17].text,
      tradeTypeBl: controllers[18].text,
      ownerBl: controllers[19].text,
      addressBl: controllers[20].text,
      stationBl: tryParseInt(controllers[21].text, defaultValue: 1),
      stationNameBl: controllers[22].text,
      phoneBl: controllers[23].text,
      numExpiredBl: controllers[24].text.isEmpty ? null : controllers[24].text,
      tradeRegistryTypeBl: tryParseInt(controllers[25].text, defaultValue: 1),
      /* customerDataIdBl:
          controllers[26].text.isEmpty ? null : controllers[26].text, */
    );
  } */

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
  }) {
    if (paymentValuesEntity.paidYears!.isNotEmpty) {
      phoneNumController.text = customerDataEntity.phoneBl ?? "";
      addressController.text = customerDataEntity.addressBl ?? "";
      regisrtyNumController.text = customerDataEntity.tradeRegistryBl ?? "";
      registryDateController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      activityController.text = customerDataEntity.activityNameBl ?? "";
      divisionController.text = customerDataEntity.divisionBl ?? "";
      compensationController.text =
          paymentValuesEntity.compensation?.toString() ?? "0";
      lateFinanceController.text = paymentValuesEntity.late?.toString() ?? "0";
      currentFinanceController.text =
          paymentValuesEntity.current?.toString() ?? "0";
      diffrentFinanaceController.text =
          paymentValuesEntity.different?.toString() ?? "0";

      _originalTotal = paymentValuesEntity.total ?? 0;
      if (diffrentFinanaceController.text.isEmpty) {
        _previousDifferentFinance = 0;
      } else {
        _previousDifferentFinance =
            double.tryParse(diffrentFinanaceController.text) ?? 0;
      }

      totalFinanceController.text =
          (_originalTotal + _previousDifferentFinance).toString();
    } else {
      phoneNumController.text = customerDataEntity.phoneBl ?? "";
      addressController.text = customerDataEntity.addressBl ?? "";
      regisrtyNumController.text = customerDataEntity.tradeRegistryBl ?? "";
      registryDateController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      activityController.text = customerDataEntity.activityNameBl ?? "";
      divisionController.text = customerDataEntity.divisionBl ?? "";
      compensationController.text = "0";
      lateFinanceController.text = "0";
      currentFinanceController.text = "0";
      diffrentFinanaceController.text = "0";
      totalFinanceController.text = "0";
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
