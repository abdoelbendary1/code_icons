// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/api/storage/IStorage.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/storage/itemCategory/item_category_entity.dart';
import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';
import 'package:dartz/dartz.dart';

class FetchUOMUsecase {
  IStorage iStorage;
  FetchUOMUsecase({
    required this.iStorage,
  });

  Future<Either<Failures, List<UomDataModel>>> fetchUOMData() async {
    return await iStorage.fetchUOMData();
  }

  Future<Either<Failures, List<ItemCompanyEntity>>> fetchItemCompanies() async {
    return await iStorage.fetchItemCompanies();
  }

  Future<Either<Failures, List<ItemCategoryEntity>>>
      fetchItemCategories() async {
    return await iStorage.fetchItemCategories();
  }
}
