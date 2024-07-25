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
          /*  floatingActionButton: SpeedDial(
              // animatedIcon: AnimatedIcons.menu_close,
              // animatedIconTheme: IconThemeData(size: 22.0),
              // / This is ignored if animatedIcon is non null
              // child: Text("open"),
              // activeChild: Text("close"),
              icon: Icons.add,
              activeIcon: Icons.close,
              spacing: 3,
              mini: mini,
              openCloseDial: isDialOpen,
              childPadding: const EdgeInsets.all(5),
              spaceBetweenChildren: 4,
              dialRoot: customDialRoot
                  ? (ctx, open, toggleChildren) {
                      return ElevatedButton(
                        onPressed: toggleChildren,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 18),
                        ),
                        child: const Text(
                          "Custom Dial Root",
                          style: TextStyle(fontSize: 17),
                        ),
                      );
                    }
                  : null,
              buttonSize:
                  buttonSize, // it's the SpeedDial size which defaults to 56 itself
              // iconTheme: IconThemeData(size: 22),
              label: extend
                  ? const Text("Open")
                  : null, // The label of the main button.
              /// The active label of the main button, Defaults to label if not specified.
              activeLabel: extend ? const Text("Close") : null,
        
              /// Transition Builder between label and activeLabel, defaults to FadeTransition.
              // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
              /// The below button size defaults to 56 itself, its the SpeedDial childrens size
              childrenButtonSize: childrenButtonSize,
              visible: visible,
              direction: speedDialDirection,
              switchLabelPosition: switchLabelPosition,
        
              /// If true user is forced to close dial manually
              closeManually: closeManually,
        
              /// If false, backgroundOverlay will not be rendered.
              renderOverlay: renderOverlay,
              // overlayColor: Colors.black,
              // overlayOpacity: 0.5,
              onOpen: () => debugPrint('OPENING DIAL'),
              onClose: () => debugPrint('DIAL CLOSED'),
              useRotationAnimation: useRAnimation,
              tooltip: 'Open Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              // foregroundColor: Colors.black,
              // backgroundColor: Colors.white,
              // activeForegroundColor: Colors.red,
              // activeBackgroundColor: Colors.blue,
              elevation: 8.0,
              animationCurve: Curves.elasticInOut,
              isOpenOnStart: false,
              shape: customDialRoot
                  ? const RoundedRectangleBorder()
                  : const StadiumBorder(),
              // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              children: [
                SpeedDialChild(
                  child: !rmicons ? const Icon(Icons.accessibility) : null,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  label: 'First',
                  onTap: () => setState(() => rmicons = !rmicons),
                  onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
                ),
                SpeedDialChild(
                  child: !rmicons ? const Icon(Icons.brush) : null,
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'Second',
                  onTap: () => debugPrint('SECOND CHILD'),
                ),
                SpeedDialChild(
                  child: !rmicons ? const Icon(Icons.margin) : null,
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  label: 'Show Snackbar',
                  visible: true,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(("Third Child Pressed")))),
                  onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
                ),
              ],
            ), */
          appBar: AppBar(
            toolbarHeight: 80.h,
            centerTitle: false,
            backgroundColor:
                state is RowSelectedState ? Colors.blue : AppColors.blueColor,
            title: Text(
              state is RowSelectedState
                  ? '1 item selected'
                  : 'قائمة الحوافظ الغير مقيده',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            actions: state is RowSelectedState
                ? [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        /*   Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddCollectionView(data: state.selectedRow),
                            ),
                          ); */
                      },
                    ),
                    /*    IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          allDailyCollectorCubit.deselectRow();
                        },
                      ), */
                  ]
                : [
                    /*   IconButton(
                        icon: Icon(Icons.add, size: 30),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AddCollectionView.routeName);
                        },
                      ), */
                    IconButton(
                      icon: Icon(Icons.add, size: 30),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, UnlimitedCollection.routeName);
                      },
                    ),
                  ],
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SfDataGridTheme(
                                data: SfDataGridThemeData(
                                  selectionColor: AppColors.lightBlueColor,
                                  headerColor: AppColors.blueColor,
                                  filterIconColor: AppColors.whiteColor,
                                  sortIconColor: AppColors.whiteColor,
                                ),
                                child: SfDataGrid(
                                  rowHeight: 120.h,
                                  gridLinesVisibility: GridLinesVisibility.both,
                                  headerRowHeight: 80.h,
                                  rowsPerPage: 10,
                                  controller: dataGridController,
                                  source: _dataSource,
                                  allowSorting: true,
                                  allowFiltering: true,
                                  frozenColumnsCount:
                                      1, // Freezing the first column
                                  columns: [
                                    buildGridColumn(
                                        columnName: "collectionId",
                                        label: "Id",
                                        alignment: Alignment.centerRight),
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
