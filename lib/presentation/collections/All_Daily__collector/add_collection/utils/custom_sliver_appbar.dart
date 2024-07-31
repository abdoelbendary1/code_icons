// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_icons/presentation/utils/theme/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  Widget body;
  List<Widget>? actions;
  String title;
  CustomSliverAppBar({
    super.key,
    required this.body,
    this.actions,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120.0.h,
          floating: true,
          pinned: false,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              stretchModes: const [StretchMode.fadeTitle],
              expandedTitleScale: 1.5,
              centerTitle: false,
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.blueColor, AppColors.lightBlueColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: AppColors.blueColor,
                ),
              )),
          actions: actions,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: body,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
