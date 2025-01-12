import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/core/theme/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.borderRadius = 10.0,
    this.padding,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? (backgroundColor ?? AppColors.blueColor)
            : Colors.grey, // Disable background color
        foregroundColor: textColor ?? AppColors.whiteColor,
        textStyle: textStyle ?? Theme.of(context).textTheme.titleMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        label,
        style: StylesManager.medium(
          fontSize: 18.sp,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
