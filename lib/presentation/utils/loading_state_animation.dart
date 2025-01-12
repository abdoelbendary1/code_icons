import 'dart:ui';

import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingStateAnimation extends StatelessWidget {
  LoadingStateAnimation({super.key, this.leftDotColor, this.rightDotColor});
  Color? leftDotColor;
  Color? rightDotColor;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: leftDotColor ?? AppColors.blueColor,
            rightDotColor: rightDotColor ?? AppColors.lightBlueColor,
            size: 60));
  }
}
