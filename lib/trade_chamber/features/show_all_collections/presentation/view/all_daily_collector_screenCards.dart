import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/core/theme/styles_manager.dart';
import 'package:code_icons/core/widgets/custom_text.dart';
import 'package:code_icons/data/model/data_model/filter_searchDM.dart';
import 'package:code_icons/trade_chamber/core/widgets/Reusable_Custom_TextField.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/add_collection_view.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/view/widgets/selectSearchFitler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/trade_chamber/features/show_all_collections/presentation/controller/cubit/all_daily_collector_cubit.dart';
import 'package:code_icons/services/di.dart';
import 'package:intl/intl.dart';

class AllDailyCollectorScreenCards extends StatefulWidget {
  const AllDailyCollectorScreenCards({super.key});

  static const routeName = "AllDailyCollectorScreenCards";

  @override
  State<AllDailyCollectorScreenCards> createState() =>
      _AllDailyCollectorScreenCardsState();
}

class _AllDailyCollectorScreenCardsState
    extends State<AllDailyCollectorScreenCards> {
  AllDailyCollectorCubit allDailyCollectorCubit = AllDailyCollectorCubit(
    fetchTradeCollectionDataUseCase: injectFetchTradeCollectionDataUseCase(),
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
  );
  TextEditingController searchController = TextEditingController();

  static const _pageSize = 20;
  int skip = 0; // Initialize skip to start from the first page
  int take = 20; // Define the number of items per page (take size)
  final PagingController<int, TradeCollectionEntity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      allDailyCollectorCubit.fetchAllCollections(
        skip: pageKey,
        take: _pageSize,
      );
    });

    allDailyCollectorCubit.stream.listen((state) {
      if (state is GetAllCollectionsSuccess) {
        final isLastPage = state.dataList.length < take;

        if (isLastPage) {
          _pagingController.appendLastPage(state.dataList);
        } else {
          skip += take; // Update the skip value for the next page
          _pagingController.appendPage(state.dataList, skip);
        }
      } else if (state is GetAllCollectionsError) {
        _pagingController.error = state.errorMsg;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        gradientBoxShape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.blueColor, AppColors.lightBlueColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        switchLabelPosition: true,
        spaceBetweenChildren: 10,
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: AppColors.blueColor,
        foregroundColor: Colors.white,
        activeBackgroundColor: AppColors.blueColor,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(
            56.0, 56.0), // it's the SpeedDial size which defaults to 56 itself
        childrenButtonSize:
            const Size(56.0, 56.0), // it's the same as buttonSize by default
        direction: SpeedDialDirection.up, // default is SpeedDialDirection.up
        renderOverlay: true, // default is true
        overlayOpacity: 0.5, // default is 0.5
        overlayColor: Colors.black, // default is Colors.black
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0, // default is 6.0
        shape: const CircleBorder(), // default is CircleBorder
        children: [
          SpeedDialChild(
            /*  child: const Icon(Icons.add, color: Colors.white), */
            backgroundColor: AppColors.blueColor,
            labelWidget: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                gradient: const LinearGradient(
                  colors: [AppColors.blueColor, AppColors.lightBlueColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' إضافة تحصيل',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AddCollectionView.routeName);
            },
          ),
        ],
      ),
      appBar: buildAppBar(context: context, title: "بيان التسديدات"),
      body: Column(
        children: [
          SelectSearchFilter(
            itemList: [
              FilterSearchDM(
                id: 1,
                name: "الاسم",
              ),
              FilterSearchDM(
                id: 2,
                name: "رقم السجل",
              ),
            ],
            onChanged: (filter) {
              allDailyCollectorCubit.changeFilter(filter);
            },
            hintText: "اختيار",
            title: "بحث باستخدام",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                    child: ReusableCustomTextField(
                  controller: allDailyCollectorCubit.searchController,
                  hintText: "بحث",
                  /*  hint: "بحث", */
                )),
                SizedBox(width: 10.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      foregroundColor: AppColors.whiteColor,
                      backgroundColor: AppColors.blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    /*  allDailyCollectorCubit.fetchAllCollections(
                        skip: skip,
                        take: take,
                        filteSearchDm: allDailyCollectorCubit.selectedFilter,
                        filter: searchController.text); */
                    _pagingController.refresh();
                    print("Button Pressed: ${TextEditingController().text}");
                  },
                  child: const Text("بحث"),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: PagedListView<int, TradeCollectionEntity>(
              shrinkWrap: true,
              /*         physics: NeverScrollableScrollPhysics(),
           */
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<TradeCollectionEntity>(
                itemBuilder: (context, collection, index) {
                  // Format the date to 'yyyy-MM-dd' for display
                  String displayDate = DateFormat('y/MM/dd').format(
                      DateTime.parse(collection.collectionDateBl ??
                          DateTime.now().toIso8601String()));
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collection.brandNameBl ?? 'غير مسجل',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          /*  Text(
                                'المحصل: ${collection.collectorNameBl ?? 'غ.م'}',
                                style: TextStyle(color: Colors.grey[600]),
                              ), */
                        ],
                      ),
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetailRow('الاسم', collection.brandNameBl),
                        buildDetailRow(
                            'رقم الايصال', collection.paymentReceiptNumBl),
                        buildDetailRow(
                            'السجل التجاري', collection.tradeRegistryBl),
                        buildDetailRow('تاريخ السجل', displayDate),
                        buildDetailRow('رأس المال',
                            collection.capitalBl?.toStringAsFixed(2)),
                        buildDetailRow(
                            'إجمالي', collection.totalBl?.toStringAsFixed(2)),
                        buildDetailRow('تعويض',
                            collection.compensationBl?.toStringAsFixed(2)),
                        buildDetailRow(
                            'متأخر', collection.lateBl?.toStringAsFixed(2)),
                        buildDetailRow(
                            'حالي', collection.currentBl?.toStringAsFixed(2)),
                        /*   buildDetailRow(
                                'النشاط', collection.activityBl?.toStringAsFixed(2)), */
                        /*   buildDetailRow('نوع السجل التجاري',
                                collection.tradeRegistryTypeBl.toString()), */
                        /*   buildDetailRow(
                                'معرف العميل', collection.customerDataIdBl?.toString()), */
                        buildDetailRow('سنة الدفع',
                            collection.yearsOfRepaymentBl?.toString()),
                      ],
                    ),
                  );
                },
                firstPageProgressIndicatorBuilder: (_) =>
                    LoadingStateAnimation(),
                newPageProgressIndicatorBuilder: (_) => LoadingStateAnimation(),
                noItemsFoundIndicatorBuilder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Sizes.size40.verticalSpace,
                    CustomText(
                        title: "لا يوجد سجلات",
                        textStyle: StylesManager.semiBold(fontSize: 18.sp)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            value ?? 'N/A',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Row buildSaveButton({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
    required MainAxisAlignment mainAxisAlignment,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        BlocListener<AllDailyCollectorCubit, AllDailyCollectorState>(
          bloc: allDailyCollectorCubit,
          listener: (context, state) {
            /* if (state is AddPurchasesRequestSuccess) {
              SnackBarUtils.showSnackBar(
                context: GlobalVariable.navigatorState.currentContext!,
                label: "تمت الإضافه بنجاح",
                backgroundColor: AppColors.greenColor,
              );
              Navigator.pushReplacementNamed(
                  super.context, AllPurchasesScreen.routeName);
            } else if (state is AddPurchasesRequestError) {
              if (state.errorMsg.contains("400")) {
                SnackBarUtils.showSnackBar(
                  context: GlobalVariable.navigatorState.currentContext!,
                  label: "برجاء ادخال البيانات صحيحه",
                  backgroundColor: AppColors.redColor,
                );
              } else if (state.errorMsg.contains("500")) {
                SnackBarUtils.showSnackBar(
                  context: GlobalVariable.navigatorState.currentContext!,
                  label: "حدث خطأ ما",
                  backgroundColor: AppColors.redColor,
                );
                print(state.errorMsg);
              }
            } */
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPressed,
              child: Text(title),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        )
      ],
    );
  }
}
