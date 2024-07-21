import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/model/data_model/add_collection_table.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/add_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/cubit/all_daily_collector_cubit.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    allDailyCollectorCubit
        .fetchCustomerData()
        .whenComplete(() => allDailyCollectorCubit.fetchAllCollections());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDailyCollectorCubit, AllDailyCollectorState>(
      bloc: allDailyCollectorCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.h,
            centerTitle: false,
            backgroundColor:
                state is RowSelectedState ? Colors.blue : AppColors.blueColor,
            title: Text(
              state is RowSelectedState
                  ? '1 item selected'
                  : 'قائمة المحصلين اليومية',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddCollectionView(data: state.selectedRow),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        allDailyCollectorCubit.deselectRow();
                      },
                    ),
                  ]
                : [
                    IconButton(
                      icon: Icon(Icons.add, size: 30),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AddCollectionView.routeName);
                      },
                    ),
                  ],
          ),
          body: Column(
            children: [
              BlocConsumer<AllDailyCollectorCubit, AllDailyCollectorState>(
                bloc: allDailyCollectorCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllCollectionsSuccess) {
                    if (state.dataList.isNotEmpty) {
                      _dataSource = CollectionsDataSource(
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
                                  rowHeight: 60.h,
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
                                    buildGridColumn('customerName', 'الإسم',
                                        Alignment.centerRight),
                                    buildGridColumn('address', 'العنوان ',
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
                                    buildGridColumn('differentBl', 'متنوع',
                                        Alignment.centerRight),
                                    buildGridColumn('totalBl', 'إجمالي',
                                        Alignment.centerRight),
                                    /*   buildGridColumn('customerDataIdBl', 'ID',
                                        Alignment.centerRight), */
                                  ],
                                  selectionMode: SelectionMode.single,
                                  onSelectionChanged:
                                      (List<DataGridRow> addedRows,
                                          List<DataGridRow> removedRows) {
                                    if (addedRows.isNotEmpty) {
                                      Future.delayed(Duration.zero, () {
                                        if (mounted) {
                                          setState(() {
                                            TradeCollectionEntity selectedRow =
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
                  } else if (state is GetAllCollectionsError) {
                    return Center(child: Text('Error: ${state.errorMsg}'));
                  }
                  return SizedBox(height: 30, child: LoadingStateAnimation());
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
