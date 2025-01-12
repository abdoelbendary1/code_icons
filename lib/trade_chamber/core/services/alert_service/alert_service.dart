import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AlertService {
  static void showError({
    required BuildContext context,
    required String errorMsg,
    QuickAlertAnimType animType = QuickAlertAnimType.slideInUp,
    bool? showConfirmBtn,
    bool? showCancelBtn,
    void Function()? onConfirmBtnTap,
    void Function()? onCancelBtnTap,
    String? confirmBtnText,
    String? cancelBtnText,
  }) {
    QuickAlert.show(
      animType: animType,
      context: context,
      confirmBtnText: confirmBtnText ?? "",
      cancelBtnText: cancelBtnText ?? "",
      type: QuickAlertType.error,
      showConfirmBtn: showConfirmBtn ?? false,
      title: errorMsg,
      showCancelBtn: showCancelBtn ?? false,
      titleColor: AppColors.redColor,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap,
    );
  }

  static void showSuccess({
    required BuildContext context,
    String? successMsg = "تمت العمليه بنجاح",
    String? confirmBtnText,
    bool? showConfirmBtn = false,
    void Function()? onConfirmBtnTap,
    QuickAlertAnimType animType = QuickAlertAnimType.slideInUp,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      showConfirmBtn: showConfirmBtn ?? false,
      confirmBtnText: (showConfirmBtn ?? false) ? (confirmBtnText ?? "") : "",
      title: successMsg,
      titleColor: AppColors.lightBlueColor,
      onConfirmBtnTap: onConfirmBtnTap,
    );
  }
}
