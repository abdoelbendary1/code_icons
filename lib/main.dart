import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
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
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/E-commerce%20Setting_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/SystemSettings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/settings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/mainSetting.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/purchase_request.dart';
import 'package:code_icons/presentation/purchases/PurchaseScreen.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/getAllPurchases/view/all_purchases.dart';
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
  await Hive.openBox('userBox');
  await Hive.openBox('receiptsBox');
  setupLocator();
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(
          /*  route: route, */
          ), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    /* required this.route */
  });
  late String route;

  @override
  Widget build(BuildContext context) {
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
          create: (context) => UnlimitedCollectionCubit(
            getUnRegisteredTradeCollectionUseCase:
                injectGetUnRegisteredTradeCollectionUseCase(),
            postUnRegisteredTradeCollectionUseCase:
                injectPostUnRegisteredTradeCollectionUseCase(),
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
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          useInheritedMediaQuery: true,
          locale: const Locale("ar"),
          builder: DevicePreview.appBuilder,
          theme: AppTheme.mainTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
            SystemSettings.routeName: (context) => SystemSettings(),
            EcommerceSetting.routeName: (context) => EcommerceSetting(),
            MainSettingScreen.routeName: (context) => MainSettingScreen(),
            CollectionsScreen.routeName: (context) => CollectionsScreen(),
            UnlimitedCollection.routeName: (context) => UnlimitedCollection(
                  data: TradeCollectionEntity(),
                ),
            CustomerDataScreen.routeName: (context) => CustomerDataScreen(),
            AllTradeProveScreen.routeName: (context) => AllTradeProveScreen(),
            AllDailyCollectorScreen.routeName: (context) =>
                AllDailyCollectorScreen(),
            PurchaseScreen.routeName: (context) => PurchaseScreen(),
            AllPurchasesScreen.routeName: (context) => AllPurchasesScreen(),
            PurchaseRequest.routeName: (context) => PurchaseRequest(),
            RecietsCollectionsScreen.routeName: (context) =>
                RecietsCollectionsScreen(),
            AllRecietsScreen.routeName: (context) => AllRecietsScreen(),
            UnRegisteredCollectionsScreen.routeName: (context) =>
                UnRegisteredCollectionsScreen(),
            AddCustomerScreen.routeName: (context) => AddCustomerScreen(),
            AddCollectionView.routeName: (context) => AddCollectionView(
                  data: TradeCollectionEntity(),
                ),
          },
        ),
      ),
    );
  }
}
