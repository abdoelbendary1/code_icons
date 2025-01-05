// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/data/model/response/HR/Employee/employee_data_model.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';

class EmployeeManager implements EmployeeInterface {
  final AuthManagerInterface authManager;
  final HttpRequestHelper httpRequestHelper;
  HandleResponseHelper handleResponseHelper;
  EmployeeManager({
    required this.authManager,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });
  @override
  Future<Either<Failures, List<EmployeeDataModel>>> getAllEmployees() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.http(ApiConstants.chamberApi, ApiConstants.employeeEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<EmployeeDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => EmployeeDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, EmployeeDataModel>> getEmployeeByID(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.http(
          ApiConstants.chamberApi, "${ApiConstants.employeeEndPoint}/$id");
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<EmployeeDataModel>(
        response: response,
        fromJson: (json) => EmployeeDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
