import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableSelectTradeOffice extends StatefulWidget {
  ReusableSelectTradeOffice({
    super.key,
    required this.itemList,
    required this.selectedTradeOffice,
    required this.onChanged,
  });
  TradeOfficeEntity? selectedTradeOffice;
  List<TradeOfficeEntity> itemList;
  void Function(TradeOfficeEntity?)? onChanged;

  @override
  State<ReusableSelectTradeOffice> createState() =>
      _ReusableSelectTradeOfficeState();
}

class _ReusableSelectTradeOfficeState extends State<ReusableSelectTradeOffice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المكتب",
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
            child: DropdownButton<TradeOfficeEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                "اختيار المكتب",
              ),
              value: widget.selectedTradeOffice != null &&
                      widget.itemList.contains(widget.selectedTradeOffice)
                  ? widget.selectedTradeOffice
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
                  .map<DropdownMenuItem<TradeOfficeEntity>>(
                      (TradeOfficeEntity? value) {
                return DropdownMenuItem<TradeOfficeEntity>(
                  value: value,
                  child: Text(
                    value!.tradeOfficeBl ?? "Empty",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis),
                  ),
                );
              }).toList(),
              items: widget.itemList?.map<DropdownMenuItem<TradeOfficeEntity>>(
                  (TradeOfficeEntity value) {
                return DropdownMenuItem<TradeOfficeEntity>(
                  value: value,
                  child: Text(
                    value.tradeOfficeBl ?? "empty",
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
