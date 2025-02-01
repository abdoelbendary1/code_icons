import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/trade_chamber/features/show_customers/presentation/controller/cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCustomerEntityName extends StatelessWidget {
  SelectCustomerEntityName(
      {super.key,
      required this.itemList,
      required this.onChanged,
      this.title = "",
      this.hintText = "",
      this.initialItem,
      this.validator,
      this.headerFontSize = 14});
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
        vertical: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),
          CustomDropdown.search(
            headerBuilder: (context, selectedItem, enabled) {
              selectedItem as CustomerDataEntity;
              return Text(
                selectedItem.brandNameBl!,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              item as CustomerDataEntity;
              return Container(
                /*  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), */
                decoration: BoxDecoration(
                  color: AppColors.lightBlueColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.blueColor.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.whiteColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.brandNameBl!,
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              /*    mainAxisAlignment: MainAxisAlignment.spaceBetween, */
                              children: [
                                Flexible(
                                  child: Text(
                                    item.tradeRegistryBl!,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  CustomersCubit.customersCubit
                                      .getTypeById(item.tradeRegistryTypeBl!),
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    item.tradeOfficeNameBl!,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
