import 'package:code_icons/domain/entities/activity/activity_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableSelectActivity extends StatefulWidget {
  ReusableSelectActivity({
    super.key,
    required this.itemList,
    required this.selectedActivity,
    required this.onChanged,
  });
  ActivityEntity? selectedActivity;
  List<ActivityEntity> itemList;
  void Function(ActivityEntity?)? onChanged;

  @override
  State<ReusableSelectActivity> createState() => _ReusableSelectActivityState();
}

class _ReusableSelectActivityState extends State<ReusableSelectActivity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الشعبه",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.blackColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.0.h),
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton<ActivityEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                "اختيار الشعبه",
              ),
              value: widget.selectedActivity != null &&
                      widget.itemList!.contains(widget.selectedActivity)
                  ? widget.selectedActivity
                  : null,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.blue,
              ),
              iconSize: 24,
              elevation: 16,
              style: Theme.of(context).textTheme.titleSmall,
              underline: Container(),
              onChanged: widget.onChanged,
              selectedItemBuilder: (context) => widget.itemList!
                  .map<DropdownMenuItem<ActivityEntity>>(
                      (ActivityEntity? value) {
                return DropdownMenuItem<ActivityEntity>(
                  value: value,
                  child: Text(
                    value?.activityBl ?? "Empty",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                );
              }).toList(),
              items: widget.itemList.map<DropdownMenuItem<ActivityEntity>>(
                  (ActivityEntity value) {
                return DropdownMenuItem<ActivityEntity>(
                  value: value,
                  child: Text(
                    value.activityBl ?? "empty",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
