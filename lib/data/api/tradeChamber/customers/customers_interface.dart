import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class CustomersDataInterface {
  Future<Either<Failures, List<CustomerDataModel>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  });
  Future<Either<Failures, CustomerDataModel>> fetchCustomerDataByID(
      {required String? customerId});
  Future<Either<Failures, String>> postCustomerData(
      {required CustomerDataModel customerData});
}
