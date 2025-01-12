import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:code_icons/presentation/auth/login/cubit/login_view_model.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/widgets/custom_card.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );
  List<LoginScreensDM> screens = [];
  @override
  void initState() {
    super.initState();
    /*   homeScreenViewModel.fetchEmployeeData();
    homeScreenViewModel.getCachedEmployeeEntity(); */
    /*  homeScreenViewModel.updateProfile(
        employeeEntity: homeScreenViewModel.employee!); */
    homeScreenViewModel.loadMenu();
    homeScreenViewModel.getScreen();

    fetchAndDisplayScreens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenViewModel, HomeScreenViewModelState>(
        bloc: homeScreenViewModel
          ..fetchEmployeeData()
          ..getCachedEmployeeEntity(),
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return Column(
              children: [
                const Spacer(),
                LoadingStateAnimation(),
                const Spacer(),
              ],
            );
          } else if (state is HomeScreenError) {
            return Center(child: Text(state.message));
          } else if (state is HomeScreenSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 36.0.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "مرحباً ${homeScreenViewModel.employee?.employeeNameBl ?? ""}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor.withOpacity(0.8),
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        const Text(
                          "اختر من القوائم التالية للبدء.",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColors.greyColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //  Layout for Menu Items
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String sectionName = state.menus.keys.elementAt(index);
                      String title = state.menus[sectionName]!.name;
                      IconData icon = state.menus[sectionName]!.icon;
                      /*    List<MenuItem> menuItem = state.menus[sectionName]!.items
                          .where((screen) =>
                              screen.stFormEntity != null &&
                              homeScreenViewModel.screens.any((permission) =>
                                  permission.formId ==
                                  screen.stFormEntity!.formId))
                          .toList(); */
                      List<MenuItem> menuItem =
                          context.read<HomeScreenViewModel>().screens.isNotEmpty
                              ? state.menus[sectionName]!.items
                                  .where((screen) =>
                                      screen.stFormEntity != null &&
                                      homeScreenViewModel.screens.any(
                                          (permission) =>
                                              permission.formId ==
                                              screen.stFormEntity!.formId))
                                  .toList()
                              : state.menus[sectionName]!.items;

                      String routeName = state.menus[sectionName]?.route ?? "";

                      return CustomCard(
                        title: title,
                        menuItem: menuItem,
                        icon: icon,
                        routeName: routeName,
                      );
                    },
                    itemCount: state.menus.length,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
