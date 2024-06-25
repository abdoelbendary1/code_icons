import 'package:code_icons/presentation/auth/signUp/cubit/is_obsecure_cubit.dart';
import 'package:code_icons/presentation/auth/signUp/cubit/is_obsecure_state.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/presentation/utils/custom_button.dart';
import 'package:code_icons/presentation/utils/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({
    super.key,
    required this.formKey,
    required this.fullnameController,
    required this.mobileNoController,
    required this.emailController,
    required this.passwordController,
    required this.confirPasswordController,
    required this.buttonFunction,
    this.isObsecure = true,
    required this.passIsObsecureFunction,
    required this.confirmPassIsObsecureFunction,
    required this.isObsecureCubit,
  });
  late GlobalKey formKey;
  late TextEditingController fullnameController;
  late TextEditingController mobileNoController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirPasswordController;
  late void Function()? buttonFunction;
  late void Function()? passIsObsecureFunction;
  late void Function()? confirmPassIsObsecureFunction;
  late bool isObsecure;
  late IsObsecureCubit isObsecureCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*  SizedBox(
              height: 20.h,
            ), */
            //logo
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 20.h, left: 96.w, right: 96.w),
              child: Image.asset(AppAssets.logo),
            ),
            //form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Full name
                    CustomTextField(
                      controller: fullnameController,
                      fieldName: "Full Name",
                      hintText: "enter your full name",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Full Name field is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //mobile number
                    CustomTextField(
                      controller: mobileNoController,
                      fieldName: "Mobile Number",
                      hintText: "enter your mobile no.",
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Full Name field is required";
                        }
                        bool phoneValid =
                            RegExp(r"^[\d]{1,15}$").hasMatch(value);
                        if (!phoneValid) {
                          return "Mobile no. is not valid";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    //e-mail
                    CustomTextField(
                      controller: emailController,
                      fieldName: "E-Mail",
                      hintText: "enter your e-mail",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "e-mail field is required";
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return "e-mail is not valid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //password
                    BlocBuilder<IsObsecureCubit, IsObsecureState>(
                      bloc: isObsecureCubit,
                      builder: (context, state) {
                        return CustomTextField(
                          obscure: isObsecureCubit.passIsObsecure,
                          suffixIcon: InkWell(
                            onTap: passIsObsecureFunction,
                            child: Image.asset(isObsecureCubit.passViewIcon),
                          ),
                          controller: passwordController,
                          fieldName: "Password",
                          hintText: "enter your password",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "password field is required";
                            }
                            if (value.length < 6 || value.length > 30) {
                              return "password must be more than 6 char and less than 30 char";
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // confirm pass
                    BlocBuilder<IsObsecureCubit, IsObsecureState>(
                      bloc: isObsecureCubit,
                      builder: (context, state) {
                        return CustomTextField(
                          obscure: isObsecureCubit.confirmPassIsObsecure,
                          suffixIcon: InkWell(
                            onTap: confirmPassIsObsecureFunction,
                            child: Image.asset(
                                isObsecureCubit.confirmPassViewIcon),
                          ),
                          controller: confirPasswordController,
                          fieldName: "Confirm password",
                          hintText: "enter your password",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "confirm password field is required";
                            }
                            if (value != passwordController.text) {
                              return "confirm password is not identical";
                            }
                            if (value.length < 6 || value.length > 30) {
                              return "password must be more than 6 char and less than 30 char";
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    SizedBox(
                      height: 30.h,
                    ),

                    // login button
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20.h,
                      ),
                      child: CustomButton(
                        buttonText: "Sign Up",
                        buttonFunction: buttonFunction,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
