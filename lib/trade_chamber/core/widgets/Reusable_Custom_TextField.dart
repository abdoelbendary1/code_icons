import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableCustomTextField extends StatelessWidget {
/*   final String labelText;
 */
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  void Function()? onTap;
  bool? readOnly;
  void Function(String)? onChanged;
  Key? textKey;
  int? minLines;
  int? maxLines;
  int? maxLength;
  Color? color;
  FocusNode? focusNode;
  void Function()? onEditingComplete;

  void Function(PointerDownEvent)? onTapOutside;

  ReusableCustomTextField({
    super.key,
/*     this.labelText,
 */
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.readOnly,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.onTapOutside,
    this.color,
    this.onEditingComplete,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      style: TextStyle(color: color ?? AppColors.blackColor),
      onTapOutside: (event) {},
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      mouseCursor: SystemMouseCursors.click,
      /* key: textKey, */
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      onTap: onTap,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        /*  labelText: labelText, */
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 20.sp, color: AppColors.blackColor.withOpacity(0.8)),
        hintText: hintText,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.blue) : null,
        suffixIcon:
            suffixIcon != null ? Icon(suffixIcon, color: Colors.blue) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.lightBlue[50],
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
      ),
    );
  }
}
