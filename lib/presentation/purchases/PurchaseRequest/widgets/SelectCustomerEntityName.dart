import 'package:code_icons/trade_chamber/features/show_customers/presentation/controller/cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCustomerEntityName extends StatefulWidget {
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
  dynamic Function(dynamic)? onChanged;

  @override
  State<SelectCustomerEntityName> createState() =>
      _SelectCustomerEntityNameState();
}

class _SelectCustomerEntityNameState extends State<SelectCustomerEntityName> {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase());

  List<CustomerDataEntity> customers = [];

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
          BlocConsumer<AddCollectionCubit, AddCollectionState>(
              listener: (context, state) {},
              bloc: addCollectionCubit,
              builder: (context, state) {
                return SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      SearchableDropdown<CustomerDataEntity>.paginated(
                        changeCompletionDelay: Duration(seconds: 2),
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
                        hintText: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 8.h),
                          child: Text(
                            context
                                    .read<AddCollectionCubit>()
                                    .selectedCustomer
                                    .brandNameBl ??
                                "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
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
                          List<CustomerDataEntity> newCustomers = await context
                              .read<AddCollectionCubit>()
                              .fetchCustomerDataPages(
                                skip: (page - 1) * 20,
                                take: 20,
                                filter:
                                    filter, // Only apply the filter if it's valid
                              );

                          // Create a copy of the list before adding new customers
                          List<CustomerDataEntity> customersCopy =
                              List.from(customers);

                          // Add new customers to the copied list
                          customersCopy.addAll(newCustomers);

                          // Return the new list of items for the dropdown
                          return customersCopy
                              .map((customer) => SearchableDropdownMenuItem<
                                      CustomerDataEntity>(
                                  onTap: () {
                                    print("object");
                                  },
                                  value: customer, // unique value
                                  label: customer.brandNameBl ?? 'Unknown',
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors
                                            .lightBlueColor, // Background color for each item
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
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
                                                        customer.brandNameBl!,
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          customer
                                                              .tradeRegistryBl!,
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .whiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        CustomersCubit
                                                            .customersCubit
                                                            .getTypeById(customer
                                                                .tradeRegistryTypeBl!),
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          customer.tradeOfficeNameBl ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .whiteColor,
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))))
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

