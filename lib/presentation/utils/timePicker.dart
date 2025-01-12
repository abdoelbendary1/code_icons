// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimePicker extends StatelessWidget {
  BoardDateTimeTextController? controller;
  dynamic Function(DateTime) onChanged;
  void Function(bool, DateTime?, String)? onFocusChange;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  String? title;
  String? boardTitle;
  DateTime? initialDate;
  BoardDateTimeInputFieldValidators validators;
  CustomTimePicker({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onFocusChange,
    this.prefixIcon,
    this.suffixIcon,
    this.title,
    this.boardTitle,
    this.initialDate,
    required this.validators,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        BoardDateTimeInputField(
          controller: controller,
          readOnly: true,
          validators: validators,
          initialDate: initialDate,
          keyboardType: TextInputType.none,
          pickerType: DateTimePickerType.time,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            /*  labelText: labelText, */
            labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20.sp, color: AppColors.blackColor.withOpacity(0.8)),
            hintText: "00:00",
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.blue)
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.blue)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.lightBlue[50],
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
          ),
          options: BoardDateTimeOptions(
            activeColor: AppColors.whiteColor,
            customOptions: BoardPickerCustomOptions.every15minutes(),
            activeTextColor: AppColors.blackColor,
            foregroundColor: AppColors.lightBlueColor.withOpacity(0.1),
            boardTitleTextStyle: const TextStyle(),
            backgroundDecoration:
                const BoxDecoration(color: AppColors.whiteColor),
            boardTitle: boardTitle,
            inputable: false,
            showDateButton: true,
            textColor: AppColors.blueColor,
            languages: BoardPickerLanguages.en(),
          ),
          textStyle: Theme.of(context).textTheme.bodyLarge,
          onChanged: onChanged,
          onFocusChange: onFocusChange,
        ),
      ],
    );
  }
}
