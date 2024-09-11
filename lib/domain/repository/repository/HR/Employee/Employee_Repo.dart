import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:dartz/dartz.dart';

import '../../../../../data/model/response/HR/Employee/employee_data_model.dart';
import '../../../../entities/failures/failures.dart';

abstract class EmployeeRepo {
  Future<Either<Failures, List<EmployeeDataModel>>> getAllEmployees();
  Future<Either<Failures, EmployeeDataModel>> getEmployeeByID(
      {required int id});
}
