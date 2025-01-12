import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSize buildAppBar({required BuildContext context, String? title}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(120.h),
    child: Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [AppColors.blueColor, AppColors.lightBlueColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        toolbarHeight: 120.h,
        title: Text(
          title ?? "",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}
