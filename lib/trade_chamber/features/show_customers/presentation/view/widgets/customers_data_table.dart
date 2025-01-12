import 'package:code_icons/trade_chamber/features/add_customer/presentation/view/grid_data_source.dart';
import 'package:code_icons/trade_chamber/features/show_customers/presentation/controller/cubit/customers_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CustomersDataTable extends StatefulWidget {
  CustomersDataTable({
    super.key,
    required this.dataSource,
  });
  CustomerDataSource dataSource;
  @override
  State<CustomersDataTable> createState() => _CustomersDataTableState();
}

class _CustomersDataTableState extends State<CustomersDataTable> {
  CustomersCubit customersCubit = CustomersCubit(
    postCustomerDataUseCase: injectPostCustomerDataUseCase(),
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
    fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
    fetchCurrencyByIDUseCase: injectFetchCurrencyDataByIDUseCase(),
    fetchCurrencyUseCase: iinjectFetchCurrencyUseCase(),
    fetchActivityUseCase: injectFetchActivityListUseCase(),
    fetchGeneralCentralUseCase: injectFetchGeneralCentralListUseCase(),
    fetchTradeOfficeUseCase: injectFetchTradeOfficeListUseCase(),
    fetchStationListUseCase: injectFetchStationListUseCase(),
  );

  DataGridController dataGridController = DataGridController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightBlueColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(0),
              ),
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  gridLineColor: AppColors.blackColor,
                  filterPopupDisabledTextStyle:
                      const TextStyle(color: AppColors.blackColor),
                  filterPopupTextStyle: const TextStyle(
                      decorationColor: AppColors.blueColor,
                      color: AppColors.blackColor,
                      height: 2,
                      fontWeight: FontWeight.bold,
                      debugLabel: AutofillHints.addressCity),
                  sortOrderNumberColor: AppColors.blueColor,
                  gridLineStrokeWidth: 0,
                  frozenPaneElevation: 0,
                  frozenPaneLineWidth: 0,
                  /*  selectionColor: AppColors.lightBlueColor, */
                  headerColor: AppColors.blueColor,
                  filterIconColor: AppColors.whiteColor,
                  sortIconColor: AppColors.whiteColor,
                  columnDragIndicatorColor: AppColors.whiteColor,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor.withOpacity(0.1),
                  ),
                  child: SfDataGrid(
                    isScrollbarAlwaysShown: false,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    /*   showCheckboxColumn: true,
                      showSortNumbers: true, */
                    rowHeight: 120.h,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    headerRowHeight: 100.h,
                    rowsPerPage: 30,
                    controller: dataGridController,
                    source: widget.dataSource,
                    allowSorting: true,
                    allowFiltering: true,
                    frozenColumnsCount: 0, // Freezing the first column
                    columns: [
                      buildGridColumn(
                          columnName: 'brandNameBL',
                          labelUp: 'الإسم',
                          labelDown: 'التجاري',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'addressBL',
                          labelUp: 'العنوان',
                          labelDown: '',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'nationalIdBL',
                          labelUp: 'الرقم',
                          labelDown: 'القومي',
                          maxWidth: MediaQuery.of(context).size.width * 0.5.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'tradeRegistryBL',
                          labelUp: 'رقم',
                          labelDown: 'السجل',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'licenseDateBL',
                          labelUp: 'تاريخ',
                          labelDown: 'الترخيص',
                          maxWidth: MediaQuery.of(context).size.width * 0.45.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'activityNameBL',
                          labelUp: 'النشاط',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'tradeOfficeNameBL',
                          labelUp: 'المكتب',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'capitalBL',
                          labelUp: 'رأس',
                          labelDown: 'المال',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'tradeTypeBl',
                          labelUp: 'المركز',
                          labelDown: 'العام',
                          maxWidth: MediaQuery.of(context).size.width * 0.4.w,
                          minWidth: MediaQuery.of(context).size.width * 0.2.w,
                          alignment: Alignment.centerRight),
                    ],
                    selectionMode: SelectionMode.single,
                    onSelectionChanged: (List<DataGridRow> addedRows,
                        List<DataGridRow> removedRows) {
                      if (addedRows.isNotEmpty) {
                        /*  Future.delayed(Duration.zero, () {
                          if (mounted) {
                            setState(() {
                              /*    CustomerData selectedRow = convertRowToEntity(dataGridController.selectedRow!);
                                            print(selectedRow.brandNameBL);
                                            print(dataGridController.selectedIndex); */
                            });
                          }
                        }); */
                      }
                    },
                  ),
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
                  fontWeight: FontWeight.bold, color: AppColors.whiteColor),
              itemBorderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 60.h,
            child: SfDataPager(
              itemHeight: 40.h,
              availableRowsPerPage: const [10, 20, 30],
              delegate: widget.dataSource,
              pageCount: (widget.dataSource.customers.length.toDouble() / 30)
                  .ceilToDouble(),
              initialPageIndex: 1,
            ),
          ),
        ),
      ],
    );
  }
}

GridColumn buildGridColumn({
  required String columnName,
  required String labelUp,
  String? labelDown,
  required Alignment alignment,
  required double maxWidth,
  required double minWidth,
}) {
  return GridColumn(
    minimumWidth: minWidth,
    maximumWidth: maxWidth,
    columnWidthMode: ColumnWidthMode.auto,
    columnName: columnName,
    label: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: alignment,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Text(
                  labelUp,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  labelDown ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
