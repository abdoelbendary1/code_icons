import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/domain/entities/CostCenter/cost_center_entity.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/invoice/customers/invoice_customer_entity.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCurrencyEntity extends StatelessWidget {
  SelectCurrencyEntity(
      {super.key,
      required this.itemList,
      required this.onChanged,
      this.title = "",
      this.hintText = "",
      this.initialItem,
      this.validator,
      this.headerFontSize = 12});
  String title;
  String hintText;
  final List<dynamic> itemList;
  dynamic initialItem;
  String? Function(dynamic)? validator;
  double? headerFontSize;
  dynamic entityType;

  dynamic Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 12.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 18.h),
          CustomDropdown.search(
            headerBuilder: (context, selectedItem, enabled) {
              selectedItem as CurrencyEntity;
              return Text(
                selectedItem.currencyNameAr!,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              item as CurrencyEntity;
              return Text(
                item.currencyNameAr!,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
/*             excludeSelected: true,
 */
            validator: validator,
            closeDropDownOnClearFilterSearch: true,
            canCloseOutsideBounds: true,
            initialItem: initialItem,
            hintText: hintText,
            hideSelectedFieldWhenExpanded: false,
            noResultFoundText: "لا يوجد بيانات",
            decoration: CustomDropdownDecoration(
                noResultFoundStyle:
                    const TextStyle(color: AppColors.whiteColor),
                searchFieldDecoration: const SearchFieldDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.greyColor,
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.greyColor,
                    ),
                    fillColor: AppColors.whiteColor,
                    textStyle: TextStyle(color: AppColors.blackColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                headerStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: headerFontSize,
                ),
                expandedSuffixIcon: const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AppColors.whiteColor,
                ),
                closedSuffixIcon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.whiteColor,
                ),
                closedFillColor: AppColors.blueColor,
                expandedFillColor: AppColors.blueColor,
                listItemStyle: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            items: itemList,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
