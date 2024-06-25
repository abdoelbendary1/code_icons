import 'package:code_icons/presentation/home/widgets/custom_menu.dart';
import 'package:code_icons/presentation/home/widgets/home_body.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String routeName = "HomeScreen";

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
            shape: LinearBorder.none,
            child: Container(
              color: AppColors.primaryColor,
              child: ListView(
                children: [
                  Image.asset(AppAssets.logo),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Home page",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  CustomMenu()
                ],
              ),
            ),
          ),
        ),
        body: const HomeBody());
  }
}
