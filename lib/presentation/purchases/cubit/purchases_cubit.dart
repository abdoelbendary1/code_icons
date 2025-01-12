import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/items_detail.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/update_pr_invoice_request/update_pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/PR/Invoice/pr_invoice_entity.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/itemUom/item_Uom.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/entities/sysSettings/sys_settings_entity.dart';
import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';
import 'package:code_icons/domain/use_cases/purchase_request_usecase/purchase_request.useCase.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_state.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:code_icons/data/model/data_model/countryDM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/data/model/response/invoice/invoice_tax_dm.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/data/model/response/sysSettings/sys_settings.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/invoice/customers/invoice_customer_entity.dart';
import 'package:code_icons/domain/entities/invoice/drawer/drawer_entity.dart';
import 'package:code_icons/domain/use_cases/invoice/invoice.useCases.dart';
import 'package:code_icons/domain/use_cases/sysSettings/getSettingsUsecase.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class PurchasesCubit extends Cubit<PurchasesState> {
  PurchasesCubit() : super(PurchasesInitial());
  PurchaseRequestsUseCases purchaseRequestsUseCases = PurchaseRequestsUseCases(
      purchaseRequestRepo: injectPurchaseRequestRepo());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'birthDayBL': '',
    'licenseDateBL': '',
  };
  final accKey = GlobalKey<FormState>();
  FocusNode editItemFocusNode = FocusNode();
  SwipeActionController swipeActionController = SwipeActionController();

  List<StoreEntity> storeList = [];
  List<VendorsEntity> vendorsList = [];

  List<CostCenterEntity> costCenterList = [];
  List<SalesItemDm> itemsList = [];
  List<UomEntity> uomlist = [];
  List<InvoiceItemDetailsDm> selectedItemsList = [];
  List<SalesItemDm> itemDetails = [];
  List<GetAllPurchasesRequestEntity> allPurchases = [];
  List<ItemUomEntity> selectedItemUom = [];

  late String selectedStatus;

  late int selectedCode;
  late String? selectedName;
  late SalesItemUom? selectedUom;
  SalesItemDm selectedItem = SalesItemDm();
  List<SalesItemDm> selectedfilterdItemList = [];

  // Other methods...

  List<String?> get storeNamesList =>
      storeList.map((store) => store.storeNameAr).toList();
  List<String?> get costCenterNamesList =>
      costCenterList.map((costCenter) => costCenter.costcenterNameAr).toList();
  List<String?> get itemsNamesList =>
      itemsList.map((item) => item.itemNameAr).toList();
  List<String?> get uomNamesList =>
      selectedItemUom.map((item) => item.uom).toList();
  List<int?> get itemsCodesList =>
      itemsList.map((item) => item.itemCode1).toList();
  StoreEntity selectedStore = StoreEntity();
  String convertStringToDate({required String inputString}) {
    if (inputString.isNotEmpty) {
      DateFormat inputFormat = DateFormat('MMM d, y, h:mm:ss a');
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

  void selectUom({required String name}) {
    selectedUom = itemUomlist.firstWhere(
      (element) => element.uom == name,

      orElse: () => null as SalesItemUom, // Return null if no match is found
    );
  }

  final List<Map<String, dynamic>> tradeStatusTypes = [
    {'id': 0, 'name': "مستمر"},
    {'id': 1, 'name': "مقبول"},
    {'id': 2, 'name': "مرفوض"},
    /* {'id': 4, 'type': "فرع محافظة اخري"},
    {'id': 5, 'type': "رئيسي محافظة اخري"}, */
  ];
  List<String> tradeList = [];
  void fetchStatusList() {
    for (var element in tradeStatusTypes) {
      tradeList.add(element['name']);
    }
  }

  List<dynamic> purchases = [];
  int? getIdByName(String name, List<Map<String, dynamic>> list) {
    for (var item in list) {
      if (item['name'] == name) {
        return item['id'];
      }
    }
    return null; // Return null if the name is not found
  }

  Map<String, dynamic>? selectedTradeStatusType;
  /* void updateSelectedTradeStatusType(String value) {
    /*  emit(UpdateTradeStatusTypeLoading()); */
    selectedTradeStatusType['name'] = tradeStatusTypes[0];
    /* isSubBranchSelected = value?['type'] == "فرعي"; */
    /* emit(UpdateTradeStatusTypeSuccess(
        selectedTradeStatusType: selectedTradeStatusType)); */
  } */
  Widget getIconButton(color, icon) {
    return Container(
      width: 80.sp,
      height: 50.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [AppColors.redColor, AppColors.lightRedColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        /// set you real bg color in your content
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  void saveSelectedItem() {
    if (formKeyItems.currentState!.validate()) {
      double unitPrice = calcUnitPriceforOneItem(_parseControllerText(
          ControllerManager().prUnitPriceController,
          defaultValue: 0.0))!;

      ///تعديل
/*       unitPrice = double.parse(unitPrice.toStringAsFixed(2));
 */
      double qty = _parseControllerText(
          ControllerManager().prQuantityController,
          defaultValue: 1.0);

      double discountValue = _parseControllerText(
          ControllerManager().prDiscountValueController,
          defaultValue: 0.0);
      double totalPrice = qty * unitPrice - discountValue;
      double alltaxesvalue = qty *
          (calculateTaxForPriceIncudesTax(
              _parseControllerText(ControllerManager().prUnitPriceController),
              taxPercentageForOneItem));
      totalPrice = double.parse(totalPrice.toStringAsFixed(2));
      alltaxesvalue = double.parse(alltaxesvalue.toStringAsFixed(2));
      unitPrice = double.parse(unitPrice.toStringAsFixed(2));

      var selectedItemDetails = InvoiceItemDetailsDm(
        description:
            ControllerManager().prInvoiceDescriptionController.text.isNotEmpty
                ? ControllerManager().prInvoiceDescriptionController.text
                : "", // Only include if not empty
        /*  id: selectedItem.itemId?.toString() ?? "", // Ensure valid ID as String */
        itemCode1: selectedItem.itemCode1 ?? 0, // Ensure valid item code
        itemNameAr: selectedItem.itemId, // Ensure itemNameAr is a String
        qty: qty, // Ensure valid double
        uom: selectedUom?.uomId ?? 1, // Ensure valid UOM
        length: double.tryParse(
            ControllerManager().prLengthController.text), // Ensure valid double
        width: double.tryParse(ControllerManager().prWidthController.text) ??
            0.0, // Ensure valid double
        height: double.tryParse(ControllerManager().prHeightController.text) ??
            0.0, // Ensure valid double
        precentage: double.tryParse(
                ControllerManager().prDiscountRateController.text) ??
            0.0, // Ensure valid double
        precentagevalue: double.tryParse(
                ControllerManager().prDiscountValueController.text) ??
            0.0, // Ensure valid double
        prprice: double.tryParse(ControllerManager()
            .prUnitPriceController
            .text), // Ensure valid double
        currentQty: double.tryParse(
                ControllerManager().prAvailableQuantityController.text) ??
            0.0, // Ensure valid double
        allQtyValue: ControllerManager()
            .prTotalQuantityController
            .text, // Ensure valid double
        alltaxesvalue: alltaxesvalue, // Ensure valid double
        totalprice: totalPrice.toString(), // Ensure it's a String and not null
        // Ensure it's a String or handle appropriately
      );
      selectedItemsList.add(selectedItemDetails);

      // Update the total invoice calculation

      totalInvoice = double.tryParse(
              ControllerManager().prinvoiceTotalPriceController.text) ??
          0.0;
      totalInvoice += totalPrice;
      ControllerManager().prinvoiceTotalPriceController.text =
          totalInvoice.toStringAsFixed(2);
      totalTax = double.tryParse(
              ControllerManager().prinvoiceTotalTaxesController.text) ??
          0.0;
      totalTax += qty *
          (calculateTaxForPriceIncudesTax(
              _parseControllerText(ControllerManager().prUnitPriceController),
              taxPercentageForOneItem));
      /*  totalTax +=
          double.tryParse(ControllerManager().salesTotalTaxesController.text) ??
              0.0; */
      ControllerManager().prinvoiceTotalTaxesController.text =
          totalTax.toStringAsFixed(2);
      value =
          double.tryParse(ControllerManager().prinvoiceNetController.text) ??
              0.0;
      value = totalInvoice + totalTax;
      ControllerManager().prinvoiceNetController.text =
          value.toStringAsFixed(2);
      ControllerManager().prinvoicePaidController.text =
          value.toStringAsFixed(2);

      totalPrices.add(qty * unitPrice - discountValue);
      totalTaxes.add(
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0);
      totalPaidValues.add(
          double.tryParse(ControllerManager().prPriceController.text) ?? 0.0);
      itemsTaxesRelations
          .addAll(selectedItem.itemTaxsRelation as Iterable<ItemTaxsRelation>);
      clearDiscounts();
      emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
    }
  }

  List<InvoiceReportDm> returns = [];

  final PagingController<int, InvoiceReportDm> pagingController =
      PagingController(firstPageKey: 0);
  void getCustomerInvoices(int id) {
    emit(GetAllInvoicesLoading());
    List<InvoiceReportDm> customerReturns =
        returns.where((element) => element.customer == id).toList();

    // Clear previous data in paging controller
    pagingController.itemList?.clear(); // Ensure old data is cleared

    // Emit updated data
    emit(GetCustomerInvoicesSuccess(invoices: customerReturns));
  }

  /*  void saveSelectedItem() {
    if (formKeyItems.currentState!.validate()) {
      var selectedItemDetails = InvoiceItemDetailsDm(
        description:
            ControllerManager().prInvoiceDescriptionController.text.isNotEmpty
                ? ControllerManager().prInvoiceDescriptionController.text
                : "", // Only include if not empty
        id: selectedItem.itemId?.toString() ?? "", // Ensure valid ID as String
        itemCode1: selectedItem.itemCode1 ?? 0, // Ensure valid item code
        itemNameAr: selectedItem.itemId, // Ensure itemNameAr is a String
        qty: double.tryParse(ControllerManager().prQuantityController.text) ??
            1.0, // Ensure valid double
        uom: selectedUom?.uomId ?? 1, // Ensure valid UOM
        length: _parseControllerText(ControllerManager().prLengthController,
            defaultValue: 1.0), // Ensure valid double
        width: _parseControllerText(ControllerManager().prWidthController,
            defaultValue: 1.0), // Ensure valid double
        height: _parseControllerText(ControllerManager().prHeightController,
            defaultValue: 1.0), // Ensure valid double
        precentage: double.tryParse(
                ControllerManager().prDiscountRateController.text) ??
            0.0, // Ensure valid double
        precentagevalue: double.tryParse(
                ControllerManager().prDiscountValueController.text) ??
            0.0, // Ensure valid double
        prprice:
            double.tryParse(ControllerManager().prUnitPriceController.text) ??
                0.0, // Ensure valid double
        currentQty: double.tryParse(
                ControllerManager().prAvailableQuantityController.text) ??
            0.0, // Ensure valid double
        allQtyValue: ControllerManager()
            .prTotalQuantityController
            .text, // Ensure valid double
        alltaxesvalue:
            double.tryParse(ControllerManager().prTotalTaxesController.text) ??
                0.0, // Ensure valid double
        totalprice: double.tryParse(ControllerManager().prPriceController.text)
                ?.toStringAsFixed(2) ??
            "0.00", // Ensure it's a String and not null
        // Ensure it's a String or handle appropriately
      );

      // Update the total invoice calculation
      double unitPrice = calcUnitPriceforOneItem(selectedItem.smallUOMprPrice)!;
      double qty = _parseControllerText(
          ControllerManager().prQuantityController,
          defaultValue: 1.0);

      double discountValue = _parseControllerText(
          ControllerManager().prDiscountValueController,
          defaultValue: 0.0);

      totalInvoice = double.tryParse(
              ControllerManager().prinvoiceTotalPriceController.text) ??
          0.0;
      totalInvoice += qty * unitPrice - discountValue;
      ControllerManager().prinvoiceTotalPriceController.text =
          totalInvoice.toStringAsFixed(1);
      totalTax = double.tryParse(
              ControllerManager().prinvoiceTotalTaxesController.text) ??
          0.0;
      totalTax +=
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0;
      ControllerManager().prinvoiceTotalTaxesController.text =
          totalTax.toStringAsFixed(1);
      value =
          double.tryParse(ControllerManager().prinvoiceNetController.text) ??
              0.0;
      value = totalInvoice + totalTax;
      ControllerManager().prinvoiceNetController.text =
          value.toStringAsFixed(1);
      totalPrices.add(qty * unitPrice - discountValue);
      totalTaxes.add(
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0);
      totalPaidValues.add(
          double.tryParse(ControllerManager().prPriceController.text) ?? 0.0);
      selectedItemsList.add(selectedItemDetails);
      itemsTaxesRelations
          .addAll(selectedItem.itemTaxsRelation as Iterable<ItemTaxsRelation>);
      clearDiscounts();
      emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
    }
  }
 */
  void editSelectedItem(int index) {
    if (formKeyItems.currentState!.validate()) {
      var selectedItemDetails = InvoiceItemDetailsDm(
        description:
            ControllerManager().prInvoiceDescriptionController.text.isNotEmpty
                ? ControllerManager().prInvoiceDescriptionController.text
                : "", // Only include if not empty
        id: selectedItem.itemId?.toString() ?? "", // Ensure valid ID as String
        itemCode1: selectedItem.itemCode1 ?? 0, // Ensure valid item code
        itemNameAr: selectedItem.itemId, // Ensure itemNameAr is a String
        qty: double.tryParse(ControllerManager().prQuantityController.text) ??
            1.0, // Ensure valid double
        uom: selectedUom?.uomId ?? 1, // Ensure valid UOM
        length: double.tryParse(ControllerManager()
            .salesLengthController
            .text), // Ensure valid double
        width: double.tryParse(ControllerManager().prWidthController.text) ??
            0.0, // Ensure valid double
        height: double.tryParse(ControllerManager().prHeightController.text) ??
            0.0, // Ensure valid double
        precentage: double.tryParse(
                ControllerManager().prDiscountRateController.text) ??
            0.0, // Ensure valid double
        precentagevalue: double.tryParse(
                ControllerManager().prDiscountValueController.text) ??
            0.0, // Ensure valid double
        prprice:
            double.tryParse(ControllerManager().prUnitPriceController.text) ??
                0.0, // Ensure valid double
        currentQty: double.tryParse(
                ControllerManager().prAvailableQuantityController.text) ??
            0.0, // Ensure valid double
        allQtyValue: ControllerManager()
            .prTotalQuantityController
            .text, // Ensure valid double
        alltaxesvalue:
            double.tryParse(ControllerManager().prTotalTaxesController.text) ??
                0.0, // Ensure valid double
        totalprice: double.tryParse(ControllerManager().prPriceController.text)
                ?.toStringAsFixed(2) ??
            "0.00", // Ensure it's a String and not null
        // Ensure it's a String or handle appropriately
      );

      // Update the total invoice calculation
      List<double> totalPricesfromData = [];
      for (var e in selectedItemsList) {
        totalPricesfromData.add(double.parse(e.totalprice!) ?? 0.0);
      }

      totalPrices = totalPricesfromData;
      totalPrices[index] =
          double.tryParse(ControllerManager().prPriceController.text) ?? 0.0;
      totalInvoice = totalPrices.reduce((a, b) => a + b);
      totalInvoice = double.parse(totalInvoice.toStringAsFixed(2));

      /* totalInvoice +=
          double.tryParse(ControllerManager().prPriceController.text) ?? 0.0; */
      ControllerManager().prinvoiceTotalPriceController.text =
          totalInvoice.toString();

      totalTaxes[index] =
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0;
      totalTax = totalTaxes.reduce((a, b) => a + b);
      totalTax = double.parse(totalTax.toStringAsFixed(2));

      ControllerManager().prinvoiceTotalTaxesController.text =
          totalTax.toString();
      List<double> totalPiadfromData = [];
      for (var e in selectedItemsList) {
        totalPiadfromData.add(e.prprice ?? 0.0);
      }

      var valuePaid = totalTax + totalInvoice;
      /*  var valuePaid = totalPaidValues.reduce((a, b) => a + b); */

      ControllerManager().prinvoiceNetController.text = valuePaid.toString();
      ControllerManager().prinvoicePaidController.text = valuePaid.toString();

      selectedItemsList[index] = selectedItemDetails;
      clearDiscounts();
      emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
    }
  }

  /*  void saveSelectedItem() {
    var selectedItemDetails = InvoiceItemDetailsDm(
      description: ControllerManager().prInvoiceDescriptionController.text,
      id: selectedItem.itemId.toString(),
      itemCode1: selectedItem.itemCode1,
      itemNameAr: selectedItem.itemId,
      qty: double.tryParse(
          ControllerManager().prQuantityController.text),
      uom: selectedUom!.uomId!,
    );
    selectedItemsList.add(selectedItemDetails);

    emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
    /*  emit(PurchasesInitial()); */
  }
 */
  String convertToDateString(String input) {
    try {
      DateTime dateTime = DateTime.parse(input);
      String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      return 'Invalid date format';
    }
  }

  /*  PurchaseRequestDataModel savePR() {
    return PurchaseRequestDataModel(
      itemsDetails: selectedItemsList,
      date: ControllerManager().purchaseDateController.text,
      /*  status: getIdByName(selectedStatus, tradeStatusTypes).toString(), */
      storeId: selectedStore.storeId,
    );
  } */

  void addItem() {
    emit(AddPurchasesItemloading());
    /* selectedItemsList.add(selectedItem); */
  }

  /* void getPurchasesList() {
    emit(GetPurchasesListloading());
    emit(GetPurchasesListSuccess(purchases: purchases));
  }
 */
  /*  void saveItem() {
    emit(AddPurchasesItemSuccess());
    emit(PurchasesInitial());
  } */

  /*  StoreEntity selectStore({required String name}) {
    return selectedStore =
        storeList.where((element) => element.storeNameAr == name).first;
  }
 */
  void selectName({required String name}) {
    selectedName = itemsList
        .where((element) => element.itemNameAr == name)
        .first
        .itemNameAr!;
  }

  void clearItemConroller() {
    ControllerManager().purchaseItemQuantitytemController.clear();
    ControllerManager().purchaseItemDiscriptionController.clear();
  }

/*   void selectUom({required String name}) {
    selectedUom = uomlist.firstWhere((element) => element.uom == name).uomId!;
  } */

  void fetchVendors() async {
    var either = await purchaseRequestsUseCases.fetchVendors();
    either.fold((l) {
      print(l.errorMessege);
      emit(getStoreDataError(errorMsg: l.errorMessege));
    }, (r) {
      vendorsList = r;

      /*  emit(getStoreDataSuccess(storeDataList: r));
      emit(PurchasesInitial()); */
    });
  }

  void getStoreData() async {
    var either = await invoiceUseCases.fetchStoreData();
    either.fold((l) {
      print(l.errorMessege);
      if (!isClosed) {
        emit(getStoreDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      storeList = r;
      /*   if (!isClosed) {
        emit(getStoreDataSuccess(storeDataList: r));
        emit(GetAllDatSuccess());
      } */
    });
  }

  void getCostCenterData() async {
    var either = await purchaseRequestsUseCases.fetchCostCenterData();
    either.fold((l) => emit(getCostCenterError(errorMsg: l.errorMessege)), (r) {
      costCenterList = r;

      emit(getCostCenterSuccess(costCenterList: r));
      emit(PurchasesInitial());
    });
  }

/*   void fetchUom() async {
    var either = await purchaseRequestsUseCases.fetchUOMData();
    either.fold((l) => emit(getUomDataError(errorMsg: l.errorMessege)), (r) {
      uomlist = r;
      emit(GetUomDatSuccess(uomList: r));
      emit(PurchasesInitial());
    });
  } */

  void fetchProductInfoDatalists() {
    getStoreData();
    getCostCenterData();
  }

  /*  void getItemsData() async {
    emit(PurchasesItemSelectedLoading());
    var either = await purchaseRequestsUseCases.fetchPurchaseItemData();
    either.fold((l) => emit(getStoreDataError(errorMsg: l.errorMessege)), (r) {
      itemsList = r;
      emit(PurchasesItemSelected(selectedItem));

      /* emit(PurchasesInitial()); */
    });
  } */

  void getItemByID({required int id}) async {
    emit(GetPurchasesListloading());
    var either = await invoiceUseCases.fetchPurchaseItemDataByID(id: id);
    either.fold((l) {
      emit(getItemDataByIDError(errorMsg: l.errorMessege));
    }, (r) {
      itemUomlist = r.itemUom ?? [];
      selectedUom = r.itemUom?.first;

      /*  r.itemTaxsRelation = selctedItemTaxsRelation;
      if (r.itemTaxsRelation!.isNotEmpty) {
        for (ItemTaxsRelation element in selctedItemTaxsRelation!) {
          selectedTaxesforItem += element.percentage!;
        }
/*         getTaxByid(id: r.itemTaxsRelation!.first.eTaxId!);
 */
      } */
      emit(GetAllDatSuccess());
      updateControllersWithPurchaseItemData(r);
      emit(getItemDataByIDSuccess(salesItemDm: r));
      /* emit(PurchasesItemSelected(r)); */
    });
  }

  void postReturnReport({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      var one = _parseControllerText(ControllerManager().invoicePaidController);
      var two = _parseControllerText(ControllerManager().invoiceNetController);
      if (_parseControllerText(ControllerManager().invoicePaidController) >
          _parseControllerText(ControllerManager().invoiceNetController)) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "لا يمكن دفع اكثر من الصافى",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else if (selectedItemsList.isEmpty) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "برجاء ادخال اصناف",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else if (!(_parseControllerText(
              ControllerManager().invoiceNetController) >
          0)) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "لا يمكن اضافه الفاتوره ",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else {
        emit(SalesInvoiceLoading());
        var either =
            await invoiceUseCases.postPrReturnReport(invoiceReportDm: savePR());
        print("selectedCustomer.cusNameAr: ${selectedCustomer.cusNameAr}");
        either.fold((l) {
          print(l.errorMessege);
          emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
          Navigator.pop(context);
          Navigator.pop(context);
          QuickAlert.show(
            animType: QuickAlertAnimType.slideInUp,
            context: context,
            type: QuickAlertType.error,
            showConfirmBtn: false,
            title: "حدث خطأ ما",
            titleColor: AppColors.redColor,
            /* text: state.errorMsg, */
          );
        }, (r) {
          print("id : $r");
          emit(AddPurchasesReturnSuccess(invoiceId: r));
        });
      }
    } else {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInUp,
        context: context,
        type: QuickAlertType.error,
        showConfirmBtn: false,
        title: "برجاء ادخال جميع البيانات",
        titleColor: AppColors.redColor,
        /* text: state.errorMsg, */
      );
    }
  }

  void deletePRByID({required int id}) async {
    var either =
        await purchaseRequestsUseCases.deletePurchaseRequestById(id: id);
    either.fold((l) => emit(DeletePRbyIDError(errorMsg: l.errorMessege)), (r) {
      emit(DeletePRbyIDSuccess(purchasesRequestEntity: r));

      /* emit(PurchasesInitial()); */
    });
  }

  void getPRbyID({required int id}) async {
    var either =
        await purchaseRequestsUseCases.fetchPurchaseRequestById(id: id);
    either.fold((l) => emit(GetPRbyIDError(errorMsg: l.errorMessege)), (r) {
      emit(GetPRbyIDSuccess(purchasesRequestEntity: r));

      /* emit(PurchasesInitial()); */
    });
  }

  /*  void selectItem({
    int? code,
    String? name,
  }) {
    emit(PurchasesItemSelectedLoading());

    if (code != null) {
      // Filter items by code
      var filteredByCode =
          itemsList.where((element) => element.itemCode1 == code).toList();

      if (filteredByCode.isNotEmpty) {
        // Select the first item found by code
        selectedItem = filteredByCode.first;
        selectedfilterdItemList = filteredByCode;
        selectedItemUom = selectedItem.itemUom!;
        emit(PurchasesItemSelected(selectedItem));
      } else {
        // Handle case when no item is found by code
        /*  emit(PurchasesItemSelectedError("No item found with code $code")); */
      }
    } else if (name != null) {
      // Filter items by name
      var filteredByName =
          itemsList.where((element) => element.itemNameAr == name).toList();

      if (filteredByName.isNotEmpty) {
        // Select the last item found by name
        selectedItem = filteredByName.first;
        selectedfilterdItemList = filteredByName;
        selectedItemUom = selectedItem.itemUom!;

        emit(PurchasesItemSelected(selectedItem));
      } else {
        // Handle case when no item is found by name
/*       emit(PurchasesItemSelectedError("No item found with name $name"));
 */
      }
    } else {
      // Handle case when neither code nor name is provided
/*     emit(PurchasesItemSelectedError("No search criteria provided"));
 */
    }
  }
 */
  void addPurchaseRequest({required BuildContext context}) {
    if (formKey.currentState!.validate()) {
      /*  purchaseRequestsUseCases.postPurchaseRequest(
          purchaseRequestDataModel: savePR()); */
      emit(AddPurchasesRequestSuccess());
    } else {
      SnackBarUtils.showSnackBar(
        context: context,
        label: "برجاء ادخال جميع البيانات",
        backgroundColor: AppColors.redColor,
      );
      /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "برجاء ادخال جميع البيانات",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.redColor,
        duration: Durations.extralong1,
      )); */
    }
  }

  fetchAllPurchaseRequests() async {
    var either = await purchaseRequestsUseCases.fetchAllPurchaseRequests();
    either.fold((l) => emit(GetPurchasesListError(errorMsg: l.errorMessege)),
        (r) {
      allPurchases = r;

      emit(GetPurchasesListSuccess(purchases: r));
    });
  }

  InvoiceUseCases invoiceUseCases =
      InvoiceUseCases(invoiceInterface: injectInvoiceInterface());

  GetSysSettingUSecase getSysSettingUSecase =
      GetSysSettingUSecase(iSysSettings: injectISysSettings());

  final formKeyItems = GlobalKey<FormState>();
  final formKeyAddCustomer = GlobalKey<FormState>();

  List<SalesItemUom> itemUomlist = [];

  List<CurrencyEntity> currencyList = [];
  List<DrawerEntity> drawerEntityList = [];
  DrawerEntity selectedDrawerEntity = DrawerEntity();

  String selectedPaymentType = "أجل";

  InvoiceCustomerEntity selectedCustomer = InvoiceCustomerEntity(id: 3);
  VendorsEntity selectedVendor = VendorsEntity();

  CostCenterEntity selectedCostCenter = CostCenterEntity();
  CurrencyEntity selectedCurrency = CurrencyEntity();
  String countryCode = "";

  String? getNameByID(int id, List<Map<String, dynamic>> list) {
    for (var item in list) {
      if (item['id'] == id) {
        return item['name'];
      }
    }
    return null;
  }

  List<Country> listOfCountries() {
    final List<Map<String, dynamic>> jsonData = [
      {"code": "AD", "name": "أندورا", "dialCode": "+376"},
      {"code": "AE", "name": "الامارات العربية المتحدة", "dialCode": "+971"},
      {"code": "AF", "name": "أفغانستان", "dialCode": "+93"},
      {"code": "AG", "name": "أنتيجوا وبربودا", "dialCode": "+1"},
      {"code": "AI", "name": "أنجويلا", "dialCode": "+1"},
      {"code": "AL", "name": "ألبانيا", "dialCode": "+355"},
      {"code": "AM", "name": "أرمينيا", "dialCode": "+374"},
      {"code": "AO", "name": "أنجولا", "dialCode": "+244"},
      {"code": "AQ", "name": "القطب الجنوبي", "dialCode": "+672"},
      {"code": "AR", "name": "الأرجنتين", "dialCode": "+54"},
      {"code": "AS", "name": "ساموا الأمريكية", "dialCode": "+1"},
      {"code": "AT", "name": "النمسا", "dialCode": "+43"},
      {"code": "AU", "name": "أستراليا", "dialCode": "+61"},
      {"code": "AW", "name": "آروبا", "dialCode": "+297"},
      {"code": "AX", "name": "جزر أولان", "dialCode": "+358"},
      {"code": "AZ", "name": "أذربيجان", "dialCode": "+994"},
      {"code": "BA", "name": "البوسنة والهرسك", "dialCode": "+387"},
      {"code": "BB", "name": "بربادوس", "dialCode": "+1"},
      {"code": "BD", "name": "بنجلاديش", "dialCode": "+880"},
      {"code": "BE", "name": "بلجيكا", "dialCode": "+32"},
      {"code": "BF", "name": "بوركينا فاسو", "dialCode": "+226"},
      {"code": "BG", "name": "بلغاريا", "dialCode": "+359"},
      {"code": "BH", "name": "البحرين", "dialCode": "+973"},
      {"code": "BI", "name": "بوروندي", "dialCode": "+257"},
      {"code": "BJ", "name": "بنين", "dialCode": "+229"},
      {"code": "BL", "name": "سان بارتيلمي", "dialCode": "+590"},
      {"code": "BM", "name": "برمودا", "dialCode": "+1"},
      {"code": "BN", "name": "بروناي", "dialCode": "+673"},
      {"code": "BO", "name": "بوليفيا", "dialCode": "+591"},
      {"code": "BQ", "name": "بونير", "dialCode": "+599"},
      {"code": "BR", "name": "البرازيل", "dialCode": "+55"},
      {"code": "BS", "name": "الباهاما", "dialCode": "+1"},
      {"code": "BT", "name": "بوتان", "dialCode": "+975"},
      {"code": "BV", "name": "جزيرة بوفيه", "dialCode": "+47"},
      {"code": "BW", "name": "بتسوانا", "dialCode": "+267"},
      {"code": "BY", "name": "روسيا البيضاء", "dialCode": "+375"},
      {"code": "BZ", "name": "بليز", "dialCode": "+501"},
      {"code": "CA", "name": "كندا", "dialCode": "+1"},
      {"code": "CC", "name": "جزر كوكوس", "dialCode": "+61"},
      {"code": "CD", "name": "جمهورية الكونغو الديمقراطية", "dialCode": "+243"},
      {"code": "CF", "name": "جمهورية افريقيا الوسطى", "dialCode": "+236"},
      {"code": "CG", "name": "الكونغو - برازافيل", "dialCode": "+242"},
      {"code": "CH", "name": "سويسرا", "dialCode": "+41"},
      {"code": "CI", "name": "ساحل العاج", "dialCode": "+225"},
      {"code": "CK", "name": "جزر كوك", "dialCode": "+682"},
      {"code": "CL", "name": "شيلي", "dialCode": "+56"},
      {"code": "CM", "name": "الكاميرون", "dialCode": "+237"},
      {"code": "CN", "name": "الصين", "dialCode": "+86"},
      {"code": "CO", "name": "كولومبيا", "dialCode": "+57"},
      {"code": "CR", "name": "كوستاريكا", "dialCode": "+506"},
      {"code": "CU", "name": "كوبا", "dialCode": "+53"},
      {"code": "CV", "name": "الرأس الأخضر", "dialCode": "+238"},
      {"code": "CW", "name": "كوراساو", "dialCode": "+599"},
      {"code": "CX", "name": "جزيرة الكريسماس", "dialCode": "+61"},
      {"code": "CY", "name": "قبرص", "dialCode": "+357"},
      {"code": "CZ", "name": "جمهورية التشيك", "dialCode": "+420"},
      {"code": "DE", "name": "ألمانيا", "dialCode": "+49"},
      {"code": "DJ", "name": "جيبوتي", "dialCode": "+253"},
      {"code": "DK", "name": "الدانمرك", "dialCode": "+45"},
      {"code": "DM", "name": "دومينيكا", "dialCode": "+1"},
      {"code": "DO", "name": "جمهورية الدومينيك", "dialCode": "+1"},
      {"code": "DZ", "name": "الجزائر", "dialCode": "+213"},
      {"code": "EC", "name": "الاكوادور", "dialCode": "+593"},
      {"code": "EE", "name": "استونيا", "dialCode": "+372"},
      {"code": "EG", "name": "مصر", "dialCode": "+20"},
      {"code": "EH", "name": "الصحراء الغربية", "dialCode": "+212"},
      {"code": "ER", "name": "اريتريا", "dialCode": "+291"},
      {"code": "ES", "name": "أسبانيا", "dialCode": "+34"},
      {"code": "ET", "name": "اثيوبيا", "dialCode": "+251"},
      {"code": "FI", "name": "فنلندا", "dialCode": "+358"},
      {"code": "FJ", "name": "فيجي", "dialCode": "+679"},
      {"code": "FK", "name": "جزر فوكلاند", "dialCode": "+500"},
      {"code": "FM", "name": "ميكرونيزيا", "dialCode": "+691"},
      {"code": "FO", "name": "جزر فارو", "dialCode": "+298"},
      {"code": "FR", "name": "فرنسا", "dialCode": "+33"},
      {"code": "GA", "name": "الجابون", "dialCode": "+241"},
      {"code": "GB", "name": "المملكة المتحدة", "dialCode": "+44"},
      {"code": "GD", "name": "جرينادا", "dialCode": "+1"},
      {"code": "GE", "name": "جورجيا", "dialCode": "+995"},
      {"code": "GF", "name": "غويانا", "dialCode": "+594"},
      {"code": "GG", "name": "غيرنزي", "dialCode": "+44"},
      {"code": "GH", "name": "غانا", "dialCode": "+233"},
      {"code": "GI", "name": "جبل طارق", "dialCode": "+350"},
      {"code": "GL", "name": "جرينلاند", "dialCode": "+299"},
      {"code": "GM", "name": "غامبيا", "dialCode": "+220"},
      {"code": "GN", "name": "غينيا", "dialCode": "+224"},
      {"code": "GP", "name": "جوادلوب", "dialCode": "+590"},
      {"code": "GQ", "name": "غينيا الاستوائية", "dialCode": "+240"},
      {"code": "GR", "name": "اليونان", "dialCode": "+30"},
      {
        "code": "GS",
        "name": "جورجيا الجنوبية وجزر ساندويتش الجنوبية",
        "dialCode": "+500"
      },
      {"code": "GT", "name": "جواتيمالا", "dialCode": "+502"},
      {"code": "GU", "name": "جوام", "dialCode": "+1"},
      {"code": "GW", "name": "غينيا بيساو", "dialCode": "+245"},
      {"code": "GY", "name": "غيانا", "dialCode": "+595"},
      {"code": "HK", "name": "هونج كونج الصينية", "dialCode": "+852"},
      {"code": "HN", "name": "هندوراس", "dialCode": "+504"},
      {"code": "HR", "name": "كرواتيا", "dialCode": "+385"},
      {"code": "HT", "name": "هايتي", "dialCode": "+509"},
      {"code": "HU", "name": "المجر", "dialCode": "+36"},
      {"code": "ID", "name": "اندونيسيا", "dialCode": "+62"},
      {"code": "IE", "name": "أيرلندا", "dialCode": "+353"},
      {"code": "IL", "name": "اسرائيل", "dialCode": "+972"},
      {"code": "IM", "name": "جزيرة مان", "dialCode": "+44"},
      {"code": "IN", "name": "الهند", "dialCode": "+91"},
      {"code": "IO", "name": "المحيط الهندي البريطاني", "dialCode": "+246"},
      {"code": "IQ", "name": "العراق", "dialCode": "+964"},
      {"code": "IR", "name": "ايران", "dialCode": "+98"},
      {"code": "IS", "name": "أيسلندا", "dialCode": "+354"},
      {"code": "IT", "name": "ايطاليا", "dialCode": "+39"},
      {"code": "JE", "name": "جيرسي", "dialCode": "+44"},
      {"code": "JM", "name": "جامايكا", "dialCode": "+1"},
      {"code": "JO", "name": "الأردن", "dialCode": "+962"},
      {"code": "JP", "name": "اليابان", "dialCode": "+81"},
      {"code": "KE", "name": "كينيا", "dialCode": "+254"},
      {"code": "KG", "name": "قرغيزستان", "dialCode": "+996"},
      {"code": "KH", "name": "كمبوديا", "dialCode": "+855"},
      {"code": "KI", "name": "كيريباتي", "dialCode": "+686"},
      {"code": "KM", "name": "جزر القمر", "dialCode": "+269"},
      {"code": "KN", "name": "سانت كيتس ونيفيس", "dialCode": "+1"},
      {"code": "KP", "name": "كوريا الشمالية", "dialCode": "+850"},
      {"code": "KR", "name": "كوريا الجنوبية", "dialCode": "+82"},
      {"code": "KW", "name": "الكويت", "dialCode": "+965"},
      {"code": "KY", "name": "جزر الكايمن", "dialCode": "+345"},
      {"code": "KZ", "name": "كازاخستان", "dialCode": "+7"},
      {"code": "LA", "name": "لاوس", "dialCode": "+856"},
      {"code": "LB", "name": "لبنان", "dialCode": "+961"},
      {"code": "LC", "name": "سانت لوسيا", "dialCode": "+1"},
      {"code": "LI", "name": "ليختنشتاين", "dialCode": "+423"},
      {"code": "LK", "name": "سريلانكا", "dialCode": "+94"},
      {"code": "LR", "name": "ليبيريا", "dialCode": "+231"},
      {"code": "LS", "name": "ليسوتو", "dialCode": "+266"},
      {"code": "LT", "name": "ليتوانيا", "dialCode": "+370"},
      {"code": "LU", "name": "لوكسمبورج", "dialCode": "+352"},
      {"code": "LV", "name": "لاتفيا", "dialCode": "+371"},
      {"code": "LY", "name": "ليبيا", "dialCode": "+218"},
      {"code": "MA", "name": "المغرب", "dialCode": "+212"},
      {"code": "MC", "name": "موناكو", "dialCode": "+377"},
      {"code": "MD", "name": "مولدافيا", "dialCode": "+373"},
      {"code": "ME", "name": "الجبل الأسود", "dialCode": "+382"},
      {"code": "MF", "name": "سانت مارتين", "dialCode": "+590"},
      {"code": "MG", "name": "مدغشقر", "dialCode": "+261"},
      {"code": "MH", "name": "جزر المارشال", "dialCode": "+692"},
      {"code": "MK", "name": "مقدونيا", "dialCode": "+389"},
      {"code": "ML", "name": "مالي", "dialCode": "+223"},
      {"code": "MM", "name": "ميانمار", "dialCode": "+95"},
      {"code": "MN", "name": "منغوليا", "dialCode": "+976"},
      {"code": "MO", "name": "ماكاو الصينية", "dialCode": "+853"},
      {"code": "MP", "name": "جزر ماريانا الشمالية", "dialCode": "+1"},
      {"code": "MQ", "name": "مارتينيك", "dialCode": "+596"},
      {"code": "MR", "name": "موريتانيا", "dialCode": "+222"},
      {"code": "MS", "name": "مونتسرات", "dialCode": "+1"},
      {"code": "MT", "name": "مالطا", "dialCode": "+356"},
      {"code": "MU", "name": "موريشيوس", "dialCode": "+230"},
      {"code": "MV", "name": "جزر الملديف", "dialCode": "+960"},
      {"code": "MW", "name": "ملاوي", "dialCode": "+265"},
      {"code": "MX", "name": "المكسيك", "dialCode": "+52"},
      {"code": "MY", "name": "ماليزيا", "dialCode": "+60"},
      {"code": "MZ", "name": "موزمبيق", "dialCode": "+258"},
      {"code": "NA", "name": "ناميبيا", "dialCode": "+264"},
      {"code": "NC", "name": "كاليدونيا الجديدة", "dialCode": "+687"},
      {"code": "NE", "name": "النيجر", "dialCode": "+227"},
      {"code": "NF", "name": "جزيرة نورفوك", "dialCode": "+672"},
      {"code": "NG", "name": "نيجيريا", "dialCode": "+234"},
      {"code": "NI", "name": "نيكاراجوا", "dialCode": "+505"},
      {"code": "NL", "name": "هولندا", "dialCode": "+31"},
      {"code": "NO", "name": "النرويج", "dialCode": "+47"},
      {"code": "NP", "name": "نيبال", "dialCode": "+977"},
      {"code": "NR", "name": "نورو", "dialCode": "+674"},
      {"code": "NU", "name": "نيوي", "dialCode": "+683"},
      {"code": "NZ", "name": "نيوزيلاندا", "dialCode": "+64"},
      {"code": "OM", "name": "عمان", "dialCode": "+968"},
      {"code": "PA", "name": "بنما", "dialCode": "+507"},
      {"code": "PE", "name": "بيرو", "dialCode": "+51"},
      {"code": "PF", "name": "بولينيزيا الفرنسية", "dialCode": "+689"},
      {"code": "PG", "name": "بابوا غينيا الجديدة", "dialCode": "+675"},
      {"code": "PH", "name": "الفيلبين", "dialCode": "+63"},
      {"code": "PK", "name": "باكستان", "dialCode": "+92"},
      {"code": "PL", "name": "بولندا", "dialCode": "+48"},
      {"code": "PM", "name": "سانت بيير وميكولون", "dialCode": "+508"},
      {"code": "PN", "name": "بتكايرن", "dialCode": "+872"},
      {"code": "PR", "name": "بورتوريكو", "dialCode": "+1"},
      {"code": "PS", "name": "فلسطين", "dialCode": "+970"},
      {"code": "PT", "name": "البرتغال", "dialCode": "+351"},
      {"code": "PW", "name": "بالاو", "dialCode": "+680"},
      {"code": "PY", "name": "باراجواي", "dialCode": "+595"},
      {"code": "QA", "name": "قطر", "dialCode": "+974"},
      {"code": "RE", "name": "روينيون", "dialCode": "+262"},
      {"code": "RO", "name": "رومانيا", "dialCode": "+40"},
      {"code": "RS", "name": "صربيا", "dialCode": "+381"},
      {"code": "RU", "name": "روسيا", "dialCode": "+7"},
      {"code": "RW", "name": "رواندا", "dialCode": "+250"},
      {"code": "SA", "name": "المملكة العربية السعودية", "dialCode": "+966"},
      {"code": "SB", "name": "جزر سليمان", "dialCode": "+677"},
      {"code": "SC", "name": "سيشل", "dialCode": "+248"},
      {"code": "SD", "name": "السودان", "dialCode": "+249"},
      {"code": "SE", "name": "السويد", "dialCode": "+46"},
      {"code": "SG", "name": "سنغافورة", "dialCode": "+65"},
      {"code": "SH", "name": "سانت هيلنا", "dialCode": "+290"},
      {"code": "SI", "name": "سلوفينيا", "dialCode": "+386"},
      {"code": "SJ", "name": "سفالبارد وجان مايان", "dialCode": "+47"},
      {"code": "SK", "name": "سلوفاكيا", "dialCode": "+421"},
      {"code": "SL", "name": "سيراليون", "dialCode": "+232"},
      {"code": "SM", "name": "سان مارينو", "dialCode": "+378"},
      {"code": "SN", "name": "السنغال", "dialCode": "+221"},
      {"code": "SO", "name": "الصومال", "dialCode": "+252"},
      {"code": "SR", "name": "سورينام", "dialCode": "+597"},
      {"code": "SS", "name": "جنوب السودان", "dialCode": "+211"},
      {"code": "ST", "name": "ساو تومي وبرينسيبي", "dialCode": "+239"},
      {"code": "SV", "name": "السلفادور", "dialCode": "+503"},
      {"code": "SX", "name": "سينت مارتن", "dialCode": "+1"},
      {"code": "SY", "name": "سوريا", "dialCode": "+963"},
      {"code": "SZ", "name": "سوازيلاند", "dialCode": "+268"},
      {"code": "TC", "name": "جزر الترك وجايكوس", "dialCode": "+1"},
      {"code": "TD", "name": "تشاد", "dialCode": "+235"},
      {"code": "TF", "name": "المقاطعات الجنوبية الفرنسية", "dialCode": "+262"},
      {"code": "TG", "name": "توجو", "dialCode": "+228"},
      {"code": "TH", "name": "تايلند", "dialCode": "+66"},
      {"code": "TJ", "name": "طاجكستان", "dialCode": "+992"},
      {"code": "TK", "name": "توكيلو", "dialCode": "+690"},
      {"code": "TL", "name": "تيمور الشرقية", "dialCode": "+670"},
      {"code": "TM", "name": "تركمانستان", "dialCode": "+993"},
      {"code": "TN", "name": "تونس", "dialCode": "+216"},
      {"code": "TO", "name": "تونجا", "dialCode": "+676"},
      {"code": "TR", "name": "تركيا", "dialCode": "+90"},
      {"code": "TT", "name": "ترينيداد وتوباغو", "dialCode": "+1"},
      {"code": "TV", "name": "توفالو", "dialCode": "+688"},
      {"code": "TW", "name": "تايوان", "dialCode": "+886"},
      {"code": "TZ", "name": "تانزانيا", "dialCode": "+255"},
      {"code": "UA", "name": "أوكرانيا", "dialCode": "+380"},
      {"code": "UG", "name": "أوغندا", "dialCode": "+256"},
      {
        "code": "UM",
        "name": "جزر الولايات المتحدة البعيدة الصغيرة",
        "dialCode": ""
      },
      {"code": "US", "name": "الولايات المتحدة الأمريكية", "dialCode": "+1"},
      {"code": "UY", "name": "أورجواي", "dialCode": "+598"},
      {"code": "UZ", "name": "أوزبكستان", "dialCode": "+998"},
      {"code": "VA", "name": "الفاتيكان", "dialCode": "+379"},
      {"code": "VC", "name": "سانت فنسنت وغرنادين", "dialCode": "+1"},
      {"code": "VE", "name": "فنزويلا", "dialCode": "+58"},
      {"code": "VG", "name": "جزر فرجين البريطانية", "dialCode": "+1"},
      {"code": "VI", "name": "جزر فرجين الأمريكية", "dialCode": "+1"},
      {"code": "VN", "name": "فيتنام", "dialCode": "+84"},
      {"code": "VU", "name": "فانواتو", "dialCode": "+678"},
      {"code": "WF", "name": "جزر والس وفوتونا", "dialCode": "+681"},
      {"code": "WS", "name": "ساموا", "dialCode": "+685"},
      {"code": "XK", "name": "كوسوفو", "dialCode": "+383"},
      {"code": "YE", "name": "اليمن", "dialCode": "+967"},
      {"code": "YT", "name": "مايوت", "dialCode": "+262"},
      {"code": "ZA", "name": "جمهورية جنوب افريقيا", "dialCode": "+27"},
      {"code": "ZM", "name": "زامبيا", "dialCode": "+260"},
      {"code": "ZW", "name": "زيمبابوي", "dialCode": "+263"},
    ];

    return jsonData.map((data) => Country.fromMap(data)).toList();
  }

  final List<Map<String, dynamic>> paymentType = [
    {'id': 0, 'name': "أجل"},
    {'id': 1, 'name': "كاش"},
  ];
  List<String> paymentTypes = [];
  void fetchpaymentTypeList() {
    for (var element in paymentType) {
      paymentTypes.add(element['name']);
    }
  }

  void initialze() async {
    getAllData();
    emit(GetAllDatSuccess());
  }

  void updateDateControllers() {
    ControllerManager().clearControllers(
        controllers: ControllerManager().prinvoiceControllers);
    ControllerManager()
        .clearControllers(controllers: ControllerManager().prControllers);
    ControllerManager().purchaseInvoiceDateController.text =
        DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());

    /*  ControllerManager()
        .clearControllers(controllers: ControllerManager().invoiceControllers);
    ControllerManager()
        .clearControllers(controllers: ControllerManager().salesControllers); */
    /*  ControllerManager().purchaseInvoiceDateController.text =
        DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now()); */
    /*  ControllerManager().invoiceReceiveDateController.text =
        DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());
    ControllerManager().invoiceDueDateController.text =
        DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now()); */
  }

  void getAllData() {
    getDrawerData();
    fetchVendors();
    fetchProductInfoDatalists();
    getStoreData();
    getItemsData();
    fetchUom();
    loadSysSettings();
  }

  void emitGetAllData() {
    emit(GetAllDatSuccess());
  }

  PrInvoiceEntity? selectedInvoice;
