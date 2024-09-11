// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/response/HR/Employee/employee_data_model.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/Employee/Employee_Repo.dart';
import 'package:code_icons/domain/repository/repository/HR/Employee/Employee_Repo.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  EmployeeDataSource employeeDataSource;
  EmployeeRepoImpl({
    required this.employeeDataSource,
  });

  @override
  Future<Either<Failures, List<EmployeeDataModel>>> getAllEmployees() {
    return employeeDataSource.getAllEmployees();
  }

  @override
  Future<Either<Failures, EmployeeDataModel>> getEmployeeByID(
      {required int id}) {
    return employeeDataSource.getEmployeeByID(id: id);
  }
}
