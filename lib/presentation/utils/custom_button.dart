import 'package:code_icons/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonFunction,
  });
  String buttonText;
  void Function()? buttonFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.titleLarge,
            foregroundColor: AppColors.primaryColor,
            backgroundColor: AppColors.whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r))),
        onPressed: buttonFunction,
        child: SizedBox(
            height: 64.h,
            width: 398.w,
            child: Center(
              child: Text(
                buttonText,
              ),
            )),
      ),
    );
  }
}
