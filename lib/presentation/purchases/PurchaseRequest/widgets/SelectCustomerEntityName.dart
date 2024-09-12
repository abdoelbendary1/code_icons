import 'package:animated_custom_dropdown/custom_dropdown.dart';
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

  /* final ScrollController _scrollController = ScrollController();
  List<CustomerDataEntity> customers = [];
  int skip = 0;
  final int take = 20;
  bool isLoading = false;
  bool hasMoreData = true;
  String searchQuery = '';

  /* @override
  void initState() {
    super.initState();
    context.read<AddCollectionCubit>().fetchCustomerDataPages(
          skip: skip,
          take: take,
        );
    customers = context.read<AddCollectionCubit>().customerData;
    _loadMoreCustomers(/* filter: searchQuery */);
    _scrollController.addListener(_onScroll);
  }
 */
  @override
  void initState() {
    super.initState();
    _loadInitialCustomers();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitialCustomers() async {
    searchQuery = ''; // Set default search filter or keep it empty
    skip = 0;
    customers.clear();
    hasMoreData = true;
    await _loadMoreCustomers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreCustomers({String? filter}) async {
    // Exit early if loading is in progress or there's no more data to load
    if (isLoading || !hasMoreData) return;

    isLoading = true;

    try {
      // Await fetching data from the Cubit
      await context.read<AddCollectionCubit>().fetchCustomerDataPages(
            skip: skip,
            take: take,
            filter: filter,
          );

      // Using a stream subscription to ensure we manage the subscription lifecycle
      final subscription =
          context.read<AddCollectionCubit>().stream.listen((state) {
        if (state is GetAllCustomerDataSuccess) {
          // If data is fetched successfully, append new data to the list
          skip += take;
          customers.addAll(state.customerData!);

          // Check if we need to load more data (i.e., if the received batch is smaller than `take`, no more data exists)
          hasMoreData = state.customerData!.length == take;
        } else if (state is GetAllCustomerDataError) {
          // If there's an error, stop further data loading
          hasMoreData = false;
        }

        // Always set `isLoading` to false after processing the state
        isLoading = false;
      });

      // Cancel the subscription to avoid multiple listeners on subsequent calls
      await subscription.cancel();
    } catch (e) {
      // In case of any exception, ensure `isLoading` is reset and prevent more data loading
      isLoading = false;
      hasMoreData = false;
      // Optionally log the error or display a message to the user
      print('Error loading customers: $e');
    }
  } */

/*   Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    try {
      final response =
          await context.read<AddCollectionCubit>().fetchCustomerDataPages(
                skip: skip,
                take: take,
                filter: filter,
              );

      // Process the successful response
      skip += take;
      customers.addAll(response); // Add the newly fetched customers
      hasMoreData = response.length == take;
    } catch (error) {
      // Handle the error (log, display a message, etc.)
      hasMoreData = false;
    } finally {
      isLoading = false;
    }
  } */
  /* Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    try {
      // Call the Cubit's function directly
      final response = await context
          .read<AddCollectionCubit>()
          .fetchCustomerDataPages(skip: skip, take: take, filter: filter);

      // Process the response without using stream.listen
      if (response.isNotEmpty) {
        skip += take; // Update the skip value for pagination
        customers.addAll(response);
        Future.delayed(Durations.extralong1); // Add the new data to the list
        hasMoreData = response.length == take;
        searchQuery = ""; // Check if more data can be loaded
      } else {
        hasMoreData = false; // No more data to load
      }
    } catch (error) {
      // Handle errors, e.g., log them or show a message
      hasMoreData = false;
    } finally {
      isLoading = false; // Reset the loading flag
    }
  } */

  /* Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    await context
        .read<AddCollectionCubit>()
        .fetchCustomerDataPages(skip: skip, take: take, filter: filter);

    context.read<AddCollectionCubit>().stream.listen((state) {
      if (state is GetAllCustomerDataSuccess) {
        skip += take;
        customers.addAll(state.customerData!);
        hasMoreData = state.customerData!.length == take;
        isLoading = false;
      } else if (state is GetAllCustomerDataError) {
        isLoading = false;
        hasMoreData = false;
      }
    });
  } */

  /* void _onScroll() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMoreData) {
      await _loadMoreCustomers(filter: searchQuery);
    }
  } */
  final ScrollController _scrollController = ScrollController();
  List<CustomerDataEntity> customers = [];
  int skip = 0;
  final int take = 20;
  bool isLoading = false;
  bool hasMoreData = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    /* customers.clear(); */
    /* _loadMoreCustomers(); */
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    context
        .read<AddCollectionCubit>()
        .fetchCustomerDataPages(skip: skip, take: take, filter: filter);

    context.read<AddCollectionCubit>().stream.listen((state) {
      if (state is GetAllCustomerDataSuccess) {
        skip += take;
        customers.addAll(state.customerData!);
        hasMoreData = state.customerData!.length == take;
        isLoading = false;
      } else if (state is GetAllCustomerDataError) {
        isLoading = false;
        hasMoreData = false;
      }
    });
  }

  /* Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    // Trigger the data fetch
    context
        .read<AddCollectionCubit>()
        .fetchCustomerDataPages(skip: skip, take: take, filter: filter);
  } */

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMoreData) {
      _loadMoreCustomers(filter: searchQuery);
    }
  }

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
            listener: (context, state) {
              if (state is GetAllCustomerDataSuccess) {
                skip += take;
                customers.addAll(state.customerData!);
                hasMoreData = state.customerData!.length == take;
                isLoading = false;
                /* setState(() {}); */
              } else if (state is GetAllCustomerDataError) {
                isLoading = false;
                hasMoreData = false;
                /*     setState(() {
                }); */

                // Optionally, show an error message here
              }
            },
            bloc: addCollectionCubit
              ..fetchCustomerDataPages(skip: skip, take: take),
            builder: (context, state) {
              return CustomDropdown.searchRequest(
                futureRequestDelay: Durations.extralong1,
                itemsScrollController: _scrollController,
                searchRequestLoadingIndicator: LoadingStateAnimation(
                  leftDotColor: AppColors.whiteColor,
                  rightDotColor: AppColors.lightBlueColor,
                ),
                futureRequest: (query) async {
                  final filter = '["brandNameBL","contains","${query}"]';
                  searchQuery = filter;
                  skip = 0;
                  customers.clear();
                  hasMoreData = true;
                  await _loadMoreCustomers(filter: searchQuery);
                  return customers;
                },
                overlayHeight: 650.h,
                headerBuilder: (context, selectedItem, enabled) {
                  selectedItem as CustomerDataEntity;
                  return Text(
                    selectedItem.brandNameBl ?? "",
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
                    ),
                  );
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
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
            },
          ),
        ],
      ),
    );
  }
}


