
import 'package:code_icons/domain/di.dart';
import 'package:code_icons/presentation/auth/signUp/cubit/is_obsecure_cubit.dart';
import 'package:code_icons/presentation/auth/signUp/cubit/signup_state.dart';
import 'package:code_icons/presentation/auth/signUp/cubit/signup_view_model.dart';
import 'package:code_icons/presentation/auth/signUp/widgets/signup_body.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static const String routeName = "signup_screen";
  SignUpViewModel signUpViewModel =
      SignUpViewModel(signUpUseCase: injectSignUpUseCase());
  IsObsecureCubit isObsecureCubit = IsObsecureCubit();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpViewModel, SignUpState>(
      bloc: signUpViewModel,
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          DialogUtils.showLoading(
              context: context, message: state.loadingMessege);
        } else if (state is SignUpErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context, message: state.errorMessege!);
        } else if (state is SignUpSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: state.signUpRepositoryEntitiy?.data?.name ?? "");
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SignUpBody(
            formKey: signUpViewModel.formKey,
            fullnameController: signUpViewModel.fullnameController,
            mobileNoController: signUpViewModel.mobileNoController,
            emailController: signUpViewModel.emailController,
            passwordController: signUpViewModel.passwordController,
            confirPasswordController: signUpViewModel.confirmPasswordController,
            buttonFunction: signUpViewModel.signUp,
            passIsObsecureFunction: isObsecureCubit.changeObsecurePassword,
            confirmPassIsObsecureFunction:
                isObsecureCubit.changeObsecureConfirmPassword,
            isObsecureCubit: isObsecureCubit,
          )),
    );
  }
}
