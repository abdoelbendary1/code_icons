import 'package:code_icons/trade_chamber/features/add_customer/presentation/view/add_customer_Screen.dart';
import 'package:code_icons/trade_chamber/features/add_customer/presentation/view/grid_data_source.dart';
import 'package:code_icons/trade_chamber/features/show_customers/presentation/controller/cubit/customers_cubit.dart';
import 'package:code_icons/trade_chamber/features/show_customers/presentation/view/widgets/customers_data_table.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/di.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:code_icons/core/theme/app_colors.dart';

class CustomerDataScreen extends StatefulWidget {
  const CustomerDataScreen({super.key});

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

  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    customersCubit.fetchCustomers();
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
          buttonSize: const Size(56.0,
              56.0), // it's the SpeedDial size which defaults to 56 itself
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
                        ' إضافة عميل',
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
                    context, AddCustomerScreen.routeName);
              },
            ),
          ],
        ),
        appBar: buildAppBar(context: context, title: "العملاء"),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<CustomersCubit, CustomersState>(
                bloc: customersCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FetchCustomersSuccess) {
                    return CustomersDataTable(
                        dataSource: CustomerDataSource(state.customers));
                  } else if (state is FetchCustomersError) {
                    return Center(child: Text('Error: ${state.errorMsg}'));
                  }
                  return Column(
                    children: [
                      const Spacer(),
                      LoadingStateAnimation(),
                      const Spacer(),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
