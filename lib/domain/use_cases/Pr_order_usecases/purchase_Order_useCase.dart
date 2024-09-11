// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/PR_Order_repo.dart';
import 'package:dartz/dartz.dart';

class PurchaseOrderUseCases {
  PrOrderRepository prOrderRepository;
  PurchaseOrderUseCases({
    required this.prOrderRepository,
  });
  Future<Either<Failures, String>> deletePurchaseOrderById({required int id}) {
    return prOrderRepository.deletePurchaseOrderById(id: id);
  }

  Future<Either<Failures, String>> fetchTaxes() {
    return prOrderRepository.fetchTaxes();
  }

  Future<Either<Failures, String>> fetchVendors() {
    return prOrderRepository.fetchVendors();
  }

  Future<Either<Failures, String>> getPurchaseOrder() {
    return prOrderRepository.getPurchaseOrder();
  }

  Future<Either<Failures, String>> getPurchaseOrderById({required int id}) {
    return prOrderRepository.getPurchaseOrderById(id: id);
  }

  Future<Either<Failures, String>> postPurchaseOrder(
      {required PrOrderRequestDataModel prOrderRequestDataModel}) {
    return prOrderRepository.postPurchaseOrder(
        prOrderRequestDataModel: prOrderRequestDataModel);
  }
}
