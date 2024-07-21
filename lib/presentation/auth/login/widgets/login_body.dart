import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/presentation/utils/custom_button.dart';
import 'package:code_icons/presentation/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatefulWidget {
  LoginBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.buttonFunction,
  });
  late GlobalKey formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late void Function()? buttonFunction;

  bool isObsecure = true;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //logo
            Padding(
              padding: EdgeInsets.only(
                  top: 46.h, bottom: 30.h, left: 96.w, right: 96.w),
              child: Image.asset(AppAssets.logo),
            ),
            SizedBox(
              height: 10.h,
            ),
            //text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 32.h, right: 32.h),
                  child: Text(
                    "مرحباً بعودتك",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32.h, right: 32.h),
                  child: Text(
                    "من فضلك ادخل اسم المستخدم وكلمه المرور",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20.h,
            ),
            //form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    //e-mail
                    CustomTextField(
                      controller: widget.emailController,
                      fieldName: "اسم المستخدم",
                      hintText: "من فضلك ادخل اسم المستخدم",
                      validator: (value) {
                        /* if (value == null || value.trim().isEmpty) {
                          return "e-mail field is required";
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return "e-mail is not valid";
                        } */
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //password
                    CustomTextField(
                      obscure: widget.isObsecure,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.isObsecure == true) {
                              widget.isObsecure = false;
                            } else {
                              widget.isObsecure = true;
                            }
                          });
                        },
                        child: Image.asset(widget.isObsecure
                            ? AppAssets.hidePass
                            : AppAssets.viewPass),
                      ),
                      controller: widget.passwordController,
                      fieldName: "كلمه المرور",
                      hintText: "من فضلك ادخل كلمه المرور",
                      validator: (value) {
                        /* if (value == null || value.trim().isEmpty) {
                          return "e-mail field is required";
                        }
                        if (value.length < 5 || value.length > 30) {
                          return "password must be more than 6 char and less than 30 char";
                        } */
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "هل نسيت كلمه المرور؟",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // login button
                    CustomButton(
                      buttonText: "تسجيل الدخول",
                      buttonFunction: widget.buttonFunction,
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
