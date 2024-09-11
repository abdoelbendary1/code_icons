// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/model/response/HR/Employee/employee_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/repository/HR/Employee/Employee_Repo.dart';

class FetchEmployeeDataByIDUseCase {
  EmployeeRepo employeeRepo;
  FetchEmployeeDataByIDUseCase({
    required this.employeeRepo,
  });
  Future<Either<Failures, EmployeeDataModel>> getEmployeeByID(
      {required int id}) async {
    return await employeeRepo.getEmployeeByID(id: id);
  }
}