/*   void fetchSalesInvoiceDataByID({required int id}) async {
    /*  emit(SalesInvoiceLoading()); */
    var either = await invoiceUseCases.fetchSalesInvoiceDataByID(id: id);
    either.fold((l) {
      emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
      print(l.errorMessege);
    }, (r) {
      selectedInvoice = r;
      /*  selectedItemsList = r.itemsDetails ?? []; */
      updateInvoiceControllers(r);
      emit(GetInvoiceItemsSuccess(selectedItemsList: r.itemsDetails!));
      print("invoiceId : ${r.id}");
      emit(GetAllDatSuccess());
    });
  } */

  void fetchPrInvoicesDataById({required int id}) async {
    /*  emit(SalesInvoiceLoading()); */
    var either = await purchaseRequestsUseCases.fetchPrInvoicesDataById(id: id);
    either.fold((l) {
      emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
      print(l.errorMessege);
    }, (r) {
      selectedInvoice = r;
      selectedItemsList = r.itemsDetails ?? [];
      updateInvoiceControllers(r);
      emit(GetInvoiceItemsSuccess(selectedItemsList: r.itemsDetails!));
      print("invoiceId : ${r.id}");
      emit(GetAllDatSuccess());
    });
  }

  double totalInvoice = 0;
  double totalTax = 0;
  double discountP = 0;
  double discountV = 0;
  double value = 0;

  List<double> totalPrices = [];
  List<double> totalTaxes = [];
  List<double> totalPaidValues = [];
  void editItem(
      {required List<InvoiceItemDetailsDm> selectedItemsList,
      required int index,
      required BuildContext context}) async {
    var either = await invoiceUseCases.fetchPurchaseItemDataByID(
        id: int.parse(selectedItemsList[index].itemNameAr.toString() ?? "1"));
    print("5555555555555555${selectedItemsList[index].id}");

    either.fold((l) {
      print("${selectedItemsList[index].id}");
      print(l.errorMessege);
      emit(getItemDataByIDError(errorMsg: l.errorMessege));
    }, (r) {
      selectedItem = r;
      itemUomlist = r.itemUom ?? [];
      selectedUom = r.itemUom?.first;

      updateControllersWithSelectedItem(r, selectedItemsList[index]);
      FocusScope.of(context).requestFocus(editItemFocusNode);
/*       expandAccordion();
 */
      emit(EditPurchasesItemSuccess(
        selectedItem: selectedItemsList[index],
        salesItemDm: r,
        selectedItemsList: selectedItemsList,
      ));
    });
  }
  /*  void editItem(
      {required List<InvoiceItemDetailsDm> selectedItemsList,
      required int index}) async {
    var either = await invoiceUseCases.fetchPurchaseItemDataByID(
        id: int.parse(selectedItemsList[index].itemNameAr.toString() ?? "1"));
    either.fold((l) {
      print("${selectedItemsList[index].id}");
      print(l.errorMessege);
      emit(getItemDataByIDError(errorMsg: l.errorMessege));
    }, (r) {
      itemUomlist = r.itemUom ?? [];
/*       selectedUom = r.itemUom?.first;
 */
      updateControllersWithSelectedItem(r, selectedItemsList[index]);
      emit(EditPurchasesItemSuccess(
        selectedItem: selectedItemsList[index],
        salesItemDm: r,
        selectedItemsList: selectedItemsList,
      ));
    });
  } */

  /*  void editSelectedItem(int index) {
    if (formKeyItems.currentState!.validate()) {
      var selectedItemDetails = InvoiceItemDetailsDm(
        description:
            ControllerManager().salesDescriptionController.text.isNotEmpty
                ? ControllerManager().salesDescriptionController.text
                : "", // Only include if not empty
        id: selectedItem.itemId?.toString() ?? "", // Ensure valid ID as String
        itemCode1: selectedItem.itemCode1 ?? 0, // Ensure valid item code
        itemNameAr: selectedItem.itemId, // Ensure itemNameAr is a String
        qty:
            double.tryParse(ControllerManager().prQuantityController.text) ??
                1.0, // Ensure valid double
    /*     uom: selectedUom?.uomId ?? 1,  */// Ensure valid UOM
        length: double.tryParse(ControllerManager()
            .salesLengthController
            .text), // Ensure valid double
        width: double.tryParse(ControllerManager().salesWidthController.text) ??
            0.0, // Ensure valid double
        height:
            double.tryParse(ControllerManager().salesHeightController.text) ??
                0.0, // Ensure valid double
        precentage: double.tryParse(
                ControllerManager().prDiscountRateController.text) ??
            0.0, // Ensure valid double
        precentagevalue: double.tryParse(
                ControllerManager().prDiscountValueController.text) ??
            0.0, // Ensure valid double
        prprice:
            double.tryParse(ControllerManager().prPriceController.text) ??
                0.0, // Ensure valid double
        currentQty: double.tryParse(
                ControllerManager().salesAvailableQuantityController.text) ??
            0.0, // Ensure valid double
        allQtyValue: double.tryParse(
                ControllerManager().salesTotalQuantityController.text) ??
            0.0, // Ensure valid double
        alltaxesvalue: double.tryParse(
                ControllerManager().prTotalTaxesController.text) ??
            0.0, // Ensure valid double
        totalprice:
            double.tryParse(ControllerManager().prPriceController.text)
                    ?.toStringAsFixed(2) ??
                "0.00", // Ensure it's a String and not null
        // Ensure it's a String or handle appropriately
      );

      // Update the total invoice calculation
      List<double> totalPricesfromData = [];
      for (var e in selectedItemsList) {
        totalPricesfromData.add(double.parse(e.totalprice!) ?? 0.0);
      }

      totalPrices = totalPricesfromData;
      totalPrices[index] =
          double.tryParse(ControllerManager().prPriceController.text) ?? 0.0;
      totalInvoice = totalPrices.reduce((a, b) => a + b);
      /* totalInvoice +=
          double.tryParse(ControllerManager().prPriceController.text) ?? 0.0; */
      ControllerManager().prinvoiceTotalPriceController.text =
          totalInvoice.toString();

      totalTaxes[index] =
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0;
      totalTax = totalTaxes.reduce((a, b) => a + b);

      ControllerManager().prinvoiceTotalTaxesController.text =
          totalTax.toString();
      List<double> totalPiadfromData = [];
      for (var e in selectedItemsList) {
        totalPiadfromData.add(e.prprice ?? 0.0);
      }

      var valuePaid = totalTax + totalInvoice;
      /*  var valuePaid = totalPaidValues.reduce((a, b) => a + b); */

      ControllerManager().prinvoiceNetController.text = valuePaid.toString();
      selectedItemsList[index] = selectedItemDetails;
      clearDiscounts();
      emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
    }
  }
 */
  late int indexOfEditableItem;
