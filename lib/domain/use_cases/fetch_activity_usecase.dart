// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/activity/activity_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class FetchActivityListUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  FetchActivityListUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, List<ActivityEntity>>> invoke() async {
    return await getCustomerDataRepo.fetchActivityeData();
  }
}
