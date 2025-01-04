import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/sysSettings/ISysSetting.dart';
import 'package:code_icons/data/model/response/settings/StForm/st_form_dm.dart';
import 'package:code_icons/data/model/response/sysSettings/sys_settings.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/settings/StForm/st_form_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/enums/http_methods.dart';

class SysSettingManager implements ISysSettings {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;

  SysSettingManager(
      {required this.httpRequestHelper,
      required this.handleResponseHelper,
      required this.authManager});
  @override
  Future<Either<Failures, SysSettingsDM>> getSysSettingsData() async {
    try {
      // Check for network connectivity
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url =
          Uri.parse('http://${ApiConstants.chamberApi}"/api/systemSettings"');
      // Create the URL for the API request
      /*  var url = Uri.https(ApiConstants.chamberApi, '/api/systemSettings'); */

      // Get the token from the authManager
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the GET request using the httpRequestHelper
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      // Handle the response and map it to SysSettingsDM
      return await handleResponseHelper.handleResponse<SysSettingsDM>(
        response: response,
        fromJson: (json) => SysSettingsDM.fromJson(json),
      );
    } catch (e) {
      // Handle any errors and return them as Failures
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<StFormEntity>>> getStFormData() async {
    try {
      // Check for network connectivity
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.parse('http://${ApiConstants.chamberApi}/api/formNames');

      // Create the URL for the API request
      /*     var url = Uri.https(ApiConstants.chamberApi, '/api/formNames'); */

      // Get the token from the authManager
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Make the GET request using the httpRequestHelper
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      // Handle the response and map it to StFormDM
      return await handleResponseHelper.handleResponse<List<StFormEntity>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => StFormDm.fromJson(item)).toList(),
      );
    } catch (e) {
      // Handle any errors and return them as Failures
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
