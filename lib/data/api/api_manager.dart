import 'dart:convert';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/data/model/request/sign_up_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/Auth_response_DM.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/presentation/utils/shared_prefrence.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<Either<Failures, AuthResponseDm>> signUp(
    String name,
    String email,
    String password,
    String rePassword,
    String phone,
  ) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        SignUpRequest signUpRequest = SignUpRequest(
          email: email,
          name: name,
          password: password,
          phone: phone,
        );
        Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.signUpEndPoint);

        var response = await http.post(
          url,
          body: signUpRequest.toJson(),
        );
        var signUpResponse = AuthResponseDm.fromJson(jsonDecode(response.body));
        if (response.statusCode >= 200 && response.statusCode < 300) {
          print(signUpResponse.message);
          return right(signUpResponse);
        } else {
          return Left(ServerError(errorMessege: signUpResponse.message!));
        }
      } else {
        // no internet connection
        return Left(NetworkError(
            errorMessege: "no internet connection , check your internet"));
      }
    } catch (e) {
      return Left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Either<Failures, AuthResponseDm>> login(
    String email,
    String password,
  ) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl, ApiConstants.loginEndPoint);
        LoginRequest loginRequest =
            LoginRequest(email: email, password: password);

        var lang = SharedPrefrence.getData(key: "lang");

        var response =
            await http.post(url, body: loginRequest.toJson(), headers: {
          "lang": lang.toString(),
        });
        var loginResponse = AuthResponseDm.fromJson(jsonDecode(response.body));
        if (response.statusCode >= 200 && response.statusCode <= 300) {
          SharedPrefrence.saveData(
              key: "token", value: loginResponse.data!.token);
          return right(loginResponse);
        } else {
          return left(ServerError(
              errorMessege: loginResponse.data == null
                  ? loginResponse.message!
                  : loginResponse.message!));
        }
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      return Left(Failures(errorMessege: e.toString()));
    }
  }


}
