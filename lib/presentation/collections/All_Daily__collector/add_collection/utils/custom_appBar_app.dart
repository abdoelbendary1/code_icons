import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarApp extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBarApp({
    super.key,
    required this.appBarTitle,
    required this.actionBtntxt,
    required this.actionBtnFunc,
    required this.leadingIconFunc,
    this.centerTitle,
  });
  String? actionBtntxt;
  String? appBarTitle;
  void Function()? actionBtnFunc;
  void Function()? leadingIconFunc;
  bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(90.w, 20.h),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColors.greenColor,
            foregroundColor: AppColors.whiteColor,
            textStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onPressed: actionBtnFunc,
          child: Text(actionBtntxt ?? "press"),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
      surfaceTintColor: Colors.white,
      toolbarHeight: 120.h,
      leadingWidth: 50,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          onPressed: leadingIconFunc,
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.lightBlueColor,
            size: 30,
          ),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      centerTitle: centerTitle,
      title: Row(
        children: [
          Text(
            appBarTitle ?? "Title",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.h);
}
