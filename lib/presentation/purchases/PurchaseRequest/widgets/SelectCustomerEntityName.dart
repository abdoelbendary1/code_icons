import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
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

/* import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/core/enums/searchCases.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
  dynamic entityType;
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase());

  final ScrollController _scrollController = ScrollController();
  List<CustomerDataEntity> customers = [];

  @override
  void initState() {
    super.initState();
    /* _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    }); */
    addCollectionCubit.scrollController
        .addListener(addCollectionCubit.onScroll);
    context.read<AddCollectionCubit>().stream.listen((state) {
      if (state is GetAllCustomerDataSuccess) {
        customers.addAll(state.customerData!);
      } else if (state is GetAllCustomerDataError) {}
    });
  }

  @override
  void dispose() {
    addCollectionCubit.scrollController.dispose();
    super.dispose();
  }
/* Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    await context
        .read<AddCollectionCubit>()
        .fetchCustomerDataPages(skip: skip, take: take, filter: filter);

    /*   context.read<AddCollectionCubit>().stream.listen((state) {
      if (state is GetAllCustomerDataSuccess) {
        skip += take;
        customers.addAll(state.customerData!);
        hasMoreData = state.customerData!.length == take;
        isLoading = false;
      } else if (state is GetAllCustomerDataError) {
        isLoading = false;
        hasMoreData = false;
      }
    }); */
  } */

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
          BlocBuilder<AddCollectionCubit, AddCollectionState>(
              bloc: addCollectionCubit,
              builder: (context, state) {
                return CustomDropdown.searchRequest(
                  futureRequestDelay: Durations.extralong1,
                  itemsScrollController: addCollectionCubit.scrollController,
                  searchRequestLoadingIndicator: LoadingStateAnimation(
                    leftDotColor: AppColors.whiteColor,
                    rightDotColor: AppColors.lightBlueColor,
                  ),
                  futureRequest: (query) async {
                    /*   final filter = '["brandNameBL","contains","${query}"]';
                    searchQuery = filter;
                    skip = 0;
                    customers.clear();
                    hasMoreData = true;
                    /*   await _loadMoreCustomers(filter: searchQuery); */ */
                    return customers;
                  },
                  overlayHeight: 650.h,
                  headerBuilder: (context, selectedItem, enabled) {
                    selectedItem as CustomerDataEntity;
                    return Text(
                      selectedItem.brandNameBl ?? "اسم التاجر",
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
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
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
                              horizontal: 16.0, vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          item.brandNameBl!,
                                          style: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            item.tradeRegistryBl!,
                                            style: const TextStyle(
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          CustomersCubit.customersCubit
                                              .getTypeById(
                                                  item.tradeRegistryTypeBl!),
                                          style: const TextStyle(
                                            color: AppColors.greyColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            item.tradeOfficeNameBl!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.greyColor,
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
                        ));
                  },
                  validator: widget.validator,
                  closeDropDownOnClearFilterSearch: true,
                  canCloseOutsideBounds: true,
                  initialItem: widget.initialItem,
                  hintText: widget.hintText,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      headerStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.headerFontSize,
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
                  items: customers,
                  onChanged: widget.onChanged,
                );
              })
        ],
      ),
    );
  }
} */ /* final PagingController<int, CustomerDataEntity> _pagingController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 20; */ /* Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (widget.title.isNotEmpty)
                                        Text(
                                          widget.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                        /* height: 200, */
                                        child: /* PagedListView<int, CustomerDataEntity>(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    pagingController: _pagingController,
                                    builderDelegate:
                                        PagedChildBuilderDelegate<CustomerDataEntity>(
                                      firstPageProgressIndicatorBuilder: (_) =>
                                          LoadingStateAnimation(),
                                      newPageProgressIndicatorBuilder: (_) =>
                                          LoadingStateAnimation(),
                                      noItemsFoundIndicatorBuilder: (_) =>
                                          Center(child: Text("No data available")),
                                      itemBuilder: (context, item, index) {
                                        return _buildCustomerTile(item);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ), */
                                            Padding(
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
                                                          item.brandNameBl!,
                                                          style: const TextStyle(
                                                            color:
                                                                AppColors.blackColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 25),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            item.tradeRegistryBl!,
                                                            style: const TextStyle(
                                                              color:
                                                                  AppColors.greyColor,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 16,
                                                            ),
                                                            overflow:
                                                                TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Text(
                                                          CustomersCubit
                                                              .customersCubit
                                                              .getTypeById(item
                                                                  .tradeRegistryTypeBl!),
                                                          style: const TextStyle(
                                                            color:
                                                                AppColors.greyColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow.ellipsis,
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
                                                            item.tradeOfficeNameBl!,
                                                            style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                                  AppColors.greyColor,
                                                              fontSize: 14,
                                                            ),
                                                            overflow:
                                                                TextOverflow.ellipsis,
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
                                        ),
                                      );
            },
          )
                          ])));
             */
/* Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    await context
        .read<AddCollectionCubit>()
        .fetchCustomerDataPages(skip: skip, take: take, filter: filter);

    /*   context.read<AddCollectionCubit>().stream.listen((state) {
      if (state is GetAllCustomerDataSuccess) {
        skip += take;
        customers.addAll(state.customerData!);
        hasMoreData = state.customerData!.length == take;
        isLoading = false;
      } else if (state is GetAllCustomerDataError) {
        isLoading = false;
        hasMoreData = false;
      }
    }); */
  } */

/*  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMoreData) {
      _loadMoreCustomers(filter: searchQuery);
    }
  } */

