import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PrOrderRepository {
  Future<Either<Failures, String>> postPurchaseOrder(
      {required PrOrderRequestDataModel prOrderRequestDataModel});
  Future<Either<Failures, String>> getPurchaseOrder();
  Future<Either<Failures, String>> getPurchaseOrderById({required int id});
  Future<Either<Failures, String>> fetchTaxes();
  Future<Either<Failures, String>> fetchVendors();
  Future<Either<Failures, String>> deletePurchaseOrderById({required int id});
}
