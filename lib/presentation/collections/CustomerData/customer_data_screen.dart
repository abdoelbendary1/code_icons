import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/add_customer_Screen.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/grid_data_source.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/services/di.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';

class CustomerDataScreen extends StatefulWidget {
  CustomerDataScreen({super.key});

  static const routeName = "CustomerDataScreen";

  @override
  State<CustomerDataScreen> createState() => _CustomerDataScreenState();
}

class _CustomerDataScreenState extends State<CustomerDataScreen> {
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

  late CustomerDataSource _dataSource;
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    customersCubit.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        centerTitle: false,
        backgroundColor: AppColors.blueColor,
        title: Text(
          'قائمة العملاء',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, AddCustomerScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<CustomersCubit, CustomersState>(
            bloc: customersCubit,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchCustomersSuccess) {
                _dataSource = CustomerDataSource(state.customers);
                /*  print(state.customers.first.brandNameBl); */

                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(0),
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
                              gridLinesVisibility: GridLinesVisibility.vertical,
                              headerRowHeight: 80.h,
                              rowsPerPage: 15,
                              controller: dataGridController,
                              source: _dataSource,
                              allowSorting: true,
                              allowFiltering: true,
                              frozenColumnsCount:
                                  1, // Freezing the first column
                              columns: [
                                /*  buildGridColumn(
                                    maxWidth: 100.w,
                                    'idBL',
                                    'ID',
                                    Alignment.centerRight), */
                                buildGridColumn(
                                    columnName: 'brandNameBL',
                                    labelUp: 'الإسم',
                                    maxWidth: 130.w,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'nationalIdBL',
                                    labelUp: "الرقم",
                                    labelDown: "القومي",
                                    maxWidth: 180.w,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'birthDayBL',
                                    labelUp: 'تاريخ الميلاد',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'tradeRegistryBL',
                                    maxWidth: 100,
                                    labelUp: 'السجل التجاري',
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'licenseDateBL',
                                    maxWidth: 100,
                                    labelUp: 'تاريخ الترخيص',
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'licenseYearBL',
                                    labelUp: 'سنة الترخيص',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'capitalBL',
                                    labelUp: 'رأس المال',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    maxWidth: 100,
                                    columnName: 'validBL',
                                    labelUp: 'صالح',
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'companyTypeNameBL',
                                    maxWidth: 100,
                                    labelUp: 'نوع الشركة',
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'tradeOfficeNameBL',
                                    maxWidth: 100,
                                    labelUp: 'مكتب التجارة',
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'activityNameBL',
                                    labelUp: 'النشاط',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'divisionBL',
                                    labelUp: 'القسم',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'tradeTypeBL',
                                    labelUp: 'نوع التجارة',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    maxWidth: 100,
                                    columnName: 'ownerBL',
                                    labelUp: 'المالك',
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'addressBL',
                                    labelUp: 'العنوان',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    columnName: 'stationNameBL',
                                    labelUp: 'المحطة',
                                    maxWidth: 100,
                                    alignment: Alignment.centerRight),
                                buildGridColumn(
                                    maxWidth: 100,
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
                      SfDataPager(
                        availableRowsPerPage: [10, 20, 30],
                        delegate: _dataSource,
                        pageCount: 7,
                        initialPageIndex: 1,
                      ),
                    ],
                  ),
                );
              } else if (state is FetchCustomersError) {
                return Center(child: Text('Error: ${state.errorMsg}'));
              }
              return Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: AppColors.blueColor,
                  rightDotColor: AppColors.lightBlueColor,
                  size: 60,
                ),
              );
            },
          ),
        ],
      ),
    );
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
          ],
        ),
      ),
    );
  }

  /* CustomerData convertRowToEntity(DataGridRow? row) {
    final cells = row!.getCells();
    return CustomerData(
      idBL: cells[0].value,
      brandNameBL: cells[1].value,
      nationalIdBL: cells[2].value,
      birthDayBL: cells[3].value,
      tradeRegistryBL: cells[4].value,
      licenseDateBL: cells[5].value,
      licenseYearBL: cells[6].value,
      capitalBL: cells[7].value,
      validBL: cells[8].value,
      companyTypeBL: cells[9].value,
      companyTypeNameBL: cells[10].value,
      currencyIdBL: cells[11].value,
      tradeOfficeBL: cells[12].value,
      tradeOfficeNameBL: cells[13].value,
      activityBL: cells[14].value,
      activityNameBL: cells[15].value,
      expiredBL: cells[16].value,
      divisionBL: cells[17].value,
      tradeTypeBL: cells[18].value,
      ownerBL: cells[19].value,
      addressBL: cells[20].value,
      stationBL: cells[21].value,
      stationNameBL: cells[22].value,
      phoneBL: cells[23].value,
      numExpiredBL: cells[24].value,
      tradeRegistryTypeBL: cells[25].value,
      customerDataIdBL: cells[26].value,
    );
  } */
}
