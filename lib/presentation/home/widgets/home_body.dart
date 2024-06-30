import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/widgets/custom_card.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  MenuCubit menuCubit = MenuCubit();

  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel();
  @override
  void initState() {
    super.initState();
    homeScreenViewModel.loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenViewModelState>(
      bloc: homeScreenViewModel,
      builder: (context, state) {
        if (state is HomeScreenInitial) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is HomeScreenError) {
          return const Center(child: Text('Error'));
        } else if (state is HomeScreenSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      //! should be enhanced later

                      String title = state.menus.keys.elementAt(index);
                      IconData icon = state.menus[title]!['icon'] as IconData;
                      List<MenuItem> menuItem =
                          state.menus[title]!['items'] as List<MenuItem>;
                      String routeName = state.menus[title]!['route'] as String;
                      //!

                      return CustomCard(
                        title: title,
                        menuItem: menuItem,
                        icon: icon,
                        menuItemIndex: index,
                        routeName: routeName,
                      );
                    },
                    itemCount: state.menus.length,
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
