import 'package:code_icons/services/di.dart';
import 'package:code_icons/presentation/auth/login/cubit/login_state.dart';
import 'package:code_icons/presentation/auth/login/cubit/login_view_model.dart';
import 'package:code_icons/presentation/auth/login/widgets/login_body.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/shared_prefrence.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = "login_screen";
  LoginViewModel loginViewModel =
      LoginViewModel(loginUseCase: injectLoginUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel, LoginState>(
      bloc: loginViewModel,
      listener: (context, state) {
        if (state is LoginLoadinState) {
          DialogUtils.showLoading(
              context: context, message: state.loadingMessege);
        } else if (state is LoginErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context, message: state.errorMessege!);
          print(state.errorMessege);
        } else if (state is LoginSuccesState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: state.loginRepositoryEntity.name ?? "");
          print(state.loginRepositoryEntity.username);

          /*  var token = SharedPrefrence.saveData(
            key: "token",
            value: state.loginRepositoryEntity.accessToken,
          ); */

          /*   SharedPrefrence.saveData(
            key: "username",
            value: state.loginRepositoryEntity.username,
          ); */
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) {
              return false;
            },
          );
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: LoginBody(
            emailController: loginViewModel.emailController,
            passwordController: loginViewModel.passwordController,
            formKey: loginViewModel.formKey,
            buttonFunction: () {
              loginViewModel.login();
            },
          )),
    );
  }
}
