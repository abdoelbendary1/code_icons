// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_icons/presentation/utils/theme/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  Widget body;
  List<Widget>? actions;
  String title;
  void Function()? onPressed;
  IconData? icon;
  CustomSliverAppBar(
      {super.key,
      required this.body,
      this.actions,
      required this.title,
      this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120.0.h,
          floating: true,
          pinned: false,
          leadingWidth: 80.w,
          leading: IconButton(
              onPressed: onPressed ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Icon(
                icon ?? Icons.arrow_back_ios,
                color: AppColors.whiteColor,
              )),
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            stretchModes: const [StretchMode.fadeTitle],
            expandedTitleScale: 1.5,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
            background: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [AppColors.blueColor, AppColors.lightBlueColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
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
