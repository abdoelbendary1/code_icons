import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/add_customer_Screen.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/grid_data_source.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/customers_data_table.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/di.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
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
  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  @override
  void initState() {
    super.initState();
    customersCubit.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.whiteColor),
            toolbarHeight: 120.h,
            centerTitle: true,
            backgroundColor: AppColors.blueColor,
            title: Text(
              'قائمة العملاء',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.whiteColor),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddCustomerScreen.routeName);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<CustomersCubit, CustomersState>(
                  bloc: customersCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is FetchCustomersSuccess) {
                      return HawkFabMenu(
                        icon: AnimatedIcons.menu_arrow,
                        fabColor: Colors.yellow,
                        iconColor: Colors.green,
                        hawkFabMenuController: hawkFabMenuController,
                        items: [
                          HawkFabMenuItem(
                            label: 'Menu 1',
                            ontap: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Menu 1 selected')),
                              );
                            },
                            icon: const Icon(Icons.home),
                            color: Colors.red,
                            labelColor: Colors.blue,
                          ),
                          HawkFabMenuItem(
                            label: 'Menu 2',
                            ontap: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Menu 2 selected')),
                              );
                            },
                            icon: const Icon(Icons.comment),
                            labelColor: Colors.white,
                            labelBackgroundColor: Colors.blue,
                          ),
                          HawkFabMenuItem(
                            label: 'Menu 3 (default)',
                            ontap: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Menu 3 selected')),
                              );
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ],
                        body: CustomersDataTable(
                            dataSource: CustomerDataSource(state.customers)),
                      );

                      /*  print(state.customers.first.brandNameBl); */
                    } else if (state is FetchCustomersError) {
                      return Center(child: Text('Error: ${state.errorMsg}'));
                    }
                    return const Column(
                      children: [
                        Spacer(),
                        LoadingStateAnimation(),
                        Spacer(),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
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