/*   void saveSelectedItem() {
    if (formKeyItems.currentState!.validate()) {
      var selectedItemDetails = InvoiceItemDetailsDm(
        description:
            ControllerManager().salesDescriptionController.text.isNotEmpty
                ? ControllerManager().salesDescriptionController.text
                : "", // Only include if not empty
        id: selectedItem.itemId?.toString() ?? "", // Ensure valid ID as String
        itemCode1: selectedItem.itemCode1 ?? 0, // Ensure valid item code
        itemNameAr: selectedItem.itemId, // Ensure itemNameAr is a String
        qty:
            double.tryParse(ControllerManager().prQuantityController.text) ??
                1.0, // Ensure valid double
        uom: selectedUom?.uomId ?? 1, // Ensure valid UOM
        length: double.tryParse(ControllerManager()
            .salesLengthController
            .text), // Ensure valid double
        width: double.tryParse(ControllerManager().salesWidthController.text) ??
            0.0, // Ensure valid double
        height:
            double.tryParse(ControllerManager().salesHeightController.text) ??
                0.0, // Ensure valid double
        precentage: double.tryParse(
                ControllerManager().prDiscountRateController.text) ??
            0.0, // Ensure valid double
        precentagevalue: double.tryParse(
                ControllerManager().prDiscountValueController.text) ??
            0.0, // Ensure valid double
        prprice: double.tryParse(
                ControllerManager().prUnitPriceController.text) ??
            0.0, // Ensure valid double
        currentQty: double.tryParse(
                ControllerManager().salesAvailableQuantityController.text) ??
            0.0, // Ensure valid double
        allQtyValue: double.tryParse(
                ControllerManager().salesTotalQuantityController.text) ??
            0.0, // Ensure valid double
        alltaxesvalue: double.tryParse(
                ControllerManager().prTotalTaxesController.text) ??
            0.0, // Ensure valid double
        totalprice:
            double.tryParse(ControllerManager().prPriceController.text)
                    ?.toStringAsFixed(2) ??
                "0.00", // Ensure it's a String and not null
        // Ensure it's a String or handle appropriately
      );

      // Update the total invoice calculation
      double unitPrice = calcUnitPriceforOneItem(selectedItem.smallUOMPrice)!;
      double qty = _parseControllerText(
          ControllerManager().prQuantityController,
          defaultValue: 1.0);

      double discountValue = _parseControllerText(
          ControllerManager().prDiscountValueController,
          defaultValue: 0.0);

      totalInvoice = double.tryParse(
              ControllerManager().prinvoiceTotalPriceController.text) ??
          0.0;
      totalInvoice += qty * unitPrice - discountValue;
      ControllerManager().prinvoiceTotalPriceController.text =
          totalInvoice.toStringAsFixed(1);
      totalTax = double.tryParse(
              ControllerManager().prinvoiceTotalTaxesController.text) ??
          0.0;
      totalTax +=
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0;
      ControllerManager().prinvoiceTotalTaxesController.text =
          totalTax.toStringAsFixed(1);
      value = double.tryParse(ControllerManager().prinvoiceNetController.text) ??
          0.0;
      value = totalInvoice + totalTax;
      ControllerManager().prinvoiceNetController.text = value.toStringAsFixed(1);
      totalPrices.add(qty * unitPrice - discountValue);
      totalTaxes.add(
          double.tryParse(ControllerManager().prTotalTaxesController.text) ??
              0.0);
      totalPaidValues.add(
          double.tryParse(ControllerManager().prPriceController.text) ??
              0.0);
      selectedItemsList.add(selectedItemDetails);
      itemsTaxesRelations
          .addAll(selectedItem.itemTaxsRelation as Iterable<ItemTaxsRelation>);
      clearDiscounts();
      emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
    }
  }
 */
  void addCustomer(
      InvoiceCustomerDm invoiceCustomerDm, BuildContext context) async {
    emit(AddSalesCustomerLoading());
    var either = await invoiceUseCases.postCustomerRequest(invoiceCustomerDm);
    print(invoiceCustomerDm.cusNameAr);
    either.fold((l) {
      print(l.errorMessege);
      print("failure in add customer ");
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInUp,
        context: context,
        type: QuickAlertType.error,
        showConfirmBtn: false,
        title: l.errorMessege,
        titleColor: AppColors.redColor,
        /* text: state.errorMsg, */
      );
    }, (r) async {
      print("success in adding customer ");

      // Fetch customer data and wait for it to complete
      await fetchCustomerData(skip: 0, take: 20);

      // Once fetchCustomerData is completed, proceed
      selectedCustomer = customerData.firstWhere(
        (element) => element.id == r,
        orElse: () {
          return InvoiceCustomerDm();
        },
      );

      emit(AddSalesCustomerSuccess(customerEntity: selectedCustomer));

      // Close the modal dialogs after the customer is added
      Navigator.pop(context);
      Navigator.pop(context);
      /*  Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context); */
    });
  }

  InvoiceTaxDm slectedTax = InvoiceTaxDm();

  void getTaxByid({required int id}) async {
    var either = await invoiceUseCases.fetchTaxByID(id: id);
    either.fold((l) {
      emit(GetTaxByIDError(errorMsg: l.errorMessege));
    }, (r) {
      slectedTax = r;
      ControllerManager().salesTaxesNameController.text = r.descriptionAr!;
    });
  }

  void removeItem(int index) {
    emit(removeItemDataByIDLoading());
    selectedItemsList.removeAt(index);
    /*  totalInvoice =
        _parseControllerText(ControllerManager().invoiceTotalPriceController); */
    totalInvoice = totalPrices.reduce((value, element) => value + element);

    totalInvoice -= totalPrices[index];

    totalInvoice = double.parse(totalInvoice.toStringAsFixed(2));
    totalTax = totalTaxes.reduce((value, element) => value + element);
    totalTax -= totalTaxes[index];

    totalTax = double.parse(totalTax.toStringAsFixed(2));

    double netVal =
        _parseControllerText(ControllerManager().prinvoiceNetController);
    netVal -= (totalPrices[index] + totalTaxes[index]);
    netVal = double.parse(netVal.toStringAsFixed(2));
    totalTaxes.removeAt(index);
    totalPrices.removeAt(index);

    ControllerManager().prinvoiceTotalPriceController.text =
        totalInvoice.toString();
    ControllerManager().prinvoicePaidController.text = netVal.toString();
    ControllerManager().prinvoiceTotalTaxesController.text =
        totalTax.toString();
    ControllerManager().prinvoiceNetController.text = netVal.toString();
    emit(removeItemDataByIDSuccess());
    emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
  }
  /*  void removeItem(int index) {
    emit(removeItemDataByIDLoading());
    selectedItemsList.removeAt(index);
    totalInvoice -= totalPrices[index];

    ControllerManager().prinvoiceTotalPriceController.text =
        totalInvoice.toString();
    emit(removeItemDataByIDSuccess());
    emit(AddPurchasesItemSuccess(selectedItemsList: selectedItemsList));
  } */

  List<ItemTaxsRelation> itemsTaxesRelations = [];
  PrInvoiceRequest addPurchaseReport() {
    PrInvoiceRequest newReport = PrInvoiceRequest(
      storeId: selectedStore.storeId,
      vendor: selectedVendor.id,
      date: ControllerManager().purchaseInvoiceDateController.text == ""
          ? ControllerManager().purchaseInvoiceDateController.text
          : DateTime.now().toIso8601String(),
      invDiscountP: double.tryParse(
              ControllerManager().prinvoiceDiscountPercentageController.text) ??
          0.0, // Ensure valid double
      invDiscountV: double.tryParse(
              ControllerManager().prinvoiceDiscountValueController.text) ??
          0.0,
      net: double.tryParse(ControllerManager().prinvoiceNetController.text) ??
          0.0,
      paymentMethod: getIdByName(selectedPaymentType, paymentType),
      crncId: selectedCurrency.id, // Ensure valid currency ID
      rate: int.tryParse(ControllerManager().prinvoiceRateController.text) ?? 1,
      paid: drawerIsShown
          ? double.tryParse(ControllerManager().prinvoicePaidController.text) ??
              0.0
          : 0.0,
      itemsDetails: selectedItemsList,
      expnsessDetails: [],
      otherexpnsessDetails: [],
    );

    return newReport;
  }

  UpdatePrInvoiceRequest updatePurchaseReport() {
    UpdatePrInvoiceRequest updatedReport = UpdatePrInvoiceRequest(
      // Top-level fields
      id: selectedInvoice!.id,
      code: selectedInvoice?.code,
      sourceCode: selectedInvoice?.sourceCode,
      storeId: selectedStore.storeId,
      vendor: selectedVendor.id,
      date: ControllerManager().purchaseInvoiceDateController.text == ""
          ? ControllerManager().purchaseInvoiceDateController.text
          : DateTime.now().toIso8601String(),
      invDiscountP: double.tryParse(
              ControllerManager().prinvoiceDiscountPercentageController.text) ??
          0.0, // Ensure valid double
      invDiscountV: double.tryParse(
              ControllerManager().prinvoiceDiscountValueController.text) ??
          0.0,
      net: double.tryParse(ControllerManager().prinvoiceNetController.text) ??
          0.0,
      paymentMethod: getIdByName(selectedPaymentType, paymentType),
      total: double.tryParse(
              ControllerManager().prinvoiceTotalPriceController.text) ??
          0.0,

      costcenter: selectedCostCenter.id,

      drawerId: selectedDrawerEntity.id,
      payment: null,
      custody: null,
      custodyAcc: null,
      amount: null,
      crncId: selectedCurrency.id,
      rate: int.tryParse(ControllerManager().prinvoiceRateController.text) ?? 1,
      /*    lcId: null, */
      /* journalId: 262, */
      processId: null,
      sourceType: null,
      paid: drawerIsShown
          ? double.tryParse(ControllerManager().prinvoicePaidController.text) ??
              0.0
          : 0.0,
      notes: ControllerManager().prinvoiceNotesController.text.isNotEmpty
          ? ControllerManager().prinvoiceNotesController.text
          : null,
      /*  receiveDate: null, */
      /*   dueDate: null, */
      insertDate: DateTime.now().toIso8601String(),

      // Items details
      itemsDetails: selectedItemsList,

      // Expenses details
      expnsessDetails: [],
      otherexpnsessDetails: [],
    );

    return updatedReport;
  }

  PrInvoiceReportDm savePR() {
    /*  PrInvoiceReportDm selectedReport = PrInvoiceReportDm(
      // Top-level fields
      id: 69,
      code: "49",
      sourceCode: null,
      storeId: 1,
      vendor: 1,
      date: "2024-11-20T13:42:32.819",
      invDiscountP: 0.0,
      invDiscountV: 0.0,
      total: 100.0,
      net: 100.0,
      costcenter: null,
      paymentMethod: 0,
      drawerId: null,
      payment: null,
      custody: null,
      custodyAcc: null,
      amount: null,
      crncId: 1,
      rate: 2.0,
      lcId: null,
      journalId: 262,
      processId: null,
      sourceType: null,
      paid: 0.0,
      notes: null,
      receiveDate: null,
      dueDate: null,
      insertDate: "2024-11-20T15:43:11.056114",

      // Items details
      itemsDetails: [
        InvoiceItemDetailsDm(
          id: "cab4142c-0f35-49f0-8e22-3764b7709f12",
          invoiceId: 0,
          itemNameAr: 1,
          currentQty: 79869,
          description: null,
          qty: 1.0,
          precentage: 0.0,
          precentagevalue: 0.0,
          uom: 1,
          prprice: 100.0,
          alltaxesvalue: 0.0,
          totalprice: 100.0,
          /*  idStore: null, */
          length: 1.0,
          width: 1.0,
          height: 1.0,
          expiryDate: null,
          batch: null,
          allQtyValue: 1,
          mClassificationIdBL: null,
          foreignKey: "cab4142c-0f35-49f0-8e22-3764b7709f12",
          itemCode1: 1,
        ),
      ],

      // Expenses details
      expnsessDetails: [],
      otherexpnsessDetails: [],
    );
 */
    PrInvoiceReportDm selectedReport = PrInvoiceReportDm(
        code: selectedInvoice?.code,
        storeId: selectedStore.storeId ?? 0, // Ensure valid store ID

        notes: ControllerManager().prinvoiceNotesController.text.isNotEmpty
            ? ControllerManager().prinvoiceNotesController.text
            : null, // Only include if not empty
        costcenter: selectedCostCenter.id, // Ensure valid cost center
        date: ControllerManager().purchaseInvoiceDateController.text == ""
            ? ControllerManager().purchaseInvoiceDateController.text
            : DateTime.now()
                .toIso8601String() /* DateTime.now().toIso8601String() */, // Ensure valid ISO 8601 date
        invDiscountP:
            double.tryParse(ControllerManager().prinvoiceDiscountPercentageController.text) ??
                0.0, // Ensure valid double
        invDiscountV:
            double.tryParse(ControllerManager().prinvoiceDiscountValueController.text) ??
                0.0, // Ensure valid double
        // Ensure valid double

        paymentMethod: getIdByName(
            selectedPaymentType, paymentType), // Ensure it's a String

        crncId: selectedCurrency.id, // Ensure valid currency ID
        rate:
            double.tryParse(ControllerManager().prinvoiceRateController.text) ??
                1.0,
        net: double.tryParse(ControllerManager().prinvoiceNetController.text) ??
            0.0, // Ensure valid double
        paid: drawerIsShown
            ? double.tryParse(ControllerManager().prinvoicePaidController.text) ??
                0.0
            : 0.0,
        itemsDetails: selectedItemsList,
        invTaxes: double.tryParse(
                ControllerManager().prinvoiceTotalTaxesController.text) ??
            0.0, // List of selected items

        outputTaxesDetails: itemsTaxesRelations,
        expnsessDetails: [],
        otherexpnsessDetails: [],
        vendor: selectedVendor
            .id // Output taxes details (assuming you have a list of taxes)
        );

    log("${selectedReport}");
    return selectedReport;
  }

  /*  PrInvoiceReportDm savePR() {
    PrInvoiceReportDm selectedReport = PrInvoiceReportDm(
      // Top-level fields
      amount: null,
      /* code: "9", */
      costcenter: selectedCostCenter.id, // Ensure valid cost center ID
      crncId: 1,
      custody: null,
      custodyAcc: null,
      date: ("2024-10-31T15:16:49.689"),
      drawerId: null,
