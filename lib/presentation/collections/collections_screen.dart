import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/presentation/home/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class CollectionsScreen extends StatelessWidget {
  CollectionsScreen({super.key});

  static const routeName = "CollectionsScreen";

  MenuCubit menuCubit = MenuCubit();

  @override
  Widget build(BuildContext context) {
    var menuItems =
        ModalRoute.of(context)!.settings.arguments as List<MenuItem>;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                String title = menuItems[index].title;
                /* IconData icon = menuCubit.menus[title]!['icon'] as IconData;
                List<MenuItem> menuItem =
                    menuCubit.menus[title]!['items'] as List<MenuItem>; */
                String routeName = menuItems[index].route;

                return CustomCard(
                  title: title,
                  routeName: routeName,
                );
              },
              itemCount: menuItems.length,
            ),
          )
        ],
      ),
    );
  }
}
