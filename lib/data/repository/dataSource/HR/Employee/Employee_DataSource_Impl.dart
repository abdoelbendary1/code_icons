// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/response/HR/Employee/employee_data_model.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/Employee/Employee_Repo.dart';
import 'package:code_icons/domain/repository/repository/HR/Employee/Employee_Repo.dart';

class EmployeeDataSourceImpl implements EmployeeDataSource {
  EmployeeInterface employeeInterface;
  EmployeeDataSourceImpl({
    required this.employeeInterface,
  });

  @override
  Future<Either<Failures, List<EmployeeDataModel>>> getAllEmployees() async {
    var either = await employeeInterface.getAllEmployees();
    return either.fold((l) => Left(l), (response) => right(response));
  }

  @override
  Future<Either<Failures, EmployeeDataModel>> getEmployeeByID(
      {required int id}) async {
    var either = await employeeInterface.getEmployeeByID(id: id);
    return either.fold((l) => Left(l), (response) => right(response));
  }
}
