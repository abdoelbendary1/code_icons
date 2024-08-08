import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.flickr(
                leftDotColor: AppColors.blueColor,
                rightDotColor: AppColors.lightBlueColor,
                size: 60,
              ),
              /*  const SizedBox(
                width: 10,
              ),
              Text(message), */
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: const TextStyle(
                color: AppColors.blueColor, fontWeight: FontWeight.bold),
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: const TextStyle(
                color: AppColors.redColor, fontWeight: FontWeight.bold),
          )));
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: AppColors.blueColor, width: 2),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(20.0),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          title: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.blueColor, AppColors.lightBlueColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  title ?? "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*  LoadingAnimationWidget.flickr(
                leftDotColor: AppColors.blueColor,
                rightDotColor: AppColors.lightBlueColor,
                size: 50,
              ),
              const SizedBox(height: 20), */
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.blackColor),
              ),
            ],
          ),
          actions: actions,
        );
      },
    );
  }
}

class SnackBarUtils {
  static void showSnackBar({
    required BuildContext context,
    required String label,
    required Color? backgroundColor,
  }) {
    /* showSnackBar(
        context: context, label: label, backgroundColor: backgroundColor); */
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundColor: backgroundColor,
      duration: Durations.extralong1,
    ));
  }

  static void hideCurrentSnackBar({
    required BuildContext context,
  }) {
    hideCurrentSnackBar(context: context);
  }
}
