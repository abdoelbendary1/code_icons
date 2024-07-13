import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:flutter/material.dart';
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

  /* String updateTotalController(){
      total

  } */

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
