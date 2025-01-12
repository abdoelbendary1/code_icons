import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/widgets/custom_card.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShipsManagmentScreen extends StatelessWidget {
  const ShipsManagmentScreen({super.key});
  static String routeName = "ShipsManagmentScreen";

  @override
  Widget build(BuildContext context) {
    var menuItems =
        ModalRoute.of(context)!.settings.arguments as List<MenuItem>;
    return Scaffold(
      appBar: buildAppBar(context: context, title: "اداره السفن"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*   Text(
                  "اداره السفن",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor.withOpacity(0.8),
                    fontSize: 25,
                  ),
                ), */
                SizedBox(
                  height: 5.h,
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
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
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
          )
        ],
      ),
    );
  }
}
