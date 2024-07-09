import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GetCustomerDataRemoteDataSource {
  Future<Either<Failures, List<CustomerDataEntity>>> fetchCustomerData();
  Future<Either<Failures, CustomerDataEntity>> fetchCustomerDataByID({required String customerId});
  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValuesByID(
      {String? customerId});
}
