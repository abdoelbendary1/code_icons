import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/widgets/custom_card.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HRScreen extends StatelessWidget {
  HRScreen({super.key});

  static const routeName = "HRScreen";

  MenuCubit menuCubit = MenuCubit();

  @override
  Widget build(BuildContext context) {
    var menuItems =
        ModalRoute.of(context)!.settings.arguments as List<MenuItem>;
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(context: context, title: "الموارد البشرية"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "قسم الموارد البشرية",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor.withOpacity(0.8),
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    "ماذا تريد ان تفعل الأن؟",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.greyColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String title = menuItems[index].title;

                String routeName = menuItems[index].route;

                return CustomCard(
                  title: title,
                  routeName: routeName,
                );
              },
              itemCount: menuItems.length,
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
