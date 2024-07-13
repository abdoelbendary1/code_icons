// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class FetchCustomerDataByIDUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  FetchCustomerDataByIDUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, CustomerDataEntity>> invoke({required String customerId}) async {
    return await getCustomerDataRepo.fetchCustomerDataByID(customerId: customerId);
  }
}
