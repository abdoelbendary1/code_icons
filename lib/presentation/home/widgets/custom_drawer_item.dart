import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMenuItem extends StatelessWidget {
  CustomMenuItem({
    super.key,
    required this.menuItems,
    required this.title,
    required this.icon,
  });
  String? title;

  List<MenuItem> menuItems;

  IconData? icon;

  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 3, right: 5),
      child: ExpansionTile(
        shape: LinearBorder.none,
        collapsedIconColor: AppColors.whiteColor,
        iconColor: AppColors.whiteColor,
        leading: Icon(
          icon,
          size: 20,
        ),
        title: Text(
          title ?? "",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold),
        ),
        children: menuItems.map((menuItem) {
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(menuItem.route);
            },
            /*  trailing: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColors.whiteColor,
                  ), */
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                menuItem.title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