/* class SelectCustomerEntityName extends StatefulWidget {
  SelectCustomerEntityName({
    super.key,
    required this.itemList,
    required this.onChanged,
    this.title = "",
    this.hintText = "",
    this.initialItem,
    this.validator,
    this.headerFontSize = 14,
  });

  final String title;
  final String hintText;
  final List<dynamic> itemList;
  final dynamic initialItem;
  final String? Function(dynamic)? validator;
  final double? headerFontSize;
  final dynamic Function(dynamic)? onChanged;

  @override
  State<SelectCustomerEntityName> createState() =>
      _SelectCustomerEntityNameState();
}

class _SelectCustomerEntityNameState extends State<SelectCustomerEntityName> {
  final ScrollController _scrollController = ScrollController();
  List<CustomerDataEntity> customers = [];
  int skip = 0;
  final int take = 20;
  bool isLoading = false;
  bool hasMoreData = true;
  String searchQuery = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreCustomers({String? filter}) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    // Fetch paginated data only when needed
    context
        .read<AddCollectionCubit>()
        .fetchCustomerDataPages(skip: skip, take: take, filter: filter);

    context.read<AddCollectionCubit>().stream.listen((state) {
      if (state is GetAllCustomerDataSuccess) {
        setState(() {
          skip += take;
          customers.addAll(state.customerData!);
          hasMoreData = state.customerData!.length == take;
          isLoading = false;
        });
      } else if (state is GetAllCustomerDataError) {
        setState(() {
          isLoading = false;
          hasMoreData = false;
        });
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMoreData) {
      _loadMoreCustomers(filter: searchQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),
          BlocListener<AddCollectionCubit, AddCollectionState>(
            bloc: AddCollectionCubit(
                fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
                fetchCustomerDataByIDUseCase:
                    injectFetchCustomerByIdDataUseCase(),
                fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
                postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
                paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase())
              ..fetchCustomerDataPages(skip: skip, take: take),
            listener: (context, state) {
              if (state is GetAllCustomerDataSuccess) {
                // Handle success state when needed, e.g., when dropdown is opened or search is performed
              } else if (state is GetAllCustomerDataError) {
                // Handle error state
              }
            },
            child: CustomDropdown.searchRequest(
              itemsScrollController: _scrollController,
              searchRequestLoadingIndicator: LoadingStateAnimation(),
              futureRequest: (query) async {
                final filter = '["brandNameBL","contains","${query}"]';
                searchQuery = filter;
                skip = 0;
                customers.clear();
                hasMoreData = true;
                await _loadMoreCustomers(filter: searchQuery);
                return customers;
              },
              overlayHeight: 650.h,
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
                                        .getTypeById(item.tradeRegistryTypeBl!),
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
                  ),
                );
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
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
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
            ),
          ),
        ],
      ),
    );
  }
}
 */