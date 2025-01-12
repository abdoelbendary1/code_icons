import 'package:code_icons/trade_chamber/core/widgets/Reusable_Custom_TextField.dart';
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
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.onTapOutside,
    this.color,
    this.onEditingComplete,
    this.focusNode,
  });
  Color? color;
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final IconData? icon;
  final void Function()? onTap;
  final bool? readOnly;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  TextInputType keyboardType;
  int? minLines;
  int? maxLines;
  int? maxLength;
  FocusNode? focusNode;
  void Function(PointerDownEvent)? onTapOutside;
  void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          ReusableCustomTextField(
            focusNode: focusNode,
            color: color,
            /* labelText: label ?? "", */
            hintText: hint ?? "",
            controller: controller,
            prefixIcon: icon,
            onTap: onTap,
            readOnly: readOnly,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyboardType,
            minLines: minLines,
            maxLines: maxLines,
            maxLength: maxLength,
            onTapOutside: onTapOutside,
            onEditingComplete: onEditingComplete,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
