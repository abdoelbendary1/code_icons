import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/storage/salesItem_request.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/storage/itemCategory/item_category_dm.dart';
import 'package:code_icons/data/model/response/storage/itemCompany/item_company_dm.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/storage/itemCategory/item_category_entity.dart';
import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IStorage {
  Future<Either<Failures, List<UomDataModel>>> fetchUOMData();
  Future<Either<Failures, List<ItemCompanyEntity>>> fetchItemCompanies();
  Future<Either<Failures, ItemCompanyEntity>> postItemCompany(
      {required ItemCompanyDm itemCompanyEntity});

  Future<Either<Failures, List<ItemCategoryEntity>>> fetchItemCategories();
  Future<Either<Failures, int>> postItemCategory(
      {required ItemCategoryDm itemCategoryEntity});

  Future<Either<Failures, SalesItemDm>> addItemData(
      {required ItemRequest item});
}
