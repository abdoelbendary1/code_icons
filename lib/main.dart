import 'package:code_icons/core/adapters/auth_entity.dart';
import 'package:code_icons/core/adapters/customers.dart';
import 'package:code_icons/core/adapters/loginRequest.dart';
import 'package:code_icons/core/adapters/settings.dart';
import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/HR/employee/employee_entity.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/settings/settings_entity.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/All_Attendances_by_day_screen.dart';
import 'package:code_icons/presentation/HR/HR_Screen.dart';
import 'package:code_icons/presentation/HR/LoanRequest/LoanRequestScreen.dart';
import 'package:code_icons/presentation/HR/LoanRequest/cubit/Loan_order_cubit.dart';
import 'package:code_icons/presentation/HR/VacationRequest/VacationOrderScreen.dart';
import 'package:code_icons/presentation/HR/VacationRequest/cubit/vaction_order_cubit.dart';
import 'package:code_icons/presentation/HR/absenceRequest/absenceScreen.dart';
import 'package:code_icons/presentation/HR/absenceRequest/cubit/absenceCubit.dart';
import 'package:code_icons/presentation/HR/attendance/attendanceScreen.dart';
import 'package:code_icons/presentation/HR/attendance/cubit/attendace_cubit.dart';
import 'package:code_icons/presentation/HR/permissionRequest/permissionRequestScreen.dart';
import 'package:code_icons/presentation/collections/AllTradeProve/all_trade_prove.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/add_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/all_daily_collector_screen.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/cubit/all_daily_collector_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/unRegistered_collections.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/add_customer_Screen.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/customer_data_screen.dart';
import 'package:code_icons/presentation/collections/collections_screen.dart';
import 'package:code_icons/presentation/collections/reciets_collections/all_reciets.dart';
import 'package:code_icons/presentation/collections/reciets_collections/reciets_collections_screen.dart';
import 'package:code_icons/presentation/home/cubit/BottomNavCubit.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/E-commerce%20Setting_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/SystemSettings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/settings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/mainSetting.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/purchase_Invoice.dart';
import 'package:code_icons/presentation/purchases/PurchaseOrder/purchase_order.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/purchase_request.dart';
import 'package:code_icons/presentation/purchases/PurchaseScreen.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/getAllPurchases/view/all_purchases.dart';
import 'package:code_icons/presentation/utils/GlobalVariables.dart';
import 'package:code_icons/presentation/utils/shared_prefrence.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/services/my_observer.dart';
import 'package:code_icons/presentation/auth/login/login_screen.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/utils/theme/app_theme.dart';
import 'package:code_icons/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:code_icons/core/adapters/EmployeeEntityAdapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* //auto login
  await SharedPrefrence.init();
  var token = SharedPrefrence.getData(key: "accessToken");
  late String route;
  if (token == null) {
    route = LoginScreen.routeName;
  } else {
    route = HomeScreen.routeName;
  } */
  await Hive.initFlutter();
