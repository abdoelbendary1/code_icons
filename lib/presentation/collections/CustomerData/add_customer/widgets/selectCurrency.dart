// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';

class ReusableSelectCurrency extends StatefulWidget {
  ReusableSelectCurrency({
    super.key,
    required this.itemList,
    required this.selectedCurrency,
    required this.onChanged,
  });
  CurrencyEntity? selectedCurrency;
  List<CurrencyEntity>? itemList;
  void Function(CurrencyEntity?)? onChanged;
  @override
  State<ReusableSelectCurrency> createState() => _ReusableSelectTraderState();
}

class _ReusableSelectTraderState extends State<ReusableSelectCurrency> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "العملة",
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
            child: DropdownButton<CurrencyEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                "اختيار العمله",
              ),
              value: widget.selectedCurrency != null &&
                      widget.itemList!.contains(widget.selectedCurrency)
                  ? widget.selectedCurrency
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
                  .map<DropdownMenuItem<CurrencyEntity>>(
                      (CurrencyEntity? value) {
                return DropdownMenuItem<CurrencyEntity>(
                  value: value,
                  child: Text(
                    value?.currencyNameAr ?? "Empty",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis),
                  ),
                );
              }).toList(),
              items: widget.itemList?.map<DropdownMenuItem<CurrencyEntity>>(
                  (CurrencyEntity value) {
                return DropdownMenuItem<CurrencyEntity>(
                  value: value,
                  child: Text(
                    value.currencyNameAr ?? "empty",
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