/*       dueDate: null,
 */
      expnsessDetails: [],
      id: 29,
      insertDate: ("2024-10-31T18:17:28.166886"),
      invDiscountP: 0.0,
      invDiscountV: 0.0,

      // Items details
      itemsDetails: [
        InvoiceItemDetailsDm(
          id: "6775e1b9-9759-0c16-ecdc-d2768215a309",
          invoiceId: 0,
          itemNameAr: 1,
          currentQty: -4,
          allQtyValue: 1,
          alltaxesvalue: 0.0,
          /*   batch: null, */
          description: null,
          foreignKey: "6775e1b9-9759-0c16-ecdc-d2768215a309",
          height: 1.0,
/*           idStore: null,
 */
          itemCode1: 1,
          length: 1.0,
          /*  mClassificationIdBL: null, */
          precentage: 0.0,
          precentagevalue: 0.0,
          prprice: 100.0,
          qty: 1,
          totalprice: 100.0,
          uom: 1,
          width: 1.0,
        ),
      ],

      // Quantity and pricing
      allQtyValue: 1,
/*       alltaxesvalue: 0.0,
 */
      batch: null,
      currentQty: -4,
      description: null,
/*       expiryDate: null,
 */
      foreignKey: "6775e1b9-9759-0c16-ecdc-d2768215a309",
      height: 1.0,
