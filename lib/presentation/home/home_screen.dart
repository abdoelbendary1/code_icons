import 'package:code_icons/data/model/data_model/menu_item.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuCubit>().loadMenu();
    });
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
                          children: state.menus.keys.map((menuTitle) {
                            final title = state.menus[menuTitle]!.name;
                            final section = state.menus[menuTitle]!;
                            final icon = section.icon;
                            final menuItems =
                                List<MenuItem>.from(section.items);
                            return CustomMenuItem(
                              title: title,
                              icon: icon,
                              menuItems: menuItems,
                            );
                          }).toList(),
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
    /*   bottomNavigationBar: SizedBox(
        height: 110.h,
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
                ),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'الاشعارات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
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
     */);
  }
}
