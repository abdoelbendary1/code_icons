// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/get_customer_data_remote.dart';

class GetCustomerDataRemoteDataSourceImpl
    implements GetCustomerDataRemoteDataSource {
  ApiManager apiManager;
  GetCustomerDataRemoteDataSourceImpl({
    required this.apiManager,
  });
  @override
  Future<Either<Failures, List<CustomerDataEntity>>> fetchCustomerData() async {
    var either = await apiManager.fetchCustomerData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, CustomerDataEntity>> fetchCustomerDataByID(
      {required String customerId}) async {
    var either = await apiManager.fetchCustomerDataByID(customerId: customerId);
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValuesByID(
      {String? customerId}) async {
  
    var either =
        await apiManager.fetchPaymentValuesByID(customerId: customerId);
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }
}
