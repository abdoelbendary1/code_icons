import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.fieldName,
    required this.hintText,
    this.suffixIcon,
    this.suffixIconPath,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });
  TextEditingController controller;
  String fieldName;
  bool obscure;
  String hintText;
  Widget? suffixIcon;
  String? suffixIconPath;
  String? Function(String?) validator;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            fieldName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.whiteColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.greyColor),
            errorStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.redColor),
            filled: true,
            fillColor: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