/*  Widget _buildCustomerTile(CustomerDataEntity item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.brandNameBl ?? "Unknown",
              style: const TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.tradeRegistryBl ?? "Unknown",
              style: const TextStyle(
                color: AppColors.greyColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await context.read<AddCollectionCubit>().fetchCustomerDataPages(
                skip: pageKey,
                take: _pageSize,
              );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
 */

/* import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCustomerEntityName extends StatefulWidget {
  SelectCustomerEntityName({
    Key? key,
    required this.onChanged,
    this.title = "",
    this.hintText = "",
    this.initialItem,
    this.validator,
    this.headerFontSize = 14,
  }) : super(key: key);

  final String title;
  final String hintText;
  final dynamic initialItem;
  final String? Function(dynamic)? validator;
  final double? headerFontSize;
  final Function(dynamic)? onChanged;

  @override
  _SelectCustomerEntityNameState createState() =>
      _SelectCustomerEntityNameState();
}

class _SelectCustomerEntityNameState extends State<SelectCustomerEntityName> {
  final PagingController<int, CustomerDataEntity> _pagingController =
      PagingController(firstPageKey: 0);
  final int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await context.read<AddCollectionCubit>().fetchCustomerDataPages(
                skip: pageKey,
                take: _pageSize,
              );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty)
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200,
            child: PagedListView<int, CustomerDataEntity>(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<CustomerDataEntity>(
                firstPageProgressIndicatorBuilder: (_) =>
                    LoadingStateAnimation(),
                newPageProgressIndicatorBuilder: (_) => LoadingStateAnimation(),
                noItemsFoundIndicatorBuilder: (_) =>
                    Center(child: Text("No data available")),
                itemBuilder: (context, item, index) {
                  return _buildCustomerTile(item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerTile(CustomerDataEntity item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.brandNameBl ?? "Unknown",
              style: const TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.tradeRegistryBl ?? "Unknown",
              style: const TextStyle(
                color: AppColors.greyColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
/* import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/core/enums/searchCases.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class SelectCustomerEntityName extends StatefulWidget {
  SelectCustomerEntityName({
    super.key,
    required this.itemList,
    required this.onChanged,
    this.title = "",
    this.hintText = "",
    this.initialItem,
    this.validator,
    this.headerFontSize = 14,
    this.overlayController,
  });
  String title;
  String hintText;
  final List<dynamic> itemList;
  dynamic initialItem;
  String? Function(dynamic)? validator;
  double? headerFontSize;
  OverlayPortalController? overlayController;

  dynamic Function(dynamic)? onChanged;

  @override
  State<SelectCustomerEntityName> createState() =>
      _SelectCustomerEntityRegistryNumState();
}

class _SelectCustomerEntityRegistryNumState
    extends State<SelectCustomerEntityName> {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase());

  int page = 0; // Start with the first page
  final int pageSize = 20; // Number of items to fetch per request
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<SearchableDropdownMenuItem<CustomerDataEntity>>>
      _fetchPaginatedData(int page, String? searchKey) async {
    if (isLoading || !hasMoreData) return [];

    setState(() {
      isLoading = true;
    });

    try {
      // Create the filter query based on searchKey
      String? filter;
      if (searchKey != null && searchKey.isNotEmpty) {
        filter = '["brandNameBL","contains","$searchKey"]'; // Apply the filter
        final paginatedList = await addCollectionCubit.fetchCustomerDataPages(
            skip: page * pageSize, take: pageSize, filter: filter);

        // Check if there is more data to load
        if (paginatedList.isEmpty || paginatedList.length < pageSize) {
          hasMoreData = false;
        }

        setState(() {
          isLoading = false;
          page++; // Increment the page for the next request
        });

        // Map results to the dropdown menu items
        return paginatedList
            .map((e) => SearchableDropdownMenuItem(
                  value: e,
                  label: e.brandNameBl ?? '',
                  child: Text(e.brandNameBl ?? 'Unknown'),
                ))
            .toList();
      }

      // Fetch paginated data with the applied filter
      final paginatedList = await addCollectionCubit.fetchCustomerDataPages(
        skip: page * pageSize,
        take: pageSize,
      );

      // Check if there is more data to load
      if (paginatedList.isEmpty || paginatedList.length < pageSize) {
        hasMoreData = false;
      }

      setState(() {
        isLoading = false;
        page++; // Increment the page for the next request
      });

      // Map results to the dropdown menu items
      return paginatedList
          .map((e) => SearchableDropdownMenuItem(
                value: e,
                label: e.brandNameBl ?? '',
                child: Text(e.brandNameBl ?? 'Unknown'),
              ))
          .toList();
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error during paginated request: $error');
      return [];
    }
  }

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
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<AddCollectionCubit, AddCollectionState>(
            bloc: addCollectionCubit,
            builder: (context, state) {
              return SearchableDropdown<CustomerDataEntity>.paginated(
                /*   backgroundDecoration: (p0) {
                  /*  item as CustomerDataEntity; */
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
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
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title.isNotEmpty)
                            Text(
                              widget.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ), /* Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Text(
                                      item.brandNameBl!,
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        item.tradeRegistryBl!,
                                        style: const TextStyle(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      CustomersCubit.customersCubit.getTypeById(
                                          item.tradeRegistryTypeBl!),
                                      style: const TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        item.tradeOfficeNameBl!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.greyColor,
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
                    ), */
                  );
                }, */
                hintText: const Text('Paginated request'),
                margin: const EdgeInsets.all(15),
                paginatedRequest: (int page, String? searchKey) async {
                  // Fetch paginated data every time a new page is requested
                  return _fetchPaginatedData(page, searchKey);
                },
                /* requestItemCount:
                    2, */ // Number of items to request per page scroll
                onChanged: (CustomerDataEntity? value) {
                  if (value != null) {
                    debugPrint('${value.brandNameBl}');
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
 */
