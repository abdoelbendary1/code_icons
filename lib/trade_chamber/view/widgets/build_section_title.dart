import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/core/theme/styles_manager.dart';
import 'package:code_icons/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSectionTitle extends StatelessWidget {
  const BuildSectionTitle({
    super.key,
    this.subtitle = "",
    this.title = "",
  });
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Paddings.xXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: title!,
            textStyle: StylesManager.semiBold(
              fontSize: 25.sp,
              color: AppColors.blackColor,
            ),
          ),
          Sizes.size16.verticalSpace,
          CustomText(
              title: subtitle!,
              textStyle: StylesManager.medium(
                fontSize: 18.sp,
                color: AppColors.greyColor,
              )),
        ],
      ),
    );
  }
}
