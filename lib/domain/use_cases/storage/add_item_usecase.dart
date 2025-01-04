// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/api/storage/IStorage.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/storage/salesItem_request.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AddItemUseCase {
  IStorage iStorage;
  AddItemUseCase({
    required this.iStorage,
  });

  Future<Either<Failures, SalesItemDm>> addItemData(
      {required ItemRequest item}) async {
    return await iStorage.addItemData(item: item);
  }
}
