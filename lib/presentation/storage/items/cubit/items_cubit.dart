import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/storage/salesItem_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:code_icons/data/model/response/storage/itemCategory/item_category_dm.dart';
import 'package:code_icons/data/model/response/storage/itemCompany/item_company_dm.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/loginScreen.dart';
import 'package:code_icons/domain/entities/storage/itemCategory/item_category_entity.dart';
import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';
import 'package:code_icons/domain/use_cases/invoice/invoice.useCases.dart';
import 'package:code_icons/domain/use_cases/storage/add_item_category.dart';
import 'package:code_icons/domain/use_cases/storage/add_item_company.dart';
import 'package:code_icons/domain/use_cases/storage/add_item_usecase.dart';
import 'package:code_icons/domain/use_cases/storage/fetchUOM_usecase.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit({
    required this.fetchUOMUsecase,
    required this.addItemUseCase,
    required this.addItemCategoryUseCase,
    required this.itemCompanyUseCase,
  }) : super(ItemsInitial());
  InvoiceUseCases invoiceUseCases =
      InvoiceUseCases(invoiceInterface: injectInvoiceInterface());
  FetchUOMUsecase fetchUOMUsecase;
  AddItemUseCase addItemUseCase;
  AddItemCategoryUseCase addItemCategoryUseCase;
  AddItemCompanyUseCase itemCompanyUseCase;
  List<SalesItemDm> items = [];

  List<UomEntity> uomlist = [];
  List<ItemCompanyEntity> companiesList = [];
  List<ItemCategoryEntity> categoriesList = [];
  late ItemCompanyEntity selectedItemCompanyEntity;
  late ItemCategoryEntity selectedItemCategoryEntity;

  late UomEntity selectedUom = uomlist.first;
  List<SalesItemUom> selectedUomlist = [];
  int selectedType = 0;

  late ItemRequest selectedItem;
  ControllerManager controllerManager = ControllerManager();
  final formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> Type = [
    {'id': 0, 'name': "خام"},
    {'id': 1, 'name': "تام"},
    {'id': 2, 'name': "خدمة"},
  ];
  List<String> Types = [];
  void fetchTypeList() {
    for (var element in Type) {
      Types.add(element['name']);
    }
  }

  void fetchUom() async {
    var either = await fetchUOMUsecase.fetchUOMData();
    either.fold((l) {
      if (!isClosed) {
        print(l.errorMessege);
        emit(getUomDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      uomlist = r;
      if (!isClosed) {
        emit(GetUomDatSuccess(uomlist: r));
      }
    });
  }

  void postItemCategory({required ItemCategoryDm itemCategoryDm}) async {
    emit(AddItemCategoryLoading());
    var either =
        await addItemCategoryUseCase.postItemCategory(item: itemCategoryDm);
    either.fold((l) {
      if (!isClosed) {
        print(l.errorMessege);
        emit(AddItemCategoryError(errorMsg: l.errorMessege));
      }
    }, (r) {
      if (!isClosed) {
        emit(AddItemCategorySuccess());
      }
    });
  }

  void postItemCompany({required ItemCompanyDm itemCompanyDm}) async {
    emit(AddItemCategoryLoading());

    var either = await itemCompanyUseCase.postItemCompany(item: itemCompanyDm);
    either.fold((l) {
      if (!isClosed) {
        print(l.errorMessege);
        emit(AddItemCompanyError(errorMsg: l.errorMessege));
      }
    }, (r) {
      if (!isClosed) {
        emit(AddItemCompanySuccess());
      }
    });
  }

  void fetchCompanies() async {
    var either = await fetchUOMUsecase.fetchItemCompanies();
    either.fold((l) {
      if (!isClosed) {
        print(l.errorMessege);
        emit(getCompaniesDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      companiesList = r;
      if (!isClosed) {
        emit(GetCompaniesSuccess(companiesList: r));
      }
    });
  }

  void fetchCategories() async {
    var either = await fetchUOMUsecase.fetchItemCategories();
    either.fold((l) {
      if (!isClosed) {
        print(l.errorMessege);
        emit(getCategoriesDataError(errorMsg: l.errorMessege));
      }
    }, (r) {
      categoriesList = r;
      if (!isClosed) {
        emit(GetCategoriesSuccess(categoriesList: r));
      }
    });
  }

  void addItem({required ItemRequest item}) async {
    emit(AddItemLoading());
    var either = await addItemUseCase.addItemData(item: item);
    either.fold((l) {
      if (!isClosed) {
        emit(AddItemError(errorMsg: l.errorMessege));
      }
    }, (r) {
      if (!isClosed) {
        emit(AddItemSuccess());
      }
    });
  }

  int? getIdByName(String name, List<Map<String, dynamic>> list) {
    for (var item in list) {
      if (item['name'] == name) {
        selectedType = item['id'];
        return selectedType;
      }
    }
    return null; // Return null if the name is not found
  }

  ItemRequest createItem() {
    selectedItem = ItemRequest(
      itemNameAr: controllerManager.itemNameAr.text,
      smallUom: selectedUom.uomId,
      smallUoMprPrice: double.parse(controllerManager.itemSmallUomPriceP.text),
      smallUomPrice: double.parse(controllerManager.itemSmallUomPriceS.text),
      itemType: selectedType,
      category: selectedItemCategoryEntity.catId,
      company: selectedItemCompanyEntity.comId,
    );
    return selectedItem;
  }

  void initialze() async {
    /* emit(SalesInvoiceLoading()); */
    fetchUom();
    fetchCategories();
    fetchCompanies();
    fetchTypeList();
  }

  void fetchPurchaseItemData() async {
    emit(getAllItemsLoading());
    var either = await invoiceUseCases.fetchPurchaseItemData();
    either.fold((l) {
      print(l.errorMessege);
      emit(getAllItemsError(errorMsg: l.errorMessege));
    }, (r) {
      items = r;
      print("success");
      emit(getAllItemsSuccess(items: r));
    });
  }
}
