import 'package:code_icons/data/model/response/charterParty/vessel_dm.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/ships/AddReport/cubit/add_ship_report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/domain/Uom/uom_entity.dart';
import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';

import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectShipEntity extends StatelessWidget {
  SelectShipEntity(
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
              selectedItem as Vessels;
              return Text(
                selectedItem.vesselNameBl!,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              item as Vessels;
              return Text(
                item.vesselNameBl!,
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

/* class SelectShipEntity extends StatefulWidget {
  SelectShipEntity(
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
  dynamic Function(dynamic)? onChanged;

  @override
  State<SelectShipEntity> createState() => _SelectShipEntityState();
}

class _SelectShipEntityState extends State<SelectShipEntity> {
  AddShipReportCubit addShipReportCubit = AddShipReportCubit();

  List<Vessels> customers = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),
          BlocConsumer<AddShipReportCubit, AddShipReportState>(
              listener: (context, state) {},
              bloc: addShipReportCubit,
              builder: (context, state) {
                return SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      SearchableDropdown<Vessels>.paginated(
                        leadingIcon: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 8.h),
                          child: Icon(Icons.account_tree_sharp),
                        ),
                        noRecordText: Text(
                          "تعثر العثور على بيانات حاليه",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        hasTrailingClearIcon: true,
                        dialogOffset: -10.h,
                        /* dropDownMaxHeight:
                            (WidgetsBinding.instance.window.viewInsets.bottom >
                                    0.0)
                                ? 600.h
                                : 290.h, */
                        isDialogExpanded: true,
                        backgroundDecoration: (child) => Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set your desired background color here
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: child,
                        ),
                        hintText: Text(
                          context
                                  .read<AddShipReportCubit>()
                                  .selectedShip
                                  .vesselNameBl ??
                              "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        paginatedRequest: (int page, String? searchKey) async {
                          print(page);

                          // If searchKey is null or empty, do not include the filter in the request
                          String? filter;
                          if (searchKey != null && searchKey.isNotEmpty) {
                            filter = '["brandNameBL","contains","$searchKey"]';
                          } else {
                            filter = null; // No filtering if searchKey is null
                          }

                          // Fetch the paginated customer data with or without the filter
                          List<Vessels> newShips =
                              await context.read<AddShipReportCubit>().ships;

                          // Create a copy of the list before adding new customers
                          List<Vessels> customersCopy = List.from(customers);

                          // Add new customers to the copied list
                          customersCopy.addAll(newShips);

                          // Return the new list of items for the dropdown
                          return customersCopy
                              .map(
                                  (ship) => SearchableDropdownMenuItem<Vessels>(
                                      onTap: () {
                                        print("object");
                                      },
                                      value: ship, // unique value
                                      label: ship.vesselNameBl ?? 'Unknown',
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Wrap(
                                                    children: [
                                                      Text(
                                                        ship.vesselNameBl
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.h),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )))
                              .toList();
                        },
                        requestItemCount: 2,
                        onChanged: widget.onChanged,
                        searchHintText: "بحث",
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
 */
