import 'package:code_icons/data/model/data_model/add_collection_table.dart';
import 'package:code_icons/data/model/data_model/unRegistered_collection_table.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/add_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/cubit/all_daily_collector_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_state.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class UnRegisteredCollectionsScreen extends StatefulWidget {
  UnRegisteredCollectionsScreen({super.key});

  static const routeName = "UnRegisteredCollectionsScreen";

  @override
  State<UnRegisteredCollectionsScreen> createState() =>
      _UnRegisteredCollectionsScreenState();
}

class _UnRegisteredCollectionsScreenState
    extends State<UnRegisteredCollectionsScreen> {
  UnlimitedCollectionCubit unlimitedCollectionCubit = UnlimitedCollectionCubit(
      postUnRegisteredTradeCollectionUseCase:
          injectPostUnRegisteredTradeCollectionUseCase(),
      getUnRegisteredTradeCollectionUseCase:
          injectGetUnRegisteredTradeCollectionUseCase());

  late UnlimitedCollectionsDataSource _dataSource;
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    /* unlimitedCollectionCubit.getAllCollctions(); */
  }

  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);
  var selectedfABLocation = FloatingActionButtonLocation.centerTop;
  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnlimitedCollectionCubit, UnlimitedCollectionState>(
      bloc: unlimitedCollectionCubit..getAllCollctions(),
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
                          ' إضافة حافظه غير مقيده',
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
                      context, UnlimitedCollection.routeName);
                },
              ),
            ],
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.h),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.blueColor, AppColors.lightBlueColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: AppBar(
                toolbarHeight: 120.h,
                leading: IconButton(
                  icon:
                      const Icon(Icons.arrow_back, color: AppColors.whiteColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "الحوافظ الغير مقيده",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              BlocConsumer<UnlimitedCollectionCubit, UnlimitedCollectionState>(
                bloc: unlimitedCollectionCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetUnlimitedCollectionsSuccess) {
                    if (state.collectiion.isNotEmpty) {
                      _dataSource = UnlimitedCollectionsDataSource(
                        collections: state.collectiion,
                        onRowSelected: (row) {
                          unlimitedCollectionCubit.selectRow(row);
                        },
                      );
                    }

                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  /*   gradient: const LinearGradient(
                                    colors: [
                                      AppColors.blueColor,
                                      AppColors.lightBlueColor
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerLeft,
                                  ), */
                                ),
                                child: SfDataGridTheme(
                                  data: SfDataGridThemeData(
                                    gridLineColor: AppColors.lightBlueColor,
                                    filterPopupDisabledTextStyle:
                                        const TextStyle(
                                            color: AppColors.blackColor),
                                    filterPopupTextStyle: const TextStyle(
                                        decorationColor: AppColors.blueColor,
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
                                    rowHeight: 120.h,
                                    gridLinesVisibility:
                                        GridLinesVisibility.both,
                                    headerRowHeight: 80.h,
                                    rowsPerPage: 10,
                                    controller: dataGridController,
                                    source: _dataSource,
                                    allowSorting: true,
                                    allowFiltering: true,
                                    frozenColumnsCount:
                                        1, // Freezing the first column
                                    columns: [
                                      /*   buildGridColumn(
                                          columnName: "collectionId",
                                          label: "Id",
                                          alignment: Alignment.centerRight), */
                                      buildGridColumn(
                                          columnName: "unlimitedName",
                                          label: "الاسم",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName: "unlimitedActivity",
                                          label: "النشاط",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName: "unlimitedAddress",
                                          label: "العنوان",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName: "unlimitedPaymentReceipt",
                                          label: "رقم الايصال",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName:
                                              "unlimitedPaymentReceiptDate",
                                          label: "تاريخ الايصال",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName: "unlimitedDivision",
                                          label: "الشعبه",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName: "unlimitedCurrentFinance",
                                          label: "الحالي",
                                          alignment: Alignment.centerRight),
                                      buildGridColumn(
                                          columnName: "unlimitedTotalFinance",
                                          label: "الاجمالي",
                                          alignment: Alignment.centerRight),
                                    ],
                                    selectionMode: SelectionMode.single,
                                    onSelectionChanged:
                                        (List<DataGridRow> addedRows,
                                            List<DataGridRow> removedRows) {
                                      if (addedRows.isNotEmpty) {
                                        Future.delayed(Duration.zero, () {
                                          if (mounted) {
                                            setState(() {
                                              /*   TradeCollectionEntity selectedRow =
                                                    convertRowToEntity(
                                                        dataGridController
                                                            .selectedRow!);
                                                print(selectedRow.compensationBl);
                                                print(dataGridController
                                                    .selectedIndex); */
                                              /* unlimitedCollectionCubit
                                                    .selectRow(selectedRow); */
                                            });
                                          }
                                        });
                                      } else {
                                        unlimitedCollectionCubit.deselectRow();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SfDataPager(
                            availableRowsPerPage: [10, 20, 30],
                            delegate: _dataSource,
                            pageCount: 7,
                            initialPageIndex: 1,
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetUnlimitedCollectionsError) {
                    return Center(child: Text('Error: ${state.errorMsg}'));
                  } else if (state is GetCollectionsLoading) {
                    return const Expanded(
                      child: Column(
                        children: [
                          Spacer(),
                          LoadingStateAnimation(),
                          Spacer(),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  GridColumn buildGridColumn(
      {required String columnName, String? label, Alignment? alignment}) {
    return GridColumn(
      columnWidthMode: ColumnWidthMode.auto,
      columnName: columnName,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: alignment,
        child: Wrap(
          children: [
            Text(
              label ?? "",
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

  TradeCollectionEntity convertRowToEntity(DataGridRow? row) {
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
  }
}
