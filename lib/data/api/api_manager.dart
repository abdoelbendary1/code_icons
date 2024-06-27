import 'dart:convert';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
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

  Future<Either<Failures, AuthResponseDM>> login(
    String username,
    String password,
  ) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl, ApiConstants.loginEndPoint);

        var request = http.MultipartRequest('POST', url);
        request.fields['UserName'] = username;
        request.fields['Password'] = password;

        var response = await request.send();
        var responseBody = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseBody);

        var loginResponse = AuthResponseDM.fromJson(jsonDecode(responseString));

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          /*  SharedPrefrence.saveData(
              key: "accessToken", value: loginResponse.accessToken!); */
          return right(loginResponse);
        } else if (responseString.isEmpty) {
          return left(ServerError(errorMessege: "NULL"));
        } else {
          return left(ServerError(
              errorMessege: loginResponse.message ?? "Server error"));
        }
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      return Left(Failures(errorMessege: e.toString()));
    }
  }
  /*  Future<Either<Failures, AuthResponseDM>> login(
    String username,
    String password,
  ) async {
    try {
      var connectivityResult =
          await Connectivity().checkConnectivity(); // User defined class
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var url = Uri.https(ApiConstants.baseUrl, ApiConstants.loginEndPoint);
        /* var url = Uri.parse("https://demoapi1.code-icons.com/api/Users/login"); */
        LoginRequest loginRequest =
            LoginRequest(UserName: username, Password: password);

        /*  var lang = SharedPrefrence.getData(key: "lang"); */

        var response =
            await http.post(url, body: loginRequest.toJson(), headers: {
          /*  "lang": lang.toString(), */
          'Content-Type': 'multipart/form-data',
        });
        var loginResponse;
        if (response.body.isNotEmpty) {
          loginResponse = AuthResponseDM.fromJson(jsonDecode(response.body));
        } else {
          loginResponse = AuthResponseDM(
              id: 2,
              name: "Empty",
              accessToken: "",
              screens: [],
              username: "empty");
        }
        print(response.statusCode);

        if (response.statusCode >= 200 && response.statusCode <= 300) {
          /*  SharedPrefrence.saveData(
              key: "accessToken", value: loginResponse.accessToken!); */
          return right(loginResponse);
        } else if (response.body.isEmpty) {
          return left(ServerError(errorMessege: "NULL"));
        } else {
          return left(ServerError(errorMessege: "Server error (Unknown data)"));
        }
      } else {
        return left(
            NetworkError(errorMessege: "check your internet connection"));
      }
    } catch (e) {
      return Left(Failures(errorMessege: e.toString()));
    }
  }
 */
}
