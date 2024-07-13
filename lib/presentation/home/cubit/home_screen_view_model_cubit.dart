import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_view_model_state.dart';

class HomeScreenViewModel extends Cubit<HomeScreenViewModelState> {
  HomeScreenViewModel() : super(HomeScreenInitial());
  var menus = AppLocalData.menus;

  void loadMenu() {
    try {
      emit(HomeScreenSuccess(menus: menus));
    } catch (e) {
      emit(HomeScreenError( message: "Failed to load menu items"));
    }
  }
}
