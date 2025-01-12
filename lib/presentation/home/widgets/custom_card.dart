import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    this.title,
    this.menuItem,
    this.icon,
    this.menuItemIndex,
    this.routeName,
    this.labels,
  });

  String? title;
  List<MenuItem>? menuItem;
  IconData? icon;
  int? menuItemIndex;
  String? routeName;
  List<String>? labels; // New property for row of labels

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName!, arguments: menuItem);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 16.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.blueColor, AppColors.lightBlueColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Adjust based on your needs
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title ?? "",
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                icon != null
                    ? Icon(
                        icon,
                        size: 30,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.edit_document,
                        size: 30,
                        color: Colors.white,
                      ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
