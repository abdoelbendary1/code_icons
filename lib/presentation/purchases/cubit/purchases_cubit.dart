import 'package:bloc/bloc.dart';
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/request/add_purchase_request/Purchase_item_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/get_all_purchases_request/all_purchases_request_entity.dart';
import 'package:code_icons/domain/entities/purchase_item/itemUom/item_Uom.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/domain/entities/store/store_entity.dart';
import 'package:code_icons/domain/use_cases/purchase_request_usecase/purchase_request.useCase.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/cubit/purchase_request_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
part 'purchases_state.dart';

class PurchasesCubit extends Cubit<PurchasesState> {
  PurchasesCubit() : super(PurchasesInitial());
  PurchaseRequestsUseCases purchaseRequestsUseCases = PurchaseRequestsUseCases(
      purchaseRequestRepo: injectPurchaseRequestRepo());

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'birthDayBL': '',
    'licenseDateBL': '',
  };
  List<StoreEntity> storeList = [];
  List<CostCenterEntity> costCenterList = [];
  List<PurchaseItemEntity> itemsList = [];
  List<UomEntity> uomlist = [];
  List<ItemsDetails> selectedItemsList = [];
  List<PurchaseItemEntity> itemDetails = [];
  List<GetAllPurchasesRequestEntity> allPurchases = [];
  List<ItemUomEntity> selectedItemUom = [];

  late String selectedStatus;

  late int selectedCode;
  late String? selectedName;
  late int selectedUom;
  PurchaseItemEntity selectedItem = PurchaseItemEntity();
  List<PurchaseItemEntity> selectedfilterdItemList = [];

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
  late StoreEntity selectedStore;
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
    var selectedItemDetails = ItemsDetails(
      itemCode1: selectedItem.itemCode1,
      itemNameAr: selectedItem.itemId,
      qty: int.tryParse(
          ControllerManager().purchaseItemQuantitytemController.text),
      uom: selectedUom,
    );
    selectedItemsList.add(selectedItemDetails);

    emit(AddPurchasesItemSuccess());
    /*  emit(PurchasesInitial()); */
  }

  String convertToDateString(String input) {
    try {
      DateTime dateTime = DateTime.parse(input);
      String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      return 'Invalid date format';
    }
  }

  PurchaseRequestDataModel savePR() {
    return PurchaseRequestDataModel(
      itemsDetails: selectedItemsList,
      date: ControllerManager().purchaseDateController.text,
      status: getIdByName(selectedStatus, tradeStatusTypes).toString(),
      storeId: selectedStore.storeId,
    );
  }

  void addItem() {
    emit(AddPurchasesItemloading());
    /* selectedItemsList.add(selectedItem); */
  }

  /* void getPurchasesList() {
    emit(GetPurchasesListloading());
    emit(GetPurchasesListSuccess(purchases: purchases));
  }
 */
  void saveItem() {
    emit(AddPurchasesItemSuccess());
    emit(PurchasesInitial());
  }

  void updateTradeStatusType(String value) {
    emit(UpdateTradeStatusTypeLoading());
    String type = value;
    print(type);
    /* isSubBranchSelected = value?['type'] == "فرعي"; */
    emit(UpdateTradeStatusTypeSuccess(
        selectedTradeStatusType: selectedTradeStatusType, type: type));
  }

  StoreEntity selectStore({required String name}) {
    return selectedStore =
        storeList.where((element) => element.storeNameAr == name).first;
  }

  void selectName({required String name}) {
    selectedName = itemsList
        .where((element) => element.itemNameAr == name)
        .first
        .itemNameAr!;
  }

  void selectUom({required String name}) {
    selectedUom = uomlist.where((element) => element.uom == name).first.uomId!;
  }

  void getStoreData() async {
    var either = await purchaseRequestsUseCases.fetchStoreData();
    either.fold((l) => emit(getStoreDataError(errorMsg: l.errorMessege)), (r) {
      storeList = r;

      emit(getStoreDataSuccess(storeDataList: r));
      emit(PurchasesInitial());
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

  void fetchUom() async {
    var either = await purchaseRequestsUseCases.fetchUOMData();
    either.fold((l) => emit(getUomDataError(errorMsg: l.errorMessege)), (r) {
      uomlist = r;
      emit(GetUomDatSuccess(uomList: r));
      emit(PurchasesInitial());
    });
  }

  void fetchProductInfoDatalists() {
    getStoreData();
    getCostCenterData();
  }

  void getItemsData() async {
    var either = await purchaseRequestsUseCases.fetchPurchaseItemData();
    either.fold((l) => emit(getStoreDataError(errorMsg: l.errorMessege)), (r) {
      itemsList = r;

      /* emit(PurchasesInitial()); */
    });
  }

  void getItemByID({required int id}) async {
    var either =
        await purchaseRequestsUseCases.fetchPurchaseItemDataByID(id: id);
    either.fold((l) => emit(getItemDataByIDError(errorMsg: l.errorMessege)),
        (r) {
      emit(getItemDataByIDSuccess(purchaseItemEntity: r));

      /* emit(PurchasesInitial()); */
    });
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

  void selectItem({
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

  void addPurchaseRequest({required BuildContext context}) {
    if (formKey.currentState!.validate()) {
      purchaseRequestsUseCases.postPurchaseRequest(
          purchaseRequestDataModel: savePR());
      emit(AddPurchasesRequestSuccess());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "برجاء ادخال جميع البيانات",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.redColor,
        duration: Durations.extralong1,
      ));
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
}
