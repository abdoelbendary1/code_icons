import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackBarType { error, confirm, success }

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  SnackBarType type = SnackBarType.confirm,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  String confirmText = "نعم",
  String cancelText = "إلغاء",
}) {
  final colors = {
    SnackBarType.error: Colors.red,
    SnackBarType.confirm: Colors.blue,
    SnackBarType.success: Colors.green,
  };

  final icons = {
    SnackBarType.error: Icons.error,
    SnackBarType.confirm: Icons.help,
    SnackBarType.success: Icons.check_circle,
  };

  final snackBar = SnackBar(
    duration: const Duration(seconds: 1), // Adjustable duration
    behavior: SnackBarBehavior.floating,
    backgroundColor: colors[type],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    content: Row(
      children: [
        Icon(icons[type], size: 24.sp, color: Colors.white),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            message,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    action: SnackBarAction(
      label: confirmText,
      textColor: Colors.white,
      onPressed: onConfirm ?? () {},
    ),
  );

  // Show the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
