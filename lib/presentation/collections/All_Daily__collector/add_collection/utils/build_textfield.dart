import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({
    this.label,
    this.hint,
    required this.controller,
    this.icon,
    this.onTap,
    this.readOnly,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  final String? label;
  final String? hint;
  final TextEditingController controller;
  final IconData? icon;
  final void Function()? onTap;
  final bool? readOnly;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableCustomTextField(
          labelText: label ?? "",
          hintText: hint ?? "",
          controller: controller,
          prefixIcon: icon,
          onTap: onTap,
          readOnly: readOnly,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