/*       idStore: null,
 */
      itemCode1: 1,
      itemNameAr: 1,
      length: 1.0,
      mClassificationIdBL: null,
      precentage: 0.0,
      precentagevalue: 0.0,
      prprice: 100.0,
      qty: 1.0,
      totalprice: "100.0",
      uom: 1,
      width: 1.0,

      // Journal and other details
      journalId: 242,
/*       lcId: null,
 */
      net: 300.0,
      notes: null,
      otherexpnsessDetails: [],
      paid: 0.0,
      payment: null,
      paymentMethod: 0,
      processId: null,
      rate: 2.0,
      receiveDate: null,
      sourceCode: null,
      sourceType: null,
      storeId: 2,
      total: 200.0,
      vendor: 1,
    );

    /*  PrInvoiceReportDm selectedReport = PrInvoiceReportDm(
        code: selectedInvoice.code,
        storeId: selectedStore.storeId ?? 0, // Ensure valid store ID

        notes: ControllerManager().prinvoiceNotesController.text.isNotEmpty
            ? ControllerManager().prinvoiceNotesController.text
            : null, // Only include if not empty
        costcenter: selectedCostCenter.id, // Ensure valid cost center
        date: ControllerManager().purchaseInvoiceDateController.text == ""
            ? ControllerManager().purchaseInvoiceDateController.text
            : DateTime.now()
                .toIso8601String() /* DateTime.now().toIso8601String() */, // Ensure valid ISO 8601 date
        invDiscountP:
            double.tryParse(ControllerManager().prinvoiceDiscountPercentageController.text) ??
                0.0, // Ensure valid double
        invDiscountV:
            double.tryParse(ControllerManager().prinvoiceDiscountValueController.text) ??
                0.0, // Ensure valid double
        // Ensure valid double

        paymentMethod: getIdByName(
            selectedPaymentType, paymentType), // Ensure it's a String

        crncId: selectedCurrency.id, // Ensure valid currency ID
        rate:
            double.tryParse(ControllerManager().prinvoiceRateController.text) ??
                1.0,
        net: double.tryParse(ControllerManager().prinvoiceNetController.text) ??
            0.0, // Ensure valid double
        paid: drawerIsShown
            ? double.tryParse(ControllerManager().prinvoicePaidController.text) ??
                0.0
            : 0.0,
        itemsDetails: selectedItemsList,
        invTaxes: double.tryParse(
                ControllerManager().prinvoiceTotalTaxesController.text) ??
            0.0, // List of selected items

        outputTaxesDetails: itemsTaxesRelations,
        expnsessDetails: [],
        otherexpnsessDetails: [],
        vendor: selectedVendor
            .id // Output taxes details (assuming you have a list of taxes)
        );
    */
    log("${selectedReport}");
    return selectedReport;
  }
 */
  PrReturnDM savePrReturn() {
    PrReturnDM selectedReport = PrReturnDM(
        storeId: selectedStore.storeId ?? 0, // Ensure valid store ID

        /*   notes: ControllerManager().prinvoiceNotesController.text.isNotEmpty
            ? ControllerManager().prinvoiceNotesController.text
            : null, // Only include if not empty */
        costcenter: selectedCostCenter.id, // Ensure valid cost center
        date: ControllerManager().purchaseInvoiceDateController.text == ""
            ? ControllerManager().purchaseInvoiceDateController.text
            : DateTime.now()
                .toIso8601String() /* DateTime.now().toIso8601String() */, // Ensure valid ISO 8601 date
        invDiscountP: double.tryParse(ControllerManager()
                .prinvoiceDiscountPercentageController
                .text) ??
            0.0, // Ensure valid double
        invDiscountV: double.tryParse(
                ControllerManager().prinvoiceDiscountValueController.text) ??
            0.0, // Ensure valid double
        // Ensure valid double

        /*   paymentMethod: getIdByName(
            selectedPaymentType, paymentType), // Ensure it's a String
 */
        crncId: selectedCurrency.id, // Ensure valid currency ID
        rate:
            double.tryParse(ControllerManager().prinvoiceRateController.text) ??
                1.0,
        net: double.tryParse(ControllerManager().prinvoiceNetController.text) ??
            0.0, // Ensure valid double
        /*   paid: drawerIsShown
            ? double.tryParse(ControllerManager().prinvoicePaidController.text) ??
                0.0
            : 0.0, */
        itemsDetails: selectedItemsList,
        /*   invTaxes:
            double.tryParse(ControllerManager().prinvoiceTotalTaxesController.text) ??
                0.0, // List of selected items

        outputTaxesDetails: itemsTaxesRelations,
        expnsessDetails: [],
        otherexpnsessDetails: [], */
        vendor: selectedVendor
            .id // Output taxes details (assuming you have a list of taxes)
        );
    return selectedReport;
  }

  void waitForAddItems() {
    emit(AddPurchasesItemloading());
  }

  Country? selectDefaultCountry() {
    List<Country> countries = listOfCountries();
    String defaultCountryCode = settings.defaultCountryBl ?? "";
    // Search for the country with the matching code
    for (Country country in countries) {
      if (country.code == defaultCountryCode) {
        return country;
      }
    }
    return null; // Return null if no matching country is found
  }

  void updateTradeStatusType(String value) {
    emit(UpdateTradeStatusTypeLoading());
    String type = value;
    print(type);
    clearDiscounts();
    emit(UpdateTradeStatusTypeSuccess(
        selectedTradeStatusType: selectedTradeStatusType, type: type));
  }

  StoreEntity selectStore({required String name}) {
    return selectedStore =
        storeList.where((element) => element.storeNameAr == name).first;
  }

  /*  void clearItemConroller() {
    ControllerManager().purchaseItemQuantitytemController.clear();
    ControllerManager().purchaseItemDiscriptionController.clear();
  } */

  /*  void selectUom({required String name}) {
    selectedUom = itemUomlist.firstWhere(
      (element) => element.uom == name,

      orElse: () => null as SalesItemUom, // Return null if no match is found
    );
  } */

  updateRate() {
    ControllerManager().purchaseCurRateController.text =
        selectedCurrency.rate.toString();
    print(selectedCurrency.rate);
    emit(GetAllDatSuccess());
  }

  late double taxPercentageForOneItem = 0.0;
  void changeDrawer(String selectedPaymentType) {
    int? type = getIdByName(selectedPaymentType, paymentType);
    if (type == 0) {
      drawerIsShown = false;
    } else {
      drawerIsShown = true;
    }
    emit(UpdateRateSuccess(selectedCurrency: selectedCurrency));
    emit(GetAllDatSuccess());
  }

  bool drawerIsShown = false;
  /*  void getStoreData() async {
    var either = await invoiceUseCases.fetchStoreData();
    either.fold((l) {
      print(l.errorMessege);
      if (!isClosed) {
        emit(getStoreDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      storeList = r;
      if (!isClosed) {
        emit(getStoreDataSuccess(storeDataList: r));
        emit(GetAllDatSuccess());
      }
    });
  }
 */
  void getCurrencyData() async {
    var either = await invoiceUseCases.fetchCurrencyData();
    either.fold((l) {
      print(l.errorMessege);
      if (!isClosed) {
        emit(getCurrencyDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      if (!isClosed) {
        emit(getCurrencyDataSuccess(currencyDataList: r));
      }
      currencyList = r;
      selectedCurrency = currencyList.first;

      /* emit(SalesInvoiceInitial()); */
    });
  }

  Uint8List? selectedInvoicePrint;

  void getInvoicePrint(
      {required String id, required BuildContext context}) async {
    emit(SalesInvoiceLoading());
    var either =
        await invoiceUseCases.getImageFromAPI(id: id, context: context);
    either.fold((l) {
      print(l.errorMessege);
      emit(getImageDataError(errorMsg: l.errorMessege));
      /*   Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop(); */
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInUp,
        context: context,
        type: QuickAlertType.error,
        showConfirmBtn: false,
        title: l.errorMessege,
        titleColor: AppColors.redColor,
        /* text: state.errorMsg, */
      );
    }, (r) {
      print("id printer : $id");
      emit(getImageDataSuccess(imageData: r));
      emit(GetAllDatSuccess());
      /*   Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop(); */
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInUp,
        context: context,
        type: QuickAlertType.success,
        showConfirmBtn: false,
        title: "تمت الطباعه بنجاح",
        titleColor: AppColors.greenColor,
        /* text: state.errorMsg, */
      );
      /* emit(SalesInvoiceInitial()); */
    });
  }

