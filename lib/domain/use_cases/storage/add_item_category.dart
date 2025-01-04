// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/api/storage/IStorage.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/storage/salesItem_request.dart';
import 'package:code_icons/data/model/response/storage/itemCategory/item_category_dm.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/storage/itemCategory/item_category_entity.dart';
import 'package:dartz/dartz.dart';

class AddItemCategoryUseCase {
  IStorage iStorage;
  AddItemCategoryUseCase({
    required this.iStorage,
  });

  Future<Either<Failures, int>> postItemCategory(
      {required ItemCategoryDm item}) async {
    return await iStorage.postItemCategory(itemCategoryEntity: item);
  }
}
