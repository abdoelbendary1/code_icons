import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsBody extends StatefulWidget {
  NotificationsBody({super.key});

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
);

  /*  @override
  void initState() {
    super.initState();
    homeScreenViewModel.loadMenu();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenViewModel, HomeScreenViewModelState>(
        bloc: homeScreenViewModel,
        builder: (context, state) {
          return const Center(
            child: Text('This is the notifications screen'),
          );
        },
      ),
    );
  }
}
