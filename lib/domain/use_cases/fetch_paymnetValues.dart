import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class FetchPaymentValuesUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  FetchPaymentValuesUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, PaymentValuesEntity>> invoke(
      {required String customerId}) async {
    return await getCustomerDataRepo.fetchPaymentValuesByID(
        customerId: customerId);
  }
}
