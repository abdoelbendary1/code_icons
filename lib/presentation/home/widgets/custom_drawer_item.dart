import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMenuItem extends StatelessWidget {
  final String title;
  final List<MenuItem> menuItems;
  final IconData icon;

  CustomMenuItem({
    Key? key,
    required this.menuItems,
    this.title = "Menu Item",
    this.icon = Icons.menu, // Default icon
  }) : super(key: key);

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
          size: 20.sp,
          color: AppColors.whiteColor,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold),
        ),
        children: menuItems.map((menuItem) {
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(menuItem.route);
            },
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
