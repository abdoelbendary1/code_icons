// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/purchases/PR_order/PrOrderRequestInterface.dart';
import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/Pr_order_dataSource.dart';

class PrOrderDataSourceImpl extends PrOrderDataSource {
  PrOrderRequestInterface prOrderRequestInterface;
  PrOrderDataSourceImpl({
    required this.prOrderRequestInterface,
  });
  @override
  Future<Either<Failures, String>> deletePurchaseOrderById(
      {required int id}) async {
    var either = await prOrderRequestInterface.deletePurchaseOrderById(id: id);
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, String>> fetchTaxes() async {
    var either = await prOrderRequestInterface.fetchTaxes();
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, String>> fetchVendors() async {
    var either = await prOrderRequestInterface.fetchVendors();
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, String>> getPurchaseOrder() async {
    var either = await prOrderRequestInterface.getPurchaseOrder();
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, String>> getPurchaseOrderById(
      {required int id}) async {
    var either = await prOrderRequestInterface.getPurchaseOrderById(id: id);
    return either.fold((l) => left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, String>> postPurchaseOrder(
      {required PrOrderRequestDataModel prOrderRequestDataModel}) async {
    var either = await prOrderRequestInterface.postPurchaseOrder(
        prOrderRequestDataModel: prOrderRequestDataModel);
    return either.fold((l) => left(l), (response) => right(response));
  }
}
