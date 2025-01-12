// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/General_central/general_central_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/core/theme/app_colors.dart';

class ReusableSelectGeneralCentral extends StatefulWidget {
  ReusableSelectGeneralCentral({
    super.key,
    required this.itemList,
    required this.selectedGeneralCentral,
    required this.onChanged,
  });
  GeneralCentralEntity? selectedGeneralCentral;
  List<GeneralCentralEntity> itemList;
  void Function(GeneralCentralEntity?)? onChanged;
  @override
  State<ReusableSelectGeneralCentral> createState() =>
      _ReusableSelectTraderState();
}

class _ReusableSelectTraderState extends State<ReusableSelectGeneralCentral> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المركز العام",
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
            child: DropdownButton<GeneralCentralEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                "اختيار المركز العام",
              ),
              value: widget.selectedGeneralCentral != null &&
                      widget.itemList!.contains(widget.selectedGeneralCentral)
                  ? widget.selectedGeneralCentral
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
                  .map<DropdownMenuItem<GeneralCentralEntity>>(
                      (GeneralCentralEntity? value) {
                return DropdownMenuItem<GeneralCentralEntity>(
                  value: value,
                  child: Text(
                    value?.generalCenterNameBl ?? "Empty",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis),
                  ),
                );
              }).toList(),
              items: widget.itemList
                  ?.map<DropdownMenuItem<GeneralCentralEntity>>(
                      (GeneralCentralEntity value) {
                return DropdownMenuItem<GeneralCentralEntity>(
                  value: value,
                  child: Text(
                    value.generalCenterNameBl ?? "empty",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
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
