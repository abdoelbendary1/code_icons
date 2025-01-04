// ignore_for_file: unnecessary_null_comparison

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/presentation/Sales/Invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
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
    /* addCollectionDiffrentFinanaceController.addListener(_updateTotalFinance);
    addCollectionDivisionController.addListener(_updateTotalFinance); */
    unlimitedCurrentFinanceController.addListener(calculateAndSetTotal);
    unlimitedDivisionController.addListener(calculateAndSetTotal);
  }

  final customerCubit = CustomersCubit.customersCubit;
  // Method to update the total finance controller based on other values
  double _originalTotal = 0;
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
  } // Update discount value based on rate

// Update discount rate based on value
  // Declare controllers with purchases prefix
  final TextEditingController pritemNameAr = TextEditingController();
  final TextEditingController pritemSmallUomPriceP = TextEditingController();
  final TextEditingController pritemSmallUomPriceS = TextEditingController();

  final TextEditingController prUnitPriceController = TextEditingController();
  final TextEditingController prQuantityController = TextEditingController();
  final TextEditingController prTotalQuantityController =
      TextEditingController();
  final TextEditingController prDiscountRateController =
      TextEditingController();
  final TextEditingController prDiscountValueController =
      TextEditingController();

  final TextEditingController prPriceController = TextEditingController();
  final TextEditingController prAvailableQuantityController =
      TextEditingController();
  final TextEditingController prInvoiceOperationNumberController =
      TextEditingController();
  final TextEditingController prLengthController = TextEditingController();
  final TextEditingController prWidthController = TextEditingController();
  final TextEditingController prHeightController = TextEditingController();
  final TextEditingController prTotalTaxesController = TextEditingController();
  final TextEditingController prTaxesNameController = TextEditingController();
  final TextEditingController prinvoiceTotalTaxesController =
      TextEditingController();
  final TextEditingController prInvoiceDescriptionController =
      TextEditingController();
  final TextEditingController prinvoiceDateController = TextEditingController();
  final TextEditingController prinvoiceRateController = TextEditingController();
  final TextEditingController prinvoiceDiscountPercentageController =
      TextEditingController();
  final TextEditingController prinvoiceDiscountValueController =
      TextEditingController();
  final TextEditingController prinvoicePaidController = TextEditingController();
  final TextEditingController prinvoiceTotalPriceController =
      TextEditingController();

  final TextEditingController prinvoiceCodeController = TextEditingController();
  final TextEditingController prinvoiceAddCustomerNameController =
      TextEditingController();
  final TextEditingController prinvoiceAddCustomerPhoneController =
      TextEditingController();
  final TextEditingController prinvoiceAddCustomerTaxNumController =
      TextEditingController();
  final TextEditingController prinvoiceAddItemCompanyNameArController =
      TextEditingController();
  final TextEditingController prinvoiceAddItemCategoryNameArController =
      TextEditingController();
  final TextEditingController prinvoiceAddCustomerCountryController =
      TextEditingController();

  final TextEditingController prinvoiceSourceCodeController =
      TextEditingController();
  final TextEditingController prinvoiceNotesController =
      TextEditingController();
  final TextEditingController prinvoiceTotalController =
      TextEditingController();
  final TextEditingController prinvoiceNetController = TextEditingController();
  final TextEditingController prinvoiceTaxesController =
      TextEditingController();
  final TextEditingController prinvoiceJournalController =
      TextEditingController();
  final TextEditingController prinvoiceDrawerIdController =
      TextEditingController();
  final TextEditingController prinvoiceProcessIdController =
      TextEditingController();
  final TextEditingController prinvoiceSourceTypeController =
      TextEditingController();
  final TextEditingController prinvoiceRemainController =
      TextEditingController();
  final TextEditingController prinvoiceCustomerBalanceController =
      TextEditingController();
  final TextEditingController prinvoiceReceiveDateController =
      TextEditingController();
  final TextEditingController prinvoiceDueDateController =
      TextEditingController();
  final TextEditingController prinvoiceInsertDateController =
      TextEditingController();