/*     Hive.registerAdapter(RecietCollectionDataModelAdapter());
 */
  Hive.registerAdapter(AuthResponseDMAdapter()); // Register the adapter
  Hive.registerAdapter(CustomerDataEntityAdapter());
  Hive.registerAdapter(SettingsEntityAdapter());
  Hive.registerAdapter(EmployeeEntityAdapter());
  Hive.registerAdapter(LoginRequestAdapter());

  await Hive.openBox('userBox');
  await Hive.openBox('receiptsBox');
  await Hive.openBox<LoginRequest>('login_requests');

  setupLocator();
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(
          /*  route: route, */
          ), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    /* required this.route */
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late String route;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove the observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      _clearCache(); // Clear the cache when the app is being closed
      clearEmployeeBox();
    } else if (state == AppLifecycleState.detached) {}
  }

  Future<void> _clearCache() async {
    var box = await Hive.openBox<CustomerDataEntity>('customersBox');
    var settingBox = await Hive.openBox<SettingsEntity>('settingsBox');
    var employeeBox = await Hive.openBox<EmployeeEntity>('employeeBox');
    var loginBox = await Hive.openBox<LoginRequest>('login_requests');

    await employeeBox.clear();
    await box.clear();
    /* await loginBox.clear(); */

    await settingBox.clear(); // Clear all the data in the box
  }

  Future<void> clearEmployeeBox() async {
    var employeeBox = await Hive.openBox<EmployeeEntity>('employeeBox');

    await employeeBox.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(const StackOverflowError().stackTrace.toString());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MenuCubit>(),
        ),
        BlocProvider(
          create: (context) => AllDailyCollectorCubit(
            fetchTradeCollectionDataUseCase:
                injectFetchTradeCollectionDataUseCase(),
            fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
          ),
        ),
        BlocProvider(
          create: (context) => HomeScreenViewModel(
            fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
          ),
        ),
        BlocProvider(
          create: (context) => UnlimitedCollectionCubit(
            getUnRegisteredTradeCollectionUseCase:
                injectGetUnRegisteredTradeCollectionUseCase(),
            postUnRegisteredTradeCollectionUseCase:
                injectPostUnRegisteredTradeCollectionUseCase(),
            authManager: injectAuthManagerInterface(),
          ),
        ),
        BlocProvider(
          create: (context) => CustomersCubit(
            postCustomerDataUseCase: injectPostCustomerDataUseCase(),
            fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
            fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
            fetchCurrencyByIDUseCase: injectFetchCurrencyDataByIDUseCase(),
            fetchCurrencyUseCase: iinjectFetchCurrencyUseCase(),
            fetchActivityUseCase: injectFetchActivityListUseCase(),
            fetchGeneralCentralUseCase: injectFetchGeneralCentralListUseCase(),
            fetchTradeOfficeUseCase: injectFetchTradeOfficeListUseCase(),
            fetchStationListUseCase: injectFetchStationListUseCase(),
          ),
        ),
        BlocProvider(
          create: (context) => AddCollectionCubit(
              fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
              fetchCustomerDataByIDUseCase:
                  injectFetchCustomerByIdDataUseCase(),
              fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
              postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
              paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase()),
        ),
        BlocProvider(create: (context) => PurchasesCubit()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => VactionOrderCubit()),
        BlocProvider(create: (context) => LoanRequestCubit()),
        BlocProvider(create: (context) => AbsenceRequestCubit()),
        BlocProvider(
          create: (context) => AttendaceCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          navigatorKey: GlobalVariable.navigatorState,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          /* useInheritedMediaQuery: true, */
          locale: const Locale("ar"),
          builder: DevicePreview.appBuilder,
          theme: AppTheme.mainTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
            SystemSettings.routeName: (context) => const SystemSettings(),
            EcommerceSetting.routeName: (context) => const EcommerceSetting(),
            MainSettingScreen.routeName: (context) => MainSettingScreen(),
            HRScreen.routeName: (context) => HRScreen(),
            LoanRequestScreen.routeName: (context) => LoanRequestScreen(),
            AbsenceRequestScreen.routeName: (context) => AbsenceRequestScreen(),
            AttendanceScreen.routeName: (context) => AttendanceScreen(),
            PermissionRequestScreen.routeName: (context) =>
                PermissionRequestScreen(),
            AllAttendancesScreen.routeName: (context) =>
                const AllAttendancesScreen(),
            VacationOrderScreen.routeName: (context) => VacationOrderScreen(),
            UnlimitedCollection.routeName: (context) => UnlimitedCollection(
                  data: TradeCollectionEntity(),
                ),
            CustomerDataScreen.routeName: (context) => CustomerDataScreen(),
            CollectionsScreen.routeName: (context) => CollectionsScreen(),
            AllTradeProveScreen.routeName: (context) =>
                const AllTradeProveScreen(),
            AllDailyCollectorScreen.routeName: (context) =>
                AllDailyCollectorScreen(),
            PurchaseScreen.routeName: (context) => PurchaseScreen(),
            AllPurchasesScreen.routeName: (context) => AllPurchasesScreen(),
            PurchaseRequest.routeName: (context) => PurchaseRequest(),
            PurchaseOrder.routeName: (context) => PurchaseOrder(),
            PurchaseInvoice.routeName: (context) => PurchaseInvoice(),
            RecietsCollectionsScreen.routeName: (context) =>
                RecietsCollectionsScreen(),
            AllRecietsScreen.routeName: (context) => AllRecietsScreen(),
            UnRegisteredCollectionsScreen.routeName: (context) =>
                UnRegisteredCollectionsScreen(),
            AddCustomerScreen.routeName: (context) => const AddCustomerScreen(),
            AddCollectionView.routeName: (context) => AddCollectionView(
                  data: TradeCollectionEntity(),
                ),
          },
        ),
      ),
    );
  }
}
