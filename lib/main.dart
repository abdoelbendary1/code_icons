import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/E-commerce%20Setting_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/SystemSettings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/settings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/mainSetting.dart';
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

void main() {
  setupLocator();
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
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
          },
        ),
      ),
    );
  }
}
