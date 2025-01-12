
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildLoadingState extends StatelessWidget {
  const BuildLoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
        ),
        LoadingStateAnimation(),
      ],
    );
  }
}
