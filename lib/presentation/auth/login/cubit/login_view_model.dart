import 'dart:async';

import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:code_icons/domain/use_cases/login_useCase.dart';
import 'package:code_icons/presentation/auth/login/cubit/login_state.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel({required this.loginUseCase}) : super(LoginLoadinState());

  AuthManager authManager = AuthManager(
      httpClient: injectHttpClient(),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool authState = false;

  Future<bool> authenticate() async {
    try {
      bool check = await auth.canCheckBiometrics;
      print(check);
      if (check) {
        bool isAuthenticated = await auth.authenticate(
            localizedReason: "Login",
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ));
        authState = isAuthenticated;
        print("isAuthenticated ${isAuthenticated}");
        return isAuthenticated;
      } else {
        authState = authState;
        return false;
      }
    } on PlatformException catch (e) {
      print(e.toString());
      authState = authState;
      return false;
    }
  }

  void loginWithFingerPrint() async {
    LoginRequest? loginRequest = await getLoginRequest();
    try {
      if (loginRequest != null) {
        bool isAuth = await authenticate();
        if (isAuth) {
          emit(LoginLoadinState());

          var either = await loginUseCase.invoke(
            loginRequest.userName!,
            loginRequest.password!,
          );

          either.fold((failure) {
            emit(LoginErrorState(errorMessege: failure.errorMessege));
          }, (response) {
            print("login response =============> ${response.screens}");
            emit(LoginSuccesState(loginRepositoryEntity: response));
          });
        } else {
          /*   emit(LoginErrorState(
            errorMessege:
                "  لا يمكن التعرف على صاحب البصمه برجاء تسجيل الدخول ب اسم المستخدم مع كلمه السر")); */
        }
      } else {
        emit(LoginLoadinState());
        emit(LoginErrorState(errorMessege: "برجاء تسجيل الدخول اولا"));
      }
    } catch (e) {
      emit(LoginLoadinState());
      emit(LoginErrorState(errorMessege: e.toString()));
    }
  }

  late void Function()? buttonFunction;
  bool isObsecure = true;
  LoginUseCase loginUseCase;
  List<LoginScreensDM>? userScreens = [];

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadinState());

      var either = await loginUseCase.invoke(
          emailController.text, passwordController.text);

      either.fold((failure) {
        print("login error =============> ${failure.errorMessege}");
        emit(LoginErrorState(errorMessege: failure.errorMessege));
      }, (response) async {
        var username = emailController.text;
        var password = passwordController.text;
        authManager.saveUser(response);
        userScreens = response.screens;
        saveLoginScreens(response.screens ?? []);
        print("login response =============> ${response.screens}");
        clearLoginRequest();

        saveLoginRequest(LoginRequest(
          userName: username,
          password: password,
        ));
        emit(LoginSuccesState(loginRepositoryEntity: response));
      });
    }
  }

  Future<void> saveLoginScreens(List<LoginScreensDM> screens) async {
    var box = await Hive.openBox<LoginScreensDM>('loginScreensBox');

    // Clear existing data before saving, if needed
    await box.clear();

    // Add each screen to the box
    for (var screen in screens) {
      await box.add(screen);
    }

    print('LoginScreens saved to Hive.');
  }

  void saveLoginRequest(LoginRequest request) async {
    var box = Hive.box<LoginRequest>('login_requests');
    await box.put('current_login', request); // 'current_login' is a key
  }

  LoginRequest? getLoginRequest() {
    var box = Hive.box<LoginRequest>('login_requests');
    return box.get('current_login');
  }

  void clearLoginRequest() {
    var box = Hive.box<LoginRequest>('login_requests');
    box.clear();
  }
}

Future<List<LoginScreensDM>> getLoginScreens() async {
  var box = await Hive.openBox<LoginScreensDM>('loginScreensBox');

  // Get all the screens stored in the box
  List<LoginScreensDM> screens = box.values.toList();

  return screens;
}

void fetchAndDisplayScreens() async {
  List<LoginScreensDM> screens = await getLoginScreens();

  // Do something with the screens
  for (var screen in screens) {
    print('Screen ID: ${screen.id}, Form ID: ${screen.formId}');
  }
}
