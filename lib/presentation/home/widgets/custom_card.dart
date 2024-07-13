import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    this.title,
    this.menuItem,
    this.icon,
    this.menuItemIndex,
    this.routeName,
  });
  String? title;
  List<MenuItem>? menuItem;
  IconData? icon;
  int? menuItemIndex;
  String? routeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName ?? "HomeScreen",
            arguments: menuItem);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.greyColor.withOpacity(0.15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(
                flex: 5,
              ),
              Icon(
                icon,
                size: 30,
              ),
              const Spacer(
                flex: 5,
              ),
              Text(
                textAlign: TextAlign.center,
                title ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.blackColor),
              ),
              const Spacer(
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
