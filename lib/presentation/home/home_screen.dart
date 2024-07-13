import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_state.dart';
import 'package:code_icons/presentation/home/widgets/custom_drawer_item.dart';
import 'package:code_icons/presentation/home/widgets/home_body.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel();
  MenuCubit menuCubit = MenuCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuCubit>().loadMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Page",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.whiteColor,
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
          child: Drawer(
            child: Container(
                color: AppColors.primaryColor,
                child: ListView(
                  children: [
                    Image.asset(AppAssets.logo),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Text(
                          "Home page",
                          style: Theme.of(context).textTheme.titleMedium,
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
                              final menu = state.menus[menuTitle]!;
                              final icon = menu['icon'] as IconData;
                              final menuItems =
                                  List<MenuItem>.from(menu['items']);
                              return CustomMenuItem(
                                title: menuTitle,
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
        body: HomeBody());
  }
}