/*   void fetchAllSalesInvoiceData() async {
    emit(GetAllInvoicesLoading());
    var either = await invoiceUseCases.fetchAllSalesInvoiceData();
    either.fold((l) {
      print(l.errorMessege);
      emit(GetAllInvoicesError(errorMsg: l.errorMessege));
    }, (r) {
      print("success");
      emit(GetAllInvoicesSuccess(invoices: r));
    });
  } */

  void fetchAllPrInvoiceData() async {
    emit(GetAllInvoicesLoading());
    var either = await purchaseRequestsUseCases.fetchPrInvoicesData();
    either.fold((l) {
      print(l.errorMessege);
      emit(GetAllInvoicesError(errorMsg: l.errorMessege));
    }, (r) {
      print("success");
      emit(GetAllInvoicesSuccess(invoices: r));
    });
  }

  DrawerEntity selectDrawer(DrawerEntity drawerEntity) {
    if (drawerEntityList.isNotEmpty) {
      return drawerEntityList
          .firstWhere((element) => element.id == drawerEntity.id);
    } else {
      return drawerEntityList.first;
    }
  }

  void getDrawerData() async {
    var either = await invoiceUseCases.fetchDrawerData();
    either.fold((l) {
      print(l.errorMessege);
      emit(getDrawerDataError(errorMsg: l.errorMessege));
    }, (r) {
      drawerEntityList = r;

      emit(getDrawerDataSuccess(drawerDataList: r));
      emit(GetAllDatSuccess());

      /* emit(SalesInvoiceInitial()); */
    });
  }

