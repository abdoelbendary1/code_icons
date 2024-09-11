import 'package:code_icons/data/model/request/LoanRequest/loan_request_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ILoan {
  Future<Either<Failures, int>> addLoanRequest(
      {required LoanRequestDataModel loanRequestDataModel});
  Future<Either<Failures, List<LoanRequestDataModel>>> getAllLoanRequests();
  Future<Either<Failures, bool>> deleteLoanRequest(
      {required int loanRequestId});
}
