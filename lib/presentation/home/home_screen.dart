import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/HR/employee/employee_entity.dart';
import 'package:code_icons/domain/entities/settings/settings_entity.dart';
import 'package:code_icons/presentation/auth/login/login_screen.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/profile/ProfileScreen.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_state.dart';
import 'package:code_icons/presentation/home/widgets/custom_drawer_item.dart';
import 'package:code_icons/presentation/home/widgets/home_body.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );
  MenuCubit menuCubit = MenuCubit();
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<MenuCubit>().loadMenu();
    /*  WidgetsBinding.instance.addPostFrameCallback((_) {
    }); */
    homeScreenViewModel.getScreen();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      /*  if (index == 0) {
        // Open Drawer
        _openDrawer();
        _scaffoldKey.currentState?.openDrawer();
      }  */ /* else if (index == 3) {
        // Open Home Screen
        Navigator.pushNamed(context, HomeScreen.routeName);
      } */
      // Handle other icons like notifications, profile, etc.
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: buildAppBar(context: context, title: "الرئيسية"),
      backgroundColor: AppColors.whiteColor,
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
        child: Drawer(
          child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.blueColor, AppColors.lightBlueColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView(
                children: [
                  Image.asset(AppAssets.logo),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        "الرئيسيه",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  BlocBuilder<MenuCubit, MenuState>(
                    builder: (context, state) {
                      if (state is MenuInitial) {
                        return const ListTile(
                          title: Text('Loading...'),
                        );
                      } else if (state is MenuError) {
                        return ListTile(
                          title: Text('Error: ${state.message}'),
                        );
                      } else if (state is MenuLoaded) {
                        print('MenuLoaded state received in UI');
                        return Column(
                          children: [
                            Column(
                              children: state.menus.keys.map((menuTitle) {
                                final title = state.menus[menuTitle]!.name;
                                final section = state.menus[menuTitle]!;
                                final icon = section.icon;
                                final menuItems = context
                                        .read<HomeScreenViewModel>()
                                        .screens
                                        .isNotEmpty
                                    ? section.items
                                        .where((screen) => context
                                            .read<HomeScreenViewModel>()
                                            .screens
                                            .any((permission) =>
                                                permission.formId ==
                                                screen.stFormEntity?.formId))
                                        .toList()
                                    : section.items;
                                /*  final menuItems = section.items
                                    .where((screen) => homeScreenViewModel
                                        .screens
                                        .any((permission) =>
                                            permission.formId ==
                                            screen.stFormEntity?.formId))
                                    .toList(); */

                                return CustomMenuItem(
                                  title: title,
                                  icon: icon,
                                  menuItems: menuItems,
                                );
                              }).toList(),
                            ),
                            TextButton(
                              onPressed: () {
                                clearCache(); // Clear the cache when the app is being closed
                                clearEmployeeBox();
                                clearScreens();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    LoginScreen.routeName, (route) => false);
                              },
                              child: Text(
                                "تسجيل خروج",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              )),
        ),
      ),
      body: Builder(
        builder: (context) {
          switch (_selectedIndex) {
            /*   case 0:
              return Center(child: Text('Menu Screen')); */
            case 0:
              return HomeBody();
            case 1:
              return Center(child: Text('Notifications Screen'));
            case 2:
              return Center(child: ProfileBody());
            default:
              return HomeBody();
          }
        },
      ),
      /*  bottomNavigationBar: SizedBox(
        height: 120.h,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: AppColors.whiteColor,
            /* backgroundColor: AppColors.lightBlueColor, */
            items: const <BottomNavigationBarItem>[
              /*   BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'القائمه',
              ), */
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 15,
                ),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  size: 15,
                ),
                label: 'الاشعارات',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 15,
                ),
                label: 'الموظف',
              ),
              /*  BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ), */
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
     */
    );
  }

  Future<void> clearCache() async {
    var box = await Hive.openBox<CustomerDataEntity>('customersBox');
    var settingBox = await Hive.openBox<SettingsEntity>('settingsBox');
    var employeeBox = await Hive.openBox<EmployeeEntity>('employeeBox');
    var loginBox = await Hive.openBox<LoginRequest>('login_requests');
    var screens = await Hive.openBox<LoginScreensDM>('loginScreensBox');

    await employeeBox.clear();
    await box.clear();
    await screens.clear();

    /* await loginBox.clear(); */

    await settingBox.clear(); // Clear all the data in the box
  }

  Future<void> clearEmployeeBox() async {
    var employeeBox = await Hive.openBox<EmployeeEntity>('employeeBox');

    await employeeBox.clear();
  }

  Future<void> clearScreens() async {
    var screens = await Hive.openBox<LoginScreensDM>('loginScreensBox');

    await screens.clear();

    // Clear all the data in the box
  }
}
