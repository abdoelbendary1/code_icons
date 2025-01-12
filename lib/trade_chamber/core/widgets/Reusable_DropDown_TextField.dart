// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/trade_chamber/features/add_customer/presentation/view/grid_data_source.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/data/model/data_model/trader_DM.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReusableSelectTrader extends StatefulWidget {
  ReusableSelectTrader({
    super.key,
    required this.itemList,
    required this.selectedCustomer,
    required this.onChanged,
    required this.label,
  });
  CustomerDataEntity? selectedCustomer;
  List<CustomerDataEntity>? itemList;
  void Function(CustomerDataEntity?)? onChanged;
  String? label;
  @override
  State<ReusableSelectTrader> createState() => _ReusableSelectTraderState();
}

class _ReusableSelectTraderState extends State<ReusableSelectTrader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ?? "",
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
            child: DropdownButton<CustomerDataEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                AppLocalizations.of(context)!.select_Customer_hint_text,
              ),
              value: widget.selectedCustomer != null &&
                      widget.itemList!.contains(widget.selectedCustomer)
                  ? widget.selectedCustomer
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
                  .map<DropdownMenuItem<CustomerDataEntity>>(
                      (CustomerDataEntity? value) {
                return DropdownMenuItem<CustomerDataEntity>(
                  value: value,
                  child: Text(
                    value?.brandNameBl ?? "Empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.primaryColor, fontSize: 24),
                  ),
                );
              }).toList(),
              items: widget.itemList?.map<DropdownMenuItem<CustomerDataEntity>>(
                  (CustomerDataEntity value) {
                return DropdownMenuItem<CustomerDataEntity>(
                  value: value,
                  child: Text(
                    value.brandNameBl ?? "empty",
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
