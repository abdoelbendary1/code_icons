import 'dart:async';

import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/domain/use_cases/login_useCase.dart';
import 'package:code_icons/presentation/auth/login/cubit/login_state.dart';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel({required this.loginUseCase}) : super(LoginLoadinState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
/*     text: "admin",
 */
      );
  TextEditingController passwordController = TextEditingController(
/*     text: "admin",
 */
      );
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

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadinState());

      var either = await loginUseCase.invoke(
          emailController.text, passwordController.text);

      either.fold((failure) {
        emit(LoginErrorState(errorMessege: failure.errorMessege));
      }, (response) {
        var username = emailController.text;
        var password = passwordController.text;
        clearLoginRequest();

        saveLoginRequest(LoginRequest(
          userName: username,
          password: password,
        ));
        emit(LoginSuccesState(loginRepositoryEntity: response));
      });
    }
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
