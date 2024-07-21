import 'package:code_icons/domain/entities/station/station.dart';
import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableSelectStation extends StatefulWidget {
  ReusableSelectStation({
    super.key,
    required this.itemList,
    required this.selectedStation,
    required this.onChanged,
  });

  final List<StationEntity> itemList;
  StationEntity? selectedStation;
  void Function(StationEntity?)? onChanged;

  @override
  State<ReusableSelectStation> createState() => _ReusableSelectStationState();
}

class _ReusableSelectStationState extends State<ReusableSelectStation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "قسم / مركز",
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
            child: DropdownButton<StationEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                " قسم / مركز ",
              ),
              value: widget.selectedStation != null &&
                      widget.itemList.contains(widget.selectedStation)
                  ? widget.selectedStation
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
                  .map<DropdownMenuItem<StationEntity>>((StationEntity? value) {
                return DropdownMenuItem<StationEntity>(
                  value: value,
                  child: Text(
                    value?.stationBl ?? "Empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.primaryColor, fontSize: 24),
                  ),
                );
              }).toList(),
              items: widget.itemList
                  .map<DropdownMenuItem<StationEntity>>((StationEntity value) {
                return DropdownMenuItem<StationEntity>(
                  value: value,
                  child: Text(
                    value.stationBl ?? "empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
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
