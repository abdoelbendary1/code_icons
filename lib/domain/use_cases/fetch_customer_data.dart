// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class FetchCustomerDataUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  FetchCustomerDataUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, List<CustomerDataEntity>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  }) async {
    return await getCustomerDataRepo.fetchCustomerData(
        skip: skip, take: take, filter: filter);
  }
}
