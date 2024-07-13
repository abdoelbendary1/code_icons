// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class PostPaymentValuesByIdUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  PostPaymentValuesByIdUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, PaymentValuesEntity>> invoke(
      {int? customerId, List<int>? paidYears}) async {
    return await getCustomerDataRepo.postPaymenValuesByID(
        customerId: customerId, paidYears: paidYears);
  }
}
