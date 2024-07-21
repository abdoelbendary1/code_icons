import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingStateAnimation extends StatelessWidget {
  const LoadingStateAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: AppColors.blueColor,
            rightDotColor: AppColors.lightBlueColor,
            size: 60));
  }
}
