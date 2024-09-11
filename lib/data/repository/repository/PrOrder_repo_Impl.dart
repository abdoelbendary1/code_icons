// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/Pr_order_dataSource.dart';
import 'package:code_icons/domain/repository/repository/PR_Order_repo.dart';

class PrOrderOrderRepoImpl implements PrOrderRepository {
  PrOrderDataSource prOrderDataSource;
  PrOrderOrderRepoImpl({
    required this.prOrderDataSource,
  });
  @override
  Future<Either<Failures, String>> deletePurchaseOrderById({required int id}) {
    return prOrderDataSource.deletePurchaseOrderById(id: id);
  }

  @override
  Future<Either<Failures, String>> fetchTaxes() {
    return prOrderDataSource.fetchTaxes();
  }

  @override
  Future<Either<Failures, String>> fetchVendors() {
    return prOrderDataSource.fetchVendors();
  }

  @override
  Future<Either<Failures, String>> getPurchaseOrder() {
    return prOrderDataSource.getPurchaseOrder();
  }

  @override
  Future<Either<Failures, String>> getPurchaseOrderById({required int id}) {
    return prOrderDataSource.getPurchaseOrderById(id: id);
  }

  @override
  Future<Either<Failures, String>> postPurchaseOrder(
      {required PrOrderRequestDataModel prOrderRequestDataModel}) {
    return prOrderDataSource.postPurchaseOrder(
        prOrderRequestDataModel: prOrderRequestDataModel);
  }
}
