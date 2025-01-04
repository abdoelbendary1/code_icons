/* import 'package:code_icons/data/model/data_model/add_collection_table.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/add_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/cubit/all_daily_collector_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class AllDailyCollectorScreen extends StatefulWidget {
  AllDailyCollectorScreen({super.key});

  static const routeName = "AllDailyCollectorScreen";

  @override
  State<AllDailyCollectorScreen> createState() =>
      _AllDailyCollectorScreenState();
}

class _AllDailyCollectorScreenState extends State<AllDailyCollectorScreen> {
  AllDailyCollectorCubit allDailyCollectorCubit = AllDailyCollectorCubit(
    fetchTradeCollectionDataUseCase: injectFetchTradeCollectionDataUseCase(),
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
  );

  late CollectionsDataSource _dataSource;
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    allDailyCollectorCubit.fetchCustomerData(skip: 0, take: 20).whenComplete(
        () => allDailyCollectorCubit.fetchAllCollections(skip: 0, take: 20));
  }

  DataPagerController dataPagerController = DataPagerController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDailyCollectorCubit, AllDailyCollectorState>(
      bloc: allDailyCollectorCubit,
      builder: (context, state) {
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
            buttonSize: const Size(56.0,
                56.0), // it's the SpeedDial size which defaults to 56 itself
            childrenButtonSize: const Size(
                56.0, 56.0), // it's the same as buttonSize by default
            direction:
                SpeedDialDirection.up, // default is SpeedDialDirection.up
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
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
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
          appBar: buildAppBar(context: context, title: "قائمه المحصلين"),
          body: Column(
            children: [
              BlocConsumer<AllDailyCollectorCubit, AllDailyCollectorState>(
                bloc: allDailyCollectorCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllCollectionsSuccess) {
                    if (state.dataList.isNotEmpty) {
                      _dataSource = CollectionsDataSource(
                        onPageChange: (skip, take) {
                          /*  allDailyCollectorCubit.fetchCustomerData(
                              skip: skip, take: take); */
                          allDailyCollectorCubit.fetchAllCollections(
                              skip: skip, take: take);
                        },
                        collections: state.dataList,
                        onRowSelected: (row) {
                          allDailyCollectorCubit.selectRow(row);
                        },
                        allDailyCollectorCubit: allDailyCollectorCubit,
                        context: context,
                      );
                    }

                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0.h,
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.whiteColor),
                                child: SfDataGridTheme(
                                  data: SfDataGridThemeData(
                                    gridLineColor: AppColors.blackColor,
                                    filterPopupDisabledTextStyle:
                                        const TextStyle(
                                            color: AppColors.blackColor),
                                    filterPopupTextStyle: const TextStyle(
                                        decorationColor: AppColors.blackColor,
                                        color: AppColors.blueColor,
                                        height: 2,
                                        fontWeight: FontWeight.bold,
                                        debugLabel: AutofillHints.addressCity),
                                    sortOrderNumberColor: AppColors.blueColor,
                                    gridLineStrokeWidth: 0,
                                    frozenPaneElevation: 0,
                                    frozenPaneLineWidth: 0,
                                    selectionColor: AppColors.lightBlueColor,
                                    headerColor: AppColors.blueColor,
                                    filterIconColor: AppColors.whiteColor,
                                    sortIconColor: AppColors.whiteColor,
                                    columnDragIndicatorColor:
                                        AppColors.whiteColor,
                                  ),
                                  child: SfDataGrid(
                                    onFilterChanged: (details) {
                                      print("object");
                                    },
                                    isScrollbarAlwaysShown: false,
                                    headerGridLinesVisibility:
                                        GridLinesVisibility.none,

                                    rowHeight: 120.h,
                                    gridLinesVisibility:
                                        GridLinesVisibility.horizontal,
                                    headerRowHeight: 100.h,
                                    rowsPerPage: 30,
                                    controller: dataGridController,
                                    source: _dataSource,
                                    allowSorting: true,
                                    allowFiltering: true,
                                    frozenColumnsCount:
                                        0, // Freezing the first column
                                    columns: [
                                      buildGridColumn('customerName', 'الإسم',
                                          Alignment.centerRight),
                                      buildGridColumn('collectionDateBl',
                                          'تاريح السجل', Alignment.centerRight),
                                      buildGridColumn('paymentReceiptNumBl',
                                          'رقم الايصال', Alignment.centerRight),
                                      buildGridColumn('compensationBl', 'تعويض',
                                          Alignment.centerRight),
                                      buildGridColumn('lateBl', 'متأخر',
                                          Alignment.centerRight),
                                      buildGridColumn('currentBl', 'حالي',
                                          Alignment.centerRight),
                                      buildGridColumn('activityBl', 'النشاط',
                                          Alignment.centerRight),
                                      buildGridColumn(
                                          'tradeRegistryTypeBl',
                                          'نوع السجل التجاري',
                                          Alignment.centerRight),
                                      buildGridColumn('differentBl', 'متنوع',
                                          Alignment.centerRight),
                                      buildGridColumn('totalBl', 'إجمالي',
                                          Alignment.centerRight),
                                      buildGridColumn('customerDataIdBl',
                                          'معرف العميل', Alignment.centerRight),
                                      buildGridColumn('lastPaidYearBl',
                                          'آخر سنة دفع', Alignment.centerRight),
                                      buildGridColumn('capitalBl', 'رأس المال',
                                          Alignment.centerRight),
                                      buildGridColumn('collectorNameBl',
                                          'اسم المحصل', Alignment.centerRight),
                                      buildGridColumn(
                                          'brandNameBl',
                                          'العلامة التجارية',
                                          Alignment.centerRight),
                                      buildGridColumn(
                                          'tradeRegistryBl',
                                          'السجل التجاري',
                                          Alignment.centerRight),
                                    ],
                                    selectionMode: SelectionMode.single,
                                    onSelectionChanged:
                                        (List<DataGridRow> addedRows,
                                            List<DataGridRow> removedRows) {
                                      /*     if (addedRows.isNotEmpty) {
                                        Future.delayed(Duration.zero, () {
                                          if (mounted) {
                                            setState(() {
                                              TradeCollectionEntity
                                                  selectedRow =
                                                  convertRowToEntity(
                                                      dataGridController
                                                          .selectedRow!);
                                              print(selectedRow.compensationBl);
                                              print(dataGridController
                                                  .selectedIndex);
                                              allDailyCollectorCubit
                                                  .selectRow(selectedRow);
                                            });
                                          }
                                        });
                                      } else {
                                        allDailyCollectorCubit.deselectRow();
                                      } */
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SfDataPagerTheme(
                            data: SfDataPagerThemeData(
                                backgroundColor: Colors.transparent,
                                selectedItemColor: AppColors.blueColor,
                                selectedItemTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor),
                                itemBorderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 60.h,
                              child: SfDataPager(
                                controller: dataPagerController,
                                itemHeight: 40.h,
                                availableRowsPerPage: const [10, 20, 30],
                                delegate: _dataSource,
                                pageCount: 10
                                /*  (_dataSource.collections.length.toDouble() /
                                            30)
                                        .ceilToDouble() */
                                ,
                                onPageNavigationStart: (pageIndex) {
                                  /* allDailyCollectorCubit.fetchCustomerData(
                                      skip: pageIndex * 20, take: 20); */
                                  allDailyCollectorCubit.fetchAllCollections(
                                      skip: pageIndex * 20, take: 20);
                                },
                                initialPageIndex: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetAllCollectionsError) {
                    print(state.errorMsg);
                    return Center(child: Text('Error: ${state.errorMsg}'));
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        LoadingStateAnimation(),
                        Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  GridColumn buildGridColumn(
      String columnName, String label, Alignment alignment) {
    return GridColumn(
      columnWidthMode: ColumnWidthMode.auto,
      columnName: columnName,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: alignment,
        child: Wrap(
          children: [
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  /*  TradeCollectionEntity convertRowToEntity(DataGridRow? row) {
    final cells = row!.getCells();
    return TradeCollectionEntity(
      collectionDateBl: cells[2].value.toString(),
      paymentReceiptNumBl: cells[3].value.toString(),
      compensationBl: cells[4].value as double?,
      lateBl: cells[5].value as double?,
      currentBl: cells[6].value as double?,
      differentBl: cells[7].value as double?,
      totalBl: cells[8].value as double?,
      /*  customerDataIdBl: cells[9].value as int?, */
    );
  } */
}
 */
