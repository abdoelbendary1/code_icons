import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDrawerItem extends StatefulWidget {
  CustomDrawerItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.subtitleCount});
  String? title;
  String? subtitle;
  int subtitleCount;

  @override
  State<CustomDrawerItem> createState() => _CustomDrawerItemState();
}

class _CustomDrawerItemState extends State<CustomDrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 3),
      child: ExpansionTile(
        shape: LinearBorder.none,
        collapsedIconColor: AppColors.whiteColor,
        iconColor: AppColors.whiteColor,
        title: Text(
          widget.title ?? "",
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 23),
        ),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                trailing: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.whiteColor,
                ),
                title: Text(
                  widget.subtitle ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.yellowColor),
                ),
              ),
              itemCount: widget.subtitleCount,
            ),
          )
        ],
      ),
    );
  }
}
