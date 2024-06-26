
import 'package:code_icons/domain/use_cases/signup_usecase.dart';
import 'package:code_icons/presentation/auth/signUp/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpViewModel extends Cubit<SignUpState> {
  SignUpViewModel({required this.signUpUseCase}) : super(SignInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullnameController =
      TextEditingController(text: "abdo");
  TextEditingController mobileNoController =
      TextEditingController(text: "01064326251");
  TextEditingController emailController =
      TextEditingController(text: "abdo121015@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "1234567");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "1234567");

  SignUpUseCase signUpUseCase;

  void signUp() async {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoadingState());
      var either = await signUpUseCase.invoke(
        fullnameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        mobileNoController.text,
      );
      either.fold((failure) {
        print(failure.errorMessege);
        emit(SignUpErrorState(errorMessege: failure.errorMessege));
      }, (response) {
        emit(SignUpSuccessState(signUpRepositoryEntitiy: response));
      });
    }
  }
}
