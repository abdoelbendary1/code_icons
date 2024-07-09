// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/get_customer_data_remote.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';

class GetCustomerDataRepoImpl implements GetCustomerDataRepo {
  GetCustomerDataRemoteDataSource getCustomerDataRemoteDataSource;
  GetCustomerDataRepoImpl({
    required this.getCustomerDataRemoteDataSource,
  });
  @override
  Future<Either<Failures, List<CustomerDataEntity>>> fetchCustomerData() {
    return getCustomerDataRemoteDataSource.fetchCustomerData();
  }

  @override
  Future<Either<Failures, CustomerDataEntity>> fetchCustomerDataByID(
      {required String customerId}) {
    return getCustomerDataRemoteDataSource.fetchCustomerDataByID(
        customerId: customerId);
  }

  @override
  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValuesByID(
      {String? customerId}) {
    return getCustomerDataRemoteDataSource.fetchPaymentValuesByID(
        customerId: customerId);
  }
}