/*   void getCostCenterData() async {
    var either = await invoiceUseCases.fetchCostCenterData();
    either.fold((l) {
      if (!isClosed) {
        emit(getCostCenterError(errorMsg: l.errorMessege));
      }
    }, (r) {
      costCenterList = r;
      if (!isClosed) {
        emit(getCostCenterSuccess(costCenterList: r));
        emit(GetAllDatSuccess());
      }
    });
  }
 */
  List<InvoiceCustomerEntity> customerData = [];

  Future<void> fetchCustomerData({
    required int skip,
    required int take,
    String? filter,
  }) async {
    var either = await invoiceUseCases.fetchCustomerData(
        skip: skip, take: take, filter: filter);
    either.fold((l) {
      if (!isClosed) {
        print(l.errorMessege);
        emit(FetchCustomersError(errorMsg: l.errorMessege));
      }
    }, (r) {
      customerData = r;
      if (customerData.isNotEmpty) {
        selectedCustomer = customerData.first;
      }

      if (!isClosed) {
        emit(FetchCustomersSuccess(customers: r));
        emit(GetAllDatSuccess());
      }
    });
  }

  void fetchUom() async {
    var either = await invoiceUseCases.fetchUOMData();
    either.fold((l) {
      if (!isClosed) {
        emit(getUomDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      uomlist = r;
      if (!isClosed) {
        emit(GetUomDatSuccess(uomList: r));
        emit(GetAllDatSuccess());
      }
    });
  }

  /*  void fetchProductInfoDatalists() {
    getStoreData();
    getCostCenterData();
  } */

  void getItemsData() async {
    emit(PurchasesItemSelectedLoading());
    var either = await invoiceUseCases.fetchPurchaseItemData();
    either.fold((l) {
      if (!isClosed) {
        emit(getStoreDataError(errorMsg: l.errorMessege));
      }
      print(l.errorMessege);
    }, (r) {
      itemsList = r;
      if (!isClosed) {
        emit(GetAllDatSuccess());
      }

      /*  emit(PurchasesItemSelected(selectedItem)); */
    });
  }

  bool supportsDimensionsBLIsShown = false;
  late SysSettingsDM settings = SysSettingsDM();

  void loadSysSettings() async {
    var result = await getSysSettingUSecase.getSysSettingsData();
    result.fold(
      (failure) {
        print(failure.errorMessege);
        if (!isClosed) {
          print(failure.errorMessege);
          emit(SysSettingsLoadFailure(errorMsg: failure.errorMessege));
        }
      },
      (sysSettings) {
        settings = sysSettings;
      },
    );
  }

  void updatePrReturnReport(
      {required BuildContext context, required int id}) async {
    if (formKey.currentState!.validate()) {
      if (_parseControllerText(ControllerManager().invoicePaidController) >
          _parseControllerText(ControllerManager().invoiceNetController)) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "لا يمكن دفع اكثر من الصافى",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else if (selectedItemsList.isEmpty) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "برجاء ادخال اصناف",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else {
        emit(UpdatePrReturnLoading());
        /*     DialogUtils.showLoading(
            context: context, message: "state.loadingMessege"); */
        var either = await invoiceUseCases.updatePrReturnRequest(
            invoiceReportDm: savePrReturn(), id: id);
        either.fold((l) {
          print(l.errorMessege);

          emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
/*           DialogUtils.hideLoading(context);
 */
          /*  Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context); */
          QuickAlert.show(
            animType: QuickAlertAnimType.slideInUp,
            context: context,
            type: QuickAlertType.error,
            showConfirmBtn: false,
            title: "حدث خطأ ما",
            titleColor: AppColors.redColor,
            /* text: state.errorMsg, */
          );
        }, (r) {
/*           DialogUtils.hideLoading(context);
 */
          /*    Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context); */
          /*   Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) {
              return false;
            },
          );
          Navigator.pushNamed(
            context,
            AllInvoicesScreenCards.routeName,
          ); */
          QuickAlert.show(
            animType: QuickAlertAnimType.slideInUp,
            context: context,
            type: QuickAlertType.success,
            showConfirmBtn: false,
            title: "تمت التعديل بنجاح",
            titleColor: AppColors.greenColor,
            /* text: state.errorMsg, */
          );
          print("editing");
          print("id : $r");
          emit(UpdatePurchasesRequestSuccess());
        });
      }
    } else {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInUp,
        context: context,
        type: QuickAlertType.error,
        showConfirmBtn: false,
        title: "برجاء ادخال جميع البيانات",
        titleColor: AppColors.redColor,
        /* text: state.errorMsg, */
      );
    }
  }

  void updatePaidPrice() {
    double totalPrice = double.tryParse(
            ControllerManager().prinvoiceTotalPriceController.text) ??
        0.0;
    /*  double taxTotal = double.tryParse(prinvoiceTotalTaxesController.text) ?? 0.0; */
    double discountPercentage = double.tryParse(
            ControllerManager().invoiceDiscountPercentageController.text) ??
        0.0;
    double discountValue = double.tryParse(
            ControllerManager().invoiceDiscountValueController.text) ??
        0.0;

    // Start with the total + tax
    double paidPrice = totalPrice /*  + taxTotal */;

    // Apply discount percentage or discount value
    if (discountPercentage > 0) {
      paidPrice -= (paidPrice * (discountPercentage / 100));
    } else if (discountValue > 0) {
      paidPrice -= discountValue;
    }

    // Ensure the final price is not less than 0
    paidPrice = paidPrice < 0 ? 0 : paidPrice;

    // Update the final price controller
    ControllerManager().prinvoiceNetController.text =
        paidPrice.toStringAsFixed(2);
  }

  void updateControllersWithSelectedItem(
      SalesItemDm item, InvoiceItemDetailsDm itemDetailsDm) {
    // Update controllers with item data
    ControllerManager().prUnitPriceController.text =
        item.smallUOMPrice?.toString() ?? '0';
    ControllerManager().prQuantityController.text =
        itemDetailsDm.qty?.toString() ?? '1';
    ControllerManager().salesTotalQuantityController.text =
        itemDetailsDm.allQtyValue?.toString() ?? '1';
    /*  ControllerManager().prinvoiceDateController.text =
        DateFormat.YEAR_ABBR_MONTH;
    ControllerManager().invoiceDueDateController.text =
        DateTime.now().toIso8601String();
    ControllerManager().invoiceReceiveDateController.text =
        DateTime.now().toIso8601String(); */
    ControllerManager().prDiscountRateController.text =
        itemDetailsDm.precentage?.toString() ?? '';
    ControllerManager().prDiscountValueController.text =
        itemDetailsDm.precentagevalue?.toString() ?? '';
    ControllerManager().prPriceController.text =
        itemDetailsDm.prprice?.toString() ?? '';
    ControllerManager().salesAvailableQuantityController.text =
        item.currentQty?.toString() ?? '1';

    ControllerManager().salesLengthController.text =
        settings.lengthBl?.toString() ?? '1';
    ControllerManager().salesWidthController.text =
        settings.widthBl?.toString() ?? '1';
    ControllerManager().salesHeightController.text =
        settings.heightBl?.toString() ?? '1';
    ControllerManager().prTotalTaxesController.text =
        itemDetailsDm.alltaxesvalue.toString();
    /*   ControllerManager().prTotalTaxesController.text =
        item.itemTaxsRelation?.length.toString() ?? '0'; */
    ControllerManager().salesDescriptionController.text =
        itemDetailsDm.description.toString();
  }

  double? calcUnitPriceforOneItem(double? price) {
    double itemPrice = 0.0;
    taxPercentageForOneItem = 0.0;

    // Check if the selected customer is taxable
    if (selectedCustomer.isTaxable == true) {
      selectedItem.itemTaxsRelation?.forEach((element) {
        taxPercentageForOneItem += element.percentage ?? 0.0;
      });
    }
    //price inclues taxes
    if (settings.purchasePriceIncludesTaxesBl!) {
      itemPrice = price! -
          calculateTaxForPriceIncudesTax(price, taxPercentageForOneItem);
      return itemPrice;
    } else {
      itemPrice = price!;
      return itemPrice;
    }
  }

  double? calcTotalPriceforOneItem(SalesItemDm item) {
    double itemPrice = 0.0;
    taxPercentageForOneItem = calcTaxesPercentageforOneItem(item)!;

    //price inclues taxes
    if (settings.purchasePriceIncludesTaxesBl!) {
      itemPrice = item.smallUOMPrice!;
      return itemPrice;
    } else {
      itemPrice = item.smallUOMPrice! +
          item.smallUOMPrice! * ((taxPercentageForOneItem) / 100);
      return itemPrice;
    }
  }

  double? calcTaxexforOneItem(SalesItemDm item) {
    double taxPrice = 0.0;
    taxPercentageForOneItem = 0.0;

    // Check if the selected customer is taxable
    if (selectedCustomer.isTaxable == true) {
      selectedItem.itemTaxsRelation?.forEach((element) {
        taxPercentageForOneItem += element.percentage ?? 0.0;
      });
    }
    taxPrice = item.smallUOMPrice! * ((taxPercentageForOneItem) / 100);
    return taxPrice;
    //price inclues taxes
  }

  double? calcTaxesPercentageforOneItem(SalesItemDm item) {
    taxPercentageForOneItem = 0.0;

    // Check if the selected customer is taxable
    if (selectedCustomer.isTaxable == true) {
      selectedItem.itemTaxsRelation?.forEach((element) {
        taxPercentageForOneItem += element.percentage ?? 0.0;
      });
    }

    return taxPercentageForOneItem;
    //price inclues taxes
  }

  void fetchAllPrReturnsData() async {
    emit(GetAllInvoicesLoading());
    var either = await purchaseRequestsUseCases.fetchPrReturnsData();
    either.fold((l) {
      print(l.errorMessege);
      emit(GetAllPrReturnsError(errorMsg: l.errorMessege));
    }, (r) {
      print("success");
      emit(GetAllPrReturnsSuccess(returns: r));
    });
  }

  void updateControllersWithPurchaseItemData(SalesItemDm item) {
    // Update controllers with item data
    ControllerManager().prUnitPriceController.text =
        item.smallUOMprPrice?.toString() ?? '0';
    if (item.minQty == 0) {
      ControllerManager().prQuantityController.text = "1";
    } else {
      ControllerManager().prQuantityController.text =
          item.minQty?.toString() ?? '1';
    }
    if (item.currentQty! * item.maxQty! == 0) {
      ControllerManager().prTotalQuantityController.text = "1";
    } else {
      ControllerManager().prTotalQuantityController.text =
          (item.currentQty != null && item.maxQty != null)
              ? (item.currentQty! * item.maxQty!).toString()
              : '1';
    }
    /*  ControllerManager().prinvoiceDateController.text =
        DateFormat.YEAR_ABBR_MONTH;
    ControllerManager().invoiceDueDateController.text =
        DateTime.now().toIso8601String();
    ControllerManager().invoiceReceiveDateController.text =
        DateTime.now().toIso8601String(); */
    ControllerManager().prDiscountRateController.text =
        item.discount?.toString() ?? '';
    ControllerManager().prDiscountValueController.text =
        ((item.discount != null && item.price != null)
            ? ((item.discount! / 100) * item.price!).toString()
            : '');
    ControllerManager().prPriceController.text = settings
            .purchasePriceIncludesTaxesBl!
        ? (calcUnitPriceforOneItem(item.smallUOMprPrice)!.toStringAsFixed(1) *
                int.parse(ControllerManager().prQuantityController.text))
            .toString()
        : ((item.smallUOMprPrice! *
                int.parse(ControllerManager().prQuantityController.text)))
            .toString();

    ControllerManager().prAvailableQuantityController.text =
        item.currentQty?.toString() ?? '1';
    ControllerManager().prTotalTaxesController.text =
        settings.purchasePriceIncludesTaxesBl!
            ? calculateTaxForPriceIncudesTax(
                    item.smallUOMprPrice!, calcTaxesPercentageforOneItem(item)!)
                .toStringAsFixed(1)
            : (calcTaxesPercentageforOneItem(item)! *
                    int.parse(ControllerManager().prQuantityController.text))
                .toString();

    ControllerManager().prLengthController.text =
        settings.lengthBl?.toString() ?? '1';
    ControllerManager().prWidthController.text =
        settings.widthBl?.toString() ?? '1';
    ControllerManager().prHeightController.text =
        settings.heightBl?.toString() ?? '1';
    /* changeTax(item); */
    /*   ControllerManager().prTotalTaxesController.text =
        item.itemTaxsRelation?.length.toString() ?? '0'; */
    ControllerManager().prInvoiceDescriptionController.text =
        item.description ?? '';
    /* ControllerManager().salesTaxesNameController.text =
        slectedTax.descriptionAr ?? ''; */
  }

  bool calc = false;
  updatePriceFromPercentage() {
    double totalPrice = _parseControllerText(
        ControllerManager().prinvoiceTotalPriceController,
        defaultValue: 1.0);
    double totalTaxes = _parseControllerText(
        ControllerManager().prinvoiceTotalTaxesController,
        defaultValue: 1.0);

    double discountRate = _parseControllerText(
        ControllerManager().invoiceDiscountPercentageController,
        defaultValue: 0.0);
    late double discountValue;

    if (discountRate != 0) {
      discountValue = (totalPrice + totalTaxes) *
          (discountRate / 100); // Calculate discount from rate
    } else if (discountRate == 0) {
      discountValue = 0;
      discountRate = 0.0;
      /*  discountRate = calculateDiscountRate(totalPrice, discountValue);
      discountValue =
          totalPrice * (discountRate / 100);  */ // Apply discount from fixed value
    }
    ControllerManager().invoiceDiscountPercentageController.text =
        discountRate.toStringAsFixed(2);
    ControllerManager().invoiceDiscountValueController.text =
        discountValue.toStringAsFixed(2);
    ControllerManager().prinvoiceNetController.text =
        (totalPrice + totalTaxes - discountValue).toStringAsFixed(2);
  }

  updatePriceFromValue() {
    double totalPrice = _parseControllerText(
        ControllerManager().prinvoiceTotalPriceController,
        defaultValue: 1.0);
    double totalTaxes = _parseControllerText(
        ControllerManager().prinvoiceTotalTaxesController,
        defaultValue: 1.0);

    double discountRate;
    double discountValue = _parseControllerText(
      ControllerManager().invoiceDiscountValueController,
    );

    if (discountValue != 0) {
      discountRate =
          calculateDiscountRate(totalPrice + totalTaxes, discountValue);
    } else {
      discountValue = 0;
      discountRate = 0.0; // No discount applied
    }
    ControllerManager().invoiceDiscountPercentageController.text =
        discountRate.toStringAsFixed(2);
    ControllerManager().invoiceDiscountValueController.text =
        discountValue.toStringAsFixed(2);
    ControllerManager().prinvoiceNetController.text =
        (totalPrice + totalTaxes - discountValue).toStringAsFixed(2);
  }

  Map<String, double> calculatePrice({
    required double price,
    required double unitPrice,
    required double taxRate,
    double? discountRate, // Either a percentage discount
    double? discountValue, // Or a fixed discount
    required bool priceIncludesTax,
    required bool calcBeforeDisc,
    required double quantity,
    // New quantity parameter
  }) {
    double? taxAmount, finalPrice, discountedPrice, totalPrice;
    if (priceIncludesTax) {
      // Multiply price by quantity to get total price before calculations
      totalPrice = unitPrice * quantity;

      if (calcBeforeDisc) {
        /* unitPrice = unitPrice; */
        unitPrice = calcUnitPriceforOneItem(unitPrice)!;

        // Step 1: Calculate tax based on total price including tax
        taxAmount = calculateTaxForPriceIncudesTax(
            totalPrice, taxRate); // Tax remains constant
        totalPrice = (unitPrice * quantity);
        // Step 2: Apply discount based on the total price including tax
        if (discountRate != null) {
          discountValue =
              totalPrice * (discountRate / 100); // Calculate discount from rate
        } else if (discountValue != null) {
          discountRate = calculateDiscountRate(totalPrice, discountValue);
          discountValue = totalPrice *
              (discountRate / 100); // Apply discount from fixed value
        } else {
          discountValue = 0;
          discountRate = 0.0; // No discount applied
        }

        // Step 3: Calculate price after applying discount
        discountedPrice = totalPrice - discountValue!;
        discountedPrice = discountedPrice < 0
            ? 0
            : discountedPrice; // Ensure no negative price

        // Step 4: Final price after discount, tax remains unchanged
        finalPrice =
            discountedPrice; // Tax already considered in the total price

        //finished======================================
      } else {
        if (discountRate != null) {
          discountValue =
              totalPrice * (discountRate / 100); // Calculate discount from rate
        } else if (discountValue != null) {
          discountRate = calculateDiscountRate(totalPrice, discountValue);
          discountValue = totalPrice * (discountRate / 100);
        } else {
          discountValue = 0;
          discountRate = 0.0; // No discount applied
        }
        totalPrice -= discountValue;
        taxAmount = calculateTaxForPriceIncudesTax(totalPrice, taxRate);
        // Apply discount to total price
        finalPrice = totalPrice - taxAmount; // Final price after discount
//finished======================================
      }
    } else {
      // Multiply price by quantity to get total price before calculations

      /* totalPrice = unitPrice * quantity; */
      totalPrice = unitPrice * quantity;
      if (calcBeforeDisc) {
        /*  unitPrice = calcUnitPriceforOneItem(totalPrice)!; */

        /* totalPrice = (totalPrice + calculateTax(totalPrice, taxRate)); */
// Step 1: Calculate tax based on unit price before any discount is applied
        totalPrice = (unitPrice) * quantity;
        taxAmount = calculateTax(totalPrice, taxRate);
// Step 2: Apply the discount to the total price (including tax)
        if (discountRate != null) {
          discountValue = (totalPrice + taxAmount) *
              (discountRate / 100); // Calculate discount from rate
        } else if (discountValue != null) {
          discountRate =
              calculateDiscountRate(unitPrice * quantity, discountValue);
          discountValue = unitPrice *
              quantity *
              (discountRate / 100); // Calculate discount from value
        } else {
          discountValue = 0;
          discountRate = 0.0; // No discount applied
        }

// Step 3: Calculate the price after applying the discount
        discountedPrice = ((totalPrice)) - discountValue;
        discountedPrice = discountedPrice < 0
            ? 0
            : discountedPrice; // Ensure price is not negative

// Step 4: Final price remains the discounted price with the original tax amount (since tax was calculated before discount)
        /* finalPrice = discountedPrice + taxAmount; */ // Final price after discount
        finalPrice = discountedPrice;
      } else {
        //finished
/*         unitPrice = calcUnitPriceforOneItem(selectedItem)!;

 */
        totalPrice = (totalPrice + calculateTax(totalPrice, taxRate));
        /*  totalPrice =
            (totalPrice + calculateTax(totalPrice, taxRate)) * quantity; */
        if (discountRate != null) {
          discountValue = (unitPrice * quantity) *
              (discountRate / 100); // Calculate discount from rate
        } else if (discountValue != null) {
          discountRate =
              calculateDiscountRate((unitPrice * quantity), discountValue);
          discountValue = (unitPrice * quantity) * (discountRate / 100);
        } else {
          discountValue = 0;
          discountRate = 0.0; // No discount applied
        }
        finalPrice = (unitPrice * quantity) -
            discountValue; // Final price after discount
        taxAmount = calculateTax(finalPrice, taxRate);

        // Apply discount to total price
      }
    }

    ///
    return {
      /*  'unitPrice': unitPrice / quantity, */ // Unit price for one item
      'taxAmount': taxAmount,
      'discountValue': discountValue, 'discountRate': discountRate,
      'finalPrice': finalPrice,
      'qty': quantity
    };
  }

  void doDiscountPercentage(SalesItemDm item) {
    double qty = _parseControllerText(ControllerManager().prQuantityController,
        defaultValue: 1.0);
    double taxRate = calcTaxesPercentageforOneItem(item)!;

    double discountPercentage = _parseControllerText(
        ControllerManager().prDiscountRateController,
        defaultValue: 0.0);
    double unitPrice = _parseControllerText(
        ControllerManager().prUnitPriceController,
        defaultValue: 0.0);
    double price = _parseControllerText(ControllerManager().prPriceController,
        defaultValue: 0.0);
    Map<String, double> map = calculatePrice(
      unitPrice: unitPrice,
      price: price,
      quantity: qty,
      taxRate: taxRate,
      discountRate: discountPercentage,
      calcBeforeDisc: item.calcBeforeDisc!,
      priceIncludesTax: settings.purchasePriceIncludesTaxesBl!,
    );

    ControllerManager().prPriceController.text =
        map["finalPrice"]!.toStringAsFixed(1);
    ControllerManager().prTotalTaxesController.text =
        map["taxAmount"]!.toStringAsFixed(2);
    ControllerManager().prDiscountValueController.text =
        map["discountValue"]!.toStringAsFixed(2);
  }

  void doDiscountValue(SalesItemDm item) {
    double qty = _parseControllerText(ControllerManager().prQuantityController,
        defaultValue: 1.0);
    double taxRate = calcTaxesPercentageforOneItem(item)!;

    double discountPercentage = _parseControllerText(
        ControllerManager().prDiscountRateController,
        defaultValue: 0.0);
    double unitPrice = _parseControllerText(
        ControllerManager().prUnitPriceController,
        defaultValue: 0.0);
    double price = _parseControllerText(ControllerManager().prPriceController,
        defaultValue: 0.0);

    double discountValue = _parseControllerText(
        ControllerManager().prDiscountValueController,
        defaultValue: 0.0);

    Map<String, double> map = calculatePrice(
      unitPrice: unitPrice,
      price: price,
      quantity: qty,
      taxRate: taxRate,
      discountValue: discountValue,
      calcBeforeDisc: item.calcBeforeDisc!,
      priceIncludesTax: settings.purchasePriceIncludesTaxesBl!,
    );

    ControllerManager().prPriceController.text =
        map["finalPrice"]!.toStringAsFixed(1);

    ControllerManager().prTotalTaxesController.text =
        map["taxAmount"]!.toStringAsFixed(1);
    ControllerManager().prDiscountRateController.text =
        map["discountRate"]!.toStringAsFixed(1);

    ControllerManager().prDiscountValueController.text =
        map["discountValue"]!.toStringAsFixed(2);
  }

  //====================================================
  double calculateTaxForPriceIncudesTax(double price, double taxRate) {
    return (taxRate * price) / (100 + taxRate);
  }

  double calculateTax(double price, double taxRate) {
    return price * (taxRate / 100);
  }

  double calculateDiscountAmount(double price, double discountRate) {
    return (price * discountRate) / 100;
  }

  double calculateDiscountRate(double originalPrice, double discountedPrice) {
    return (discountedPrice / originalPrice) * 100;
  }

  clearDiscounts() {
    ControllerManager()
        .clearControllers(controllers: ControllerManager().discountsPR);
    ControllerManager().prinvoiceDiscountPercentageController.clear();
    ControllerManager().prinvoiceDiscountValueController.clear();
  }

  // Utility function to safely parse controller text into a double
  double _parseControllerText(TextEditingController controller,
      {double defaultValue = 0.0}) {
    try {
      if (controller.text.isEmpty) {
        return defaultValue;
      }
      return double.parse(controller.text);
    } catch (e) {
      // If parsing fails, return the default value and handle partial inputs
      return defaultValue;
    }
  }

  void updateSalesFinalPrice() {
    // Parse the values from controllers
    double unitPrice =
        double.tryParse(ControllerManager().prUnitPriceController.text) ?? 0.0;
    int quantity =
        int.tryParse(ControllerManager().prQuantityController.text) ?? 0;
    double discountRate =
        double.tryParse(ControllerManager().prDiscountRateController.text) ??
            0.0;
    double discountValue =
        double.tryParse(ControllerManager().prDiscountValueController.text) ??
            0.0;

    // Calculate the total price before discount
    double basePrice = (unitPrice * quantity);
    double taxes =
        double.tryParse(ControllerManager().prTotalTaxesController.text) ?? 0.0;
    double totalPrice = basePrice + (basePrice * taxes / 100);
    double totalTaxesPrice = (basePrice * taxes / 100);

    // Apply discount rate if it exists and update discount value
    if (discountRate > 0) {
      discountValue = (totalPrice * (discountRate / 100));
      ControllerManager().prDiscountValueController.text =
          discountValue.toStringAsFixed(2);
      totalPrice -= discountValue;
    } else if (discountValue > 0) {
      // Apply discount value if discount rate is not used
      totalPrice -= discountValue;
    }

    // Ensure total price is not negative
    totalPrice = totalPrice < 0 ? 0 : totalPrice;

    // Add the tax percentage if applicable
    if (taxPercentageForOneItem > 0) {
      double taxAmount = totalPrice * (taxPercentageForOneItem / 100);
      totalPrice += taxAmount;
    }

    // Update the sales price controller with the final calculated price
    ControllerManager().prPriceController.text = totalPrice.toStringAsFixed(2);
    ControllerManager().prTotalTaxesController.text =
        totalTaxesPrice.toStringAsFixed(2);
  }

// Handle discount rate changes and update value accordingly

// Handle discount value changes and update rate accordingly

  List<ItemTaxsRelation>? selctedItemTaxsRelation = [];
  double selectedTaxesforItem = 0.0;

  FocusNode quantityFocusNode = FocusNode();
  void onQtyTextFieldLoseFocus() {
    doDiscountPercentage(selectedItem);
  }

  FocusNode unitPriceFocusNode = FocusNode();
  void onUnitPriceTextFieldLoseFocus() {
    doDiscountPercentage(selectedItem);
  }

  FocusNode discountVFocusNode = FocusNode();
  void onDiscountVTextFieldLoseFocus() {
    doDiscountValue(selectedItem);
  }

  FocusNode discountPFocusNode = FocusNode();
  void onDiscountPTextFieldLoseFocus() {
    doDiscountPercentage(selectedItem);
  }

  FocusNode invoiceDiscountPFocusNode = FocusNode();
  void onInvoiceDiscountPTextFieldLoseFocus() {
    updatePriceFromPercentage();
  }

  FocusNode invoiceDiscountVFocusNode = FocusNode();
  void onInvoiceDiscountVFocusNodeTextFieldLoseFocus() {
    updatePriceFromValue();
  }

  void fetchPrReturnDataByID({required int id}) async {
    /*  emit(SalesInvoiceLoading()); */
    var either = await purchaseRequestsUseCases.fetchPrReturnsDataByID(id: id);
    either.fold((l) {
      emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
      print(l.errorMessege);
    }, (r) async {
      selectedInvoice = r;
      selectedItemsList = r.itemsDetails ?? [];
/*       selectedPaymentType = getNameByID(r.paymentMethod!, paymentType)!;
 */
      /*    var either =
          await invoiceUseCases.fetchDrawerDataById(drawerId: r.drawerId!);
      either.fold(
          (l) => emit(AddPurchasesRequestError(errorMsg: l.errorMessege)), (r) {
        selectedDrawerEntity = r;
      }); */

      /*     selectedDrawerEntity =
          drawerEntityList.firstWhere((element) => element.id == r.drawerId); */
      for (var element in selectedItemsList) {
        totalPrices.add(double.parse(element.totalprice ?? "0.0"));
        totalTaxes.add(element.alltaxesvalue ?? 0.0);
      }
      updateReturnControllers(r);
      emit(GetInvoiceItemsSuccess(selectedItemsList: r.itemsDetails!));
      print("invoiceId : ${r.id}");
      print("pyment : ${r.paymentMethod}");
      emit(GetAllDatSuccess());
    });
  }

  void postSalesReport({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      var one =
          _parseControllerText(ControllerManager().prinvoicePaidController);
      var two =
          _parseControllerText(ControllerManager().prinvoiceNetController);
      if (_parseControllerText(ControllerManager().prinvoicePaidController) >
          _parseControllerText(ControllerManager().prinvoiceNetController)) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "لا يمكن دفع اكثر من الصافى",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else if (selectedItemsList.isEmpty) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "برجاء ادخال اصناف",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else if (!(_parseControllerText(
              ControllerManager().prinvoiceNetController) >
          0)) {
        emit(AddPurchasesRequestError(errorMsg: "لا يمكن دفع اكثر من المطلوب"));
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "لا يمكن اضافه الفاتوره ",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      } else {
        emit(SalesInvoiceLoading());
        var either = await purchaseRequestsUseCases.postPurchaseInvoice(
            purchaseRequestDataModel: addPurchaseReport());
        print("selectedCustomer.cusNameAr: ${selectedCustomer.cusNameAr}");
        either.fold((l) {
          print(l.errorMessege);
          emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
          Navigator.pop(context);
          Navigator.pop(context);
          QuickAlert.show(
            animType: QuickAlertAnimType.slideInUp,
            context: context,
            type: QuickAlertType.error,
            showConfirmBtn: false,
            title: "حدث خطأ ما",
            titleColor: AppColors.redColor,
            /* text: state.errorMsg, */
          );
        }, (r) {
          print("id : $r");
          emit(AddPurchasesInvoiceSuccess(invoiceId: r));
        });
      }
    } else {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInUp,
        context: context,
        type: QuickAlertType.error,
        showConfirmBtn: false,
        title: "برجاء ادخال جميع البيانات",
        titleColor: AppColors.redColor,
        /* text: state.errorMsg, */
      );
    }
  }

  void updateSalesReport(
      {required BuildContext context, required int id}) async {
    if (formKey.currentState!.validate()) {
      emit(SalesInvoiceLoading());
      var either = await purchaseRequestsUseCases.updateInvoiceRequest(
          purchaseRequestDataModel: updatePurchaseReport(), id: id);
      either.fold((l) {
        print(l.errorMessege);

        emit(AddPurchasesRequestError(errorMsg: l.errorMessege));
        /* Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context); */
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.error,
          showConfirmBtn: false,
          title: "حدث خطأ ما",
          titleColor: AppColors.redColor,
          /* text: state.errorMsg, */
        );
      }, (r) {
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInUp,
          context: context,
          type: QuickAlertType.success,
          showConfirmBtn: false,
          title: "تمت التعديل بنجاح",
          titleColor: AppColors.greenColor,
          /* text: state.errorMsg, */
        );
        print("editing");
        print("id : ${r.id}");
        emit(UpdatePurchasesRequestSuccess());
      });
    } else {
      SnackBarUtils.showSnackBar(
        context: context,
        label: "برجاء ادخال جميع البيانات",
        backgroundColor: AppColors.redColor,
      );
    }
  }

  void updateTotalQty() {
    try {
      // قراءة القيم من الـ controllers
      double qty = _parseControllerText(
          ControllerManager().prQuantityController,
          defaultValue: 1.0); // الكمية
      double length = _parseControllerText(
          ControllerManager().salesLengthController,
          defaultValue: 1.0); // الطول
      double width = _parseControllerText(
          ControllerManager().salesWidthController,
          defaultValue: 1.0); // العرض
      double height = _parseControllerText(
          ControllerManager().salesHeightController,
          defaultValue: 1.0); // الارتفاع

      // حساب إجمالي الكمية
      double totalQuantity = qty * length * width * height;

      // تحديث Controller الخاص بإجمالي الكمية
      ControllerManager().salesTotalQuantityController.text =
          totalQuantity.toStringAsFixed(2); // تحديث الـ TextField
    } catch (e) {
      print("Error updating total quantity: $e");
    }
  }

  String formatDate(String date) {
    DateTime date = DateTime.parse("2024-01-17 02:26:42");

    // Define your desired format
    String formattedDate = DateFormat('MMM d, y, h:mm:ss a').format(date);
    return formattedDate;
  }

  void updateReturnControllers(PrInvoiceEntity invoiceReportDm) {
    if (invoiceReportDm.code != null) {
      ControllerManager().invoiceCodeController.text =
          invoiceReportDm.code.toString();
    }
    if (invoiceReportDm.sourceCode != null) {
      ControllerManager().invoiceSourceCodeController.text =
          invoiceReportDm.sourceCode.toString();
    } else {
      ControllerManager().invoiceSourceCodeController.text = "";
    }
    if (storeList.isNotEmpty) {
      selectedStore = storeList.firstWhere(
        (element) => element.storeId == invoiceReportDm.storeId,
        orElse: () => null
            as StoreDataModel, // Return null if no matching element is found
      );
    }
    /*    if (customerData.isNotEmpty) {
      selectedCustomer = customerData.firstWhere(
        (element) => element.id == invoiceReportDm.customer,
        orElse: () => null
            as InvoiceCustomerDm, // Return null if no matching element is found
      );
    } */
    if (costCenterList.isNotEmpty) {
      selectedCostCenter = costCenterList.firstWhere(
        (element) => element.costCenter == invoiceReportDm.costcenter,
        orElse: () =>
            CostCenterDataModel(), // Return null if no matching element is found
      );
    }
    if (currencyList.isNotEmpty) {
      selectedCurrency = currencyList.firstWhere(
        (element) => element.id == invoiceReportDm.crncId,
        orElse: () => null
            as CurrencyDataModel, // Return null if no matching element is found
      );
    }

    ControllerManager().invoiceDateController.text =
        formatDate(invoiceReportDm.date.toString());

    ControllerManager().invoiceReceiveDateController.text =
        formatDate(invoiceReportDm.receiveDate.toString());

    ControllerManager().invoiceDueDateController.text =
        formatDate(invoiceReportDm.dueDate.toString());

    ControllerManager().invoiceRateController.text =
        selectedCurrency.rate.toString();
    /*   String? type = getNameByID(invoiceReportDm.paymentMethod!, paymentType);
    fetchpaymentTypeList();
    selectedPaymentType = paymentTypes.firstWhere(
      (element) => element == type,
      orElse: () => null as String, // Return null if no match is found
    ); */

    /*  selectedPaymentType = paymentTypes.firstWhere((element) => element == type); */
    ControllerManager().invoiceNotesController.text =
        invoiceReportDm.notes ?? "";
    if (invoiceReportDm.total != null) {
      ControllerManager().invoiceTotalPriceController.text =
          invoiceReportDm.total.toString();
    } else {
      ControllerManager().invoiceTotalPriceController.text = "0.0";
    }
    /*    if (invoiceReportDm.invTaxes != null) {
      ControllerManager().invoiceTotalTaxesController.text =
          invoiceReportDm.invTaxes.toString();
    } else {
      ControllerManager().invoiceTotalTaxesController.text = "0.0";
    } */
    if (invoiceReportDm.invDiscountP != null) {
      ControllerManager().invoiceDiscountPercentageController.text =
          invoiceReportDm.invDiscountP.toString();
    } else {
      ControllerManager().invoiceDiscountPercentageController.text = "0.0";
    }
    if (invoiceReportDm.invDiscountV != null) {
      ControllerManager().invoiceDiscountValueController.text =
          invoiceReportDm.invDiscountV.toString();
    } else {
      ControllerManager().invoiceDiscountValueController.text = "0.0";
    }
    if (invoiceReportDm.net != null) {
      ControllerManager().invoiceNetController.text =
          invoiceReportDm.net.toString();
    } else {
      ControllerManager().invoiceNetController.text = "0.0";
    }
    if (invoiceReportDm.paid != null) {
      ControllerManager().invoicePaidController.text =
          invoiceReportDm.paid.toString();
    } else {
      ControllerManager().invoicePaidController.text = "0.0";
    }
  }

  void updateInvoiceControllers(PrInvoiceDm invoiceReportDm) {
    if (invoiceReportDm.code != null) {
      ControllerManager().prinvoiceCodeController.text =
          invoiceReportDm.code.toString();
    }
    if (invoiceReportDm.sourceCode != null) {
      ControllerManager().prinvoiceSourceCodeController.text =
          invoiceReportDm.sourceCode.toString();
    } else {
      ControllerManager().prinvoiceSourceCodeController.text = "";
    }
    if (storeList.isNotEmpty) {
      selectedStore = storeList.firstWhere(
        (element) => element.storeId == invoiceReportDm.storeId,
        orElse: () => null
            as StoreDataModel, // Return null if no matching element is found
      );
    }
    /*    if (customerData.isNotEmpty) {
      selectedCustomer = customerData.firstWhere(
        (element) => element.id == invoiceReportDm.customer,
        orElse: () => null
            as InvoiceCustomerDm, // Return null if no matching element is found
      );
    } */
    if (costCenterList.isNotEmpty) {
      selectedCostCenter = costCenterList.firstWhere(
        (element) => element.costCenter == invoiceReportDm.costcenter,
        orElse: () =>
            CostCenterDataModel(), // Return null if no matching element is found
      );
    }
    if (currencyList.isNotEmpty) {
      selectedCurrency = currencyList.firstWhere(
        (element) => element.id == invoiceReportDm.crncId,
        orElse: () => null
            as CurrencyDataModel, // Return null if no matching element is found
      );
    }

    ControllerManager().purchaseInvoiceDateController.text =
        formatDate(invoiceReportDm.date.toString());

    ControllerManager().prinvoiceRateController.text =
        selectedCurrency.rate.toString();
    String? type = getNameByID(invoiceReportDm.paymentMethod!, paymentType);
    fetchpaymentTypeList();
    selectedPaymentType = paymentTypes.firstWhere(
      (element) => element == type,
      orElse: () => null as String, // Return null if no match is found
    );

    /*  selectedPaymentType = paymentTypes.firstWhere((element) => element == type); */
    ControllerManager().prinvoiceNotesController.text =
        invoiceReportDm.notes ?? "";
    if (invoiceReportDm.total != null) {
      ControllerManager().prinvoiceTotalPriceController.text =
          invoiceReportDm.total.toString();
    } else {
      ControllerManager().prinvoiceTotalPriceController.text = "0.0";
    }
    /*  if (invoiceReportDm.invTaxes != null) {
      ControllerManager().prinvoiceTotalTaxesController.text =
          invoiceReportDm.invTaxes.toString();
    } else {
      ControllerManager().prinvoiceTotalTaxesController.text = "0.0";
    } */
    if (invoiceReportDm.invDiscountP != null) {
      ControllerManager().prinvoiceDiscountPercentageController.text =
          invoiceReportDm.invDiscountP.toString();
    } else {
      ControllerManager().prinvoiceDiscountPercentageController.text = "0.0";
    }
    if (invoiceReportDm.invDiscountV != null) {
      ControllerManager().prinvoiceDiscountValueController.text =
          invoiceReportDm.invDiscountV.toString();
    } else {
      ControllerManager().prinvoiceDiscountValueController.text = "0.0";
    }
    if (invoiceReportDm.net != null) {
      ControllerManager().prinvoiceNetController.text =
          invoiceReportDm.net.toString();
    } else {
      ControllerManager().prinvoiceNetController.text = "0.0";
    }
  }
}
