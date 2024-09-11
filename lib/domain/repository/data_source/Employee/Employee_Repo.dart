import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:code_icons/data/model/response/HR/Employee/employee_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeeDataSource {
  Future<Either<Failures, List<EmployeeDataModel>>> getAllEmployees();
  Future<Either<Failures, EmployeeDataModel>> getEmployeeByID(
      {required int id});
}
