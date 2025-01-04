// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/api/storage/IStorage.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/storage/itemCompany/item_company_dm.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';
import 'package:dartz/dartz.dart';

class AddItemCompanyUseCase {
  IStorage iStorage;
  AddItemCompanyUseCase({
    required this.iStorage,
  });

  Future<Either<Failures, ItemCompanyEntity>> postItemCompany(
      {required ItemCompanyDm item}) async {
    return await iStorage.postItemCompany(itemCompanyEntity: item);
  }
}
