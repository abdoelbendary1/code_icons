import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableSelectCompanyType extends StatefulWidget {
  ReusableSelectCompanyType({
    super.key,
    required this.itemList,
    required this.selectedType,
    required this.onChanged,
  });

  final List<Map<String, dynamic>> itemList;
  Map<String, dynamic>? selectedType;
  void Function(Map<String, dynamic>?)? onChanged;

  @override
  State<ReusableSelectCompanyType> createState() =>
      _ReusableSelectCompanyTypeState();
}

class _ReusableSelectCompanyTypeState extends State<ReusableSelectCompanyType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ِشركة / فردي",
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
            child: DropdownButton<Map<String, dynamic>?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                "اختيار نوع الشركة",
              ),
              value: widget.selectedType != null &&
                      widget.itemList.contains(widget.selectedType)
                  ? widget.selectedType
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
              selectedItemBuilder: (context) => widget.itemList
                  .map<DropdownMenuItem<Map<String, dynamic>>>(
                      (Map<String, dynamic>? value) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: value,
                  child: Text(
                    value?['companyTypeBL'] ?? "Empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.primaryColor, fontSize: 18),
                  ),
                );
              }).toList(),
              items: widget.itemList
                  .map<DropdownMenuItem<Map<String, dynamic>>>(
                      (Map<String, dynamic> value) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: value,
                  child: Text(
                    value['companyTypeBL'] ?? "empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
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