// Declare controllers with Sales prefix
  final TextEditingController itemNameAr = TextEditingController();
  final TextEditingController itemSmallUomPriceP = TextEditingController();
  final TextEditingController itemSmallUomPriceS = TextEditingController();

  final TextEditingController salesUnitPriceController =
      TextEditingController();
  final TextEditingController salesQuantityController = TextEditingController();
  final TextEditingController salesTotalQuantityController =
      TextEditingController();
  final TextEditingController salesDiscountRateController =
      TextEditingController();
  final TextEditingController salesDiscountValueController =
      TextEditingController();

  final TextEditingController salesPriceController = TextEditingController();
  final TextEditingController salesAvailableQuantityController =
      TextEditingController();
  final TextEditingController salesOperationNumberController =
      TextEditingController();
  final TextEditingController salesLengthController = TextEditingController();
  final TextEditingController salesWidthController = TextEditingController();
  final TextEditingController salesHeightController = TextEditingController();
  final TextEditingController salesTotalTaxesController =
      TextEditingController();
  final TextEditingController salesTaxesNameController =
      TextEditingController();
  final TextEditingController invoiceTotalTaxesController =
      TextEditingController();
  final TextEditingController salesDescriptionController =
      TextEditingController();
  final TextEditingController invoiceDateController = TextEditingController();
  final TextEditingController invoiceRateController = TextEditingController();
  final TextEditingController invoiceDiscountPercentageController =
      TextEditingController();
  final TextEditingController invoiceDiscountValueController =
      TextEditingController();
  final TextEditingController invoicePaidController = TextEditingController();

  final TextEditingController invoiceTotalPriceController =
      TextEditingController();

  final TextEditingController invoiceCodeController = TextEditingController();
  final TextEditingController invoiceAddCustomerNameController =
      TextEditingController();
  final TextEditingController invoiceAddCustomerPhoneController =
      TextEditingController();
  final TextEditingController invoiceAddCustomerTaxNumController =
      TextEditingController();
  final TextEditingController invoiceAddItemCompanyNameArController =
      TextEditingController();
  final TextEditingController invoiceAddItemCategoryNameArController =
      TextEditingController();
  final TextEditingController invoiceAddCustomerCountryController =
      TextEditingController();

  final TextEditingController invoiceSourceCodeController =
      TextEditingController();
  final TextEditingController invoiceNotesController = TextEditingController();
  final TextEditingController invoiceTotalController = TextEditingController();
  final TextEditingController invoiceNetController = TextEditingController();
  final TextEditingController invoiceTaxesController = TextEditingController();
  final TextEditingController invoiceJournalController =
      TextEditingController();
  final TextEditingController invoiceDrawerIdController =
      TextEditingController();
  final TextEditingController invoiceProcessIdController =
      TextEditingController();
  final TextEditingController invoiceSourceTypeController =
      TextEditingController();
  final TextEditingController invoiceRemainController = TextEditingController();
  final TextEditingController invoiceCustomerBalanceController =
      TextEditingController();
  final TextEditingController invoiceReceiveDateController =
      TextEditingController();
  final TextEditingController invoiceDueDateController =
      TextEditingController();
  final TextEditingController invoiceInsertDateController =
      TextEditingController();
  List<TextEditingController> get discountsSales => [
        salesDiscountRateController,
        salesDiscountValueController,
      ];
  List<TextEditingController> get discountsPR => [
        prDiscountRateController,
        prDiscountValueController,
      ];
  List<TextEditingController> get addSalesCustomer => [
        invoiceAddCustomerNameController,
        invoiceAddCustomerPhoneController,
        invoiceAddCustomerTaxNumController,
        invoiceAddCustomerCountryController
      ];
  List<TextEditingController> get prinvoiceControllers => [
        prinvoiceDateController,
        prinvoiceRateController,
        prinvoiceTotalTaxesController,
        prinvoiceDiscountPercentageController,
        prinvoiceDiscountValueController,
        prinvoicePaidController,
        prinvoiceNetController,
        prinvoiceCodeController,
        prinvoiceSourceCodeController,
        prinvoiceNotesController,
        prinvoiceTotalPriceController,
        prinvoiceTotalController,
        prinvoiceNetController,
        prinvoiceTaxesController,
        prinvoiceJournalController,
        prinvoiceDrawerIdController,
        prinvoiceProcessIdController,
        prinvoiceSourceTypeController,
        prinvoiceRemainController,
        prinvoiceCustomerBalanceController,
        prinvoiceReceiveDateController,
        prinvoiceDueDateController,
        prinvoiceInsertDateController,
      ];
  List<TextEditingController> get prControllers => [
        prUnitPriceController,
        prQuantityController,
        prTotalQuantityController,
        prDiscountRateController,
        prDiscountValueController,
        prPriceController,
        prAvailableQuantityController,
        prInvoiceOperationNumberController,
        prLengthController,
        prWidthController,
        prHeightController,
        prTotalTaxesController,
        prInvoiceDescriptionController,
        prTaxesNameController
      ];
  List<TextEditingController> get invoiceControllers => [
        invoiceDateController,
        invoiceRateController,
        invoiceTotalTaxesController,
        invoiceDiscountPercentageController,
        invoiceDiscountValueController,
        invoicePaidController,
        invoiceNetController,
        invoiceCodeController,
        invoiceSourceCodeController,
        invoiceNotesController,
        invoiceTotalPriceController,
        invoiceTotalController,
        invoiceNetController,
        invoiceTaxesController,
        invoiceJournalController,
        invoiceDrawerIdController,
        invoiceProcessIdController,
        invoiceSourceTypeController,
        invoiceRemainController,
        invoiceCustomerBalanceController,
        invoiceReceiveDateController,
        invoiceDueDateController,
        invoiceInsertDateController,
      ];

  List<TextEditingController> get itemControllers => [
        itemNameAr,
        itemSmallUomPriceP,
        itemSmallUomPriceS,
      ];

  // List of controllers
  List<TextEditingController> get salesControllers => [
        salesUnitPriceController,
        salesQuantityController,
        salesTotalQuantityController,
        salesDiscountRateController,
        salesDiscountValueController,
        salesPriceController,
        salesAvailableQuantityController,
        salesOperationNumberController,
        salesLengthController,
        salesWidthController,
        salesHeightController,
        salesTotalTaxesController,
        salesDescriptionController,
        salesTaxesNameController
      ];

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
  final TextEditingController addCollectionAdvPayController =
      TextEditingController();
  final TextEditingController addCollectionLatePayController =
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
  //purchase invoice
  final TextEditingController purchaseCurRateController =
      TextEditingController();
  final TextEditingController purchaseInvoiceDateController =
      TextEditingController();

  //PrOrderControllers
  final TextEditingController prOrderCodeController = TextEditingController();
  final TextEditingController prOrderSourceCodeController =
      TextEditingController();
  final TextEditingController prOrderDateController = TextEditingController();
  final TextEditingController prOrderFactoryController =
      TextEditingController();
  final TextEditingController prOrderNotesController = TextEditingController();
  final TextEditingController prOrderItemPriceController =
      TextEditingController();
  final TextEditingController prOrderQtyController = TextEditingController();
  final TextEditingController prOrderTotalQtyController =
      TextEditingController();
  final TextEditingController prOrderExpireDateController =
      TextEditingController();
  final TextEditingController prOrderDiscountPercentageController =
      TextEditingController();
  final TextEditingController prOrderDiscountValueController =
      TextEditingController();
  final TextEditingController prOrderItemLengthController =
      TextEditingController();
  final TextEditingController prOrderItemWidthController =
      TextEditingController();
  final TextEditingController prOrderItemheightController =
      TextEditingController();
  final TextEditingController prOrderDiscriptionController =
      TextEditingController();
  List<TextEditingController> get purchaseOrderControllers => [
        prOrderCodeController,
        prOrderDateController,
        prOrderSourceCodeController,
        prOrderFactoryController,
        prOrderNotesController,
        prOrderItemPriceController,
        prOrderQtyController,
        prOrderTotalQtyController,
        prOrderExpireDateController,
        prOrderDiscountPercentageController,
        prOrderDiscountValueController,
        prOrderItemheightController,
        prOrderItemWidthController,
        prOrderItemLengthController,
        prOrderDiscriptionController,
      ];
  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeNationalIdController =
      TextEditingController();
  final TextEditingController employeeJobTitleController =
      TextEditingController();
  final TextEditingController employeeDepartmentController =
      TextEditingController();
  final TextEditingController employeeEducationController =
      TextEditingController();
  final TextEditingController employeeEducationNameController =
      TextEditingController();
  final TextEditingController employeeGenderController =
      TextEditingController();
  final TextEditingController employeeSocialStatusController =
      TextEditingController();
  final TextEditingController employeePhoneNumberController =
      TextEditingController();
  final TextEditingController employeeWorkStartDateController =
      TextEditingController();
  final TextEditingController employeeAddressController =
      TextEditingController();

  final TextEditingController vacationStartDateController =
      TextEditingController();
  final TextEditingController vacationReturnDateController =
      TextEditingController();
  final TextEditingController remainingVacationsController =
      TextEditingController();
  final TextEditingController vacationDaysController = TextEditingController();
  final TextEditingController vacationNotesController = TextEditingController();
  final TextEditingController loanStartDateController = TextEditingController();
  final TextEditingController loanRequestDateController =
      TextEditingController();
  final TextEditingController numOfLoanAdvanceController =
      TextEditingController();
  final TextEditingController loanValueController = TextEditingController();
  final TextEditingController loanDaysController = TextEditingController();
  final TextEditingController loanNotesController = TextEditingController();
  final TextEditingController absenceDaysController = TextEditingController();
  final TextEditingController absenceDateFromController =
      TextEditingController();
  final TextEditingController absenceDateToController = TextEditingController();
  final TextEditingController vesselNotesController = TextEditingController();

  final TextEditingController abssenceNotesController = TextEditingController();
  final TextEditingController permissionDateFromController =
      TextEditingController();
  final TextEditingController permissionDateToController =
      TextEditingController();

  final TextEditingController permissionNotesController =
      TextEditingController();
  //attendance
  final TextEditingController attendanceTimingBLController =
      TextEditingController();
  final BoardDateTimeTextController attendanceBLTimeController =
      BoardDateTimeTextController();
  final BoardDateTimeTextController startAttendanceBLTimeController =
      BoardDateTimeTextController();
  final BoardDateTimeTextController departureBLTimeController =
      BoardDateTimeTextController();
  final BoardDateTimeTextController endAttendanceBLTimeController =
      BoardDateTimeTextController();
  final BoardDateTimeTextController startDepartureBLTimeController =
      BoardDateTimeTextController();
  final BoardDateTimeTextController endDepartureBLTimeController =
      BoardDateTimeTextController();
  List<TextEditingController> get attendanceControllers => [
        attendanceTimingBLController,
      ];
  List<TextEditingController> get permissionControllers => [
        permissionDateFromController,
        permissionDateToController,
        permissionNotesController,
      ];
  List<TextEditingController> get employeeControllers => [
        employeeCodeController,
        employeeNameController,
        employeeNationalIdController,
        employeeJobTitleController,
        employeeDepartmentController,
        employeeEducationController,
        employeeEducationNameController,
        employeeGenderController,
        employeeSocialStatusController,
        employeePhoneNumberController,
        employeeWorkStartDateController,
        employeeAddressController,
      ];

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
  List<TextEditingController> get vacationRequestControllers => [
        vacationStartDateController,
        vacationReturnDateController,
        remainingVacationsController,
        vacationDaysController,
        vacationNotesController,
      ];
  // Method to get the controller by field name
  List<TextEditingController> get loanRequestControllers => [
        loanStartDateController,
        loanRequestDateController,
        loanDaysController,
        numOfLoanAdvanceController,
        loanValueController,
        loanNotesController,
      ];
  // Method to get the controller by field name
  List<TextEditingController> get absenceRequestControllers => [
        absenceDateFromController,
        absenceDateToController,
        absenceDaysController,
        abssenceNotesController,
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
      addCollectionAdvPayController.text =
          paymentValuesEntity.advPay?.toString() ?? "0";
      addCollectionLatePayController.text =
          paymentValuesEntity.latePay?.toString() ?? "0";
      addCollectionCurrentFinanceController.text =
          paymentValuesEntity.current?.toString() ?? "0";
      addCollectionDiffrentFinanaceController.text =
          paymentValuesEntity.different?.toString() ?? "0";
//calcualte original total without divison and different
      /*    _originalTotal = (paymentValuesEntity.total! -
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
      } */
      _originalTotal = paymentValuesEntity.activity! +
          paymentValuesEntity.current! +
          paymentValuesEntity.compensation! +
          paymentValuesEntity.late! +
          paymentValuesEntity.different! +
          paymentValuesEntity.latePay! -
          paymentValuesEntity.advPay!;

      /* addCollectionTotalFinanceController.text = (_originalTotal +
              _previousDifferentFinance +
              _previousDivisionFinance)
          .toString(); */
      addCollectionTotalFinanceController.text = _originalTotal.toString();
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
    }
  }

  void clearControllers({required List<TextEditingController> controllers}) {
    for (var controller in controllers) {
      controller.clear();
    }
  }
}
