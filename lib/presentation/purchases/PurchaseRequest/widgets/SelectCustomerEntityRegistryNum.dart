import 'package:animated_custom_dropdown/custom_dropdown.dart';
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

class SelectCustomerEntityRegistryNum extends StatefulWidget {
  SelectCustomerEntityRegistryNum({
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
  State<SelectCustomerEntityRegistryNum> createState() =>
      _SelectCustomerEntityRegistryNumState();
}

class _SelectCustomerEntityRegistryNumState
    extends State<SelectCustomerEntityRegistryNum> {
  dynamic entityType;
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase());

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
    _loadMoreCustomers();
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
                  final filter = '["tradeRegistryBL","contains","${query}"]';
                  searchQuery = filter;
                  skip = 0;
                  customers.clear();
                  hasMoreData = true;
                  await _loadMoreCustomers(filter: searchQuery);
                  return customers;
                },
                overlayHeight: 500.h,
                overlayController: widget.overlayController,
                headerBuilder: (context, selectedItem, enabled) {
                  selectedItem as CustomerDataEntity;
                  return Text(
                    /*   selectedItem.toTradeRegistryBl(), */
                    selectedItem.tradeRegistryBl ?? "",
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
                          horizontal: 16.0, vertical: 24),
                      child: Row(
                        children: [
                          /*  Container(
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
                                ), */
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Text(
                                      item.brandNameBl ?? "",
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      /*                                   overflow: TextOverflow.ellipsis,
           */
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
                                        item.tradeRegistryBl ?? "",
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
                                          item.tradeRegistryTypeBl ?? 1),
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
                                        item.tradeOfficeNameBl ?? "",
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
                /*             excludeSelected: true,
           */
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
