import 'package:code_icons/presentation/collections/CustomerData/add_customer/grid_data_source.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightBlueColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(0),
              ),
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  gridLineColor: AppColors.lightBlueColor,
                  filterPopupDisabledTextStyle:
                      const TextStyle(color: AppColors.blackColor),
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
                  columnDragIndicatorColor: AppColors.whiteColor,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    /*  gradient: LinearGradient(
                      colors: [AppColors.blueColor, AppColors.lightBlueColor],
                      begin: Alignment.topLeft,
                      end: Alignment.centerLeft,
                    ), */
                  ),
                  child: SfDataGrid(
                    isScrollbarAlwaysShown: false,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    /*   showCheckboxColumn: true,
                      showSortNumbers: true, */
                    rowHeight: 100.h,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    headerRowHeight: 100.h,
                    rowsPerPage: 15,
                    controller: dataGridController,
                    source: widget.dataSource,
                    allowSorting: true,
                    allowFiltering: true,
                    frozenColumnsCount: 1, // Freezing the first column
                    columns: [
                      /*  buildGridColumn(
                                        maxWidth: 100.w,
                                        'idBL',
                                        'ID',
                                        Alignment.centerRight), */
                      buildGridColumn(
                          columnName: 'brandNameBL',
                          labelUp: 'الإسم',
                          maxWidth: MediaQuery.of(context).size.width * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'nationalIdBL',
                          labelUp: "الرقم القومي",
                          labelDown: "",
                          maxWidth: MediaQuery.of(context).size.width * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'birthDayBL',
                          labelUp: 'تاريخ الميلاد',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'tradeRegistryBL',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          labelUp: 'السجل التجاري',
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'licenseDateBL',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          labelUp: 'تاريخ الترخيص',
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'licenseYearBL',
                          labelUp: 'سنة الترخيص',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'capitalBL',
                          labelUp: 'رأس المال',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          columnName: 'validBL',
                          labelUp: 'صالح',
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'companyTypeNameBL',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          labelUp: 'نوع الشركة',
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'tradeOfficeNameBL',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          labelUp: 'مكتب التجارة',
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'activityNameBL',
                          labelUp: 'النشاط',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'divisionBL',
                          labelUp: 'القسم',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'tradeTypeBL',
                          labelUp: 'نوع التجارة',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          columnName: 'ownerBL',
                          labelUp: 'المالك',
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'addressBL',
                          labelUp: 'العنوان',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          columnName: 'stationNameBL',
                          labelUp: 'المحطة',
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          alignment: Alignment.centerRight),
                      buildGridColumn(
                          maxWidth: MediaQuery.of(context).size.width.w * 0.5.w,
                          columnName: 'phoneBL',
                          labelUp: 'الهاتف',
                          alignment: Alignment.centerRight),
                    ],
                    selectionMode: SelectionMode.single,
                    onSelectionChanged: (List<DataGridRow> addedRows,
                        List<DataGridRow> removedRows) {
                      if (addedRows.isNotEmpty) {
                        Future.delayed(Duration.zero, () {
                          if (mounted) {
                            setState(() {
                              /*    CustomerData selectedRow = convertRowToEntity(dataGridController.selectedRow!);
                                            print(selectedRow.brandNameBL);
                                            print(dataGridController.selectedIndex); */
                            });
                          }
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        SfDataPager(
          availableRowsPerPage: [10, 20, 30],
          delegate: widget.dataSource,
          pageCount: 7,
          initialPageIndex: 1,
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
}) {
  return GridColumn(
    maximumWidth: maxWidth,
    columnWidthMode: ColumnWidthMode.auto,
    columnName: columnName,
    label: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: alignment,
      child: Wrap(
        children: [
          Column(
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
              /*   Text(
                labelDown ?? "",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ), */
            ],
          ),
        ],
      ),
    ),
  );
}
