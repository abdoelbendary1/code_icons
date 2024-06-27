import 'package:code_icons/domain/use_cases/login_useCase.dart';
import 'package:code_icons/presentation/auth/login/cubit/login_state.dart';

import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel({required this.loginUseCase}) : super(LoginLoadinState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: "admin");
  TextEditingController passwordController =
      TextEditingController(text: "admin");

  late void Function()? buttonFunction;
  bool isObsecure = true;
  LoginUseCase loginUseCase;

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadinState());

      var either = await loginUseCase.invoke(
          emailController.text, passwordController.text);
      print("login");
      either.fold((failure) {
        emit(LoginErrorState(errorMessege: failure.errorMessege));
      }, (response) {
        emit(LoginSuccesState(loginRepositoryEntity: response));
      });
    }
  }
}
