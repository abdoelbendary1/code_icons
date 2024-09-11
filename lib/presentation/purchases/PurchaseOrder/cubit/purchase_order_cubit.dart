import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/request/add_pr_order/pr_order_request_data_model.dart';
import 'package:code_icons/domain/use_cases/Pr_order_usecases/purchase_Order_useCase.dart';
import 'package:equatable/equatable.dart';

part 'purchase_order_state.dart';

class PurchaseOrderCubit extends Cubit<PurchaseOrderState> {
  PurchaseOrderCubit({required this.purchaseOrderUseCases})
      : super(PurchaseOrderInitial());

  final PurchaseOrderUseCases purchaseOrderUseCases;

  Future<void> deletePurchaseOrderById(int id) async {
    emit(DeletePurchaseOrderLoading());
    final result = await purchaseOrderUseCases.deletePurchaseOrderById(id: id);
    result.fold(
      (failure) => emit(DeletePurchaseOrderError(failure.errorMessege)),
      (errorMessege) => emit(DeletePurchaseOrderSuccess(errorMessege)),
    );
  }

  Future<void> fetchTaxes() async {
    emit(FetchTaxesLoading());
    final result = await purchaseOrderUseCases.fetchTaxes();
    result.fold(
      (failure) => emit(FetchTaxesError(failure.errorMessege)),
      (errorMessege) => emit(FetchTaxesSuccess(errorMessege)),
    );
  }

  Future<void> fetchVendors() async {
    emit(FetchVendorsLoading());
    final result = await purchaseOrderUseCases.fetchVendors();
    result.fold(
      (failure) => emit(FetchVendorsError(failure.errorMessege)),
      (errorMessege) => emit(FetchVendorsSuccess(errorMessege)),
    );
  }

  Future<void> getPurchaseOrder() async {
    emit(GetPurchaseOrderLoading());
    final result = await purchaseOrderUseCases.getPurchaseOrder();
    result.fold(
      (failure) => emit(GetPurchaseOrderError(failure.errorMessege)),
      (errorMessege) => emit(GetPurchaseOrderSuccess(errorMessege)),
    );
  }

  Future<void> getPurchaseOrderById(int id) async {
    emit(GetPurchaseOrderByIdLoading());
    final result = await purchaseOrderUseCases.getPurchaseOrderById(id: id);
    result.fold(
      (failure) => emit(GetPurchaseOrderByIdError(failure.errorMessege)),
      (errorMessege) => emit(GetPurchaseOrderByIdSuccess(errorMessege)),
    );
  }

  Future<void> postPurchaseOrder(
      PrOrderRequestDataModel prOrderRequestDataModel) async {
    emit(PostPurchaseOrderLoading());
    final result = await purchaseOrderUseCases.postPurchaseOrder(
        prOrderRequestDataModel: prOrderRequestDataModel);
    result.fold(
      (failure) => emit(PostPurchaseOrderError(failure.errorMessege)),
      (errorMessege) => emit(PostPurchaseOrderSuccess(errorMessege)),
    );
  }
}
