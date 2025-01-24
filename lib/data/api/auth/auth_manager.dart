import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/interfaces/IHttpClient.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/domain/entities/auth_repository_entity/auth_repo_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';

class AuthManager implements AuthManagerInterface {
  final IHttpClient httpClient;
  final HttpRequestHelper httpRequestHelper;
  HandleResponseHelper handleResponseHelper;

  AuthManager({
    required this.httpClient,
    required this.httpRequestHelper,
    required this.handleResponseHelper,
  });

  @override
  Future<Either<Failures, AuthResponseDM>> login(
      String username, String password) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.loginEndPoint);

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        fields: {
          'UserName': username,
          'Password': password,
        },
      );

      var result = await handleResponseHelper.handleResponse(
        response: response,
        customErrorMessages: {
          410: "تاكد من صحة بيانات اسم المستخدم وكلمة السر"
        },
        fromJson: (json) => AuthResponseDM.fromJson(json),
      );
      return result.fold((l) => left(l), (user) async {
        await saveUser(user);
        return right(user);
      });
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<void> saveUser(AuthRepoEntity user) async {
    var userBox = await Hive.openBox('userBox');
    await userBox.put('user', user);
  }

  @override
  Future<AuthRepoEntity?> getUser() async {
    var userBox = await Hive.openBox('userBox');
    return userBox.get('user') as AuthRepoEntity?;
  }
}
