import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_state.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/E-commerce%20Setting_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/SystemSettings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/settings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/mainSetting.dart';
import 'package:code_icons/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  Map<String, SectionEntity> menus = AppLocalData.menus;
  final updatedSections = HomeScreenViewModel.updatedSectionsMap;

  void loadMenu() {
    try {
      emit(MenuLoaded(updatedSections));
    } catch (e) {
      emit(MenuError("Failed to load menu items"));
    }
  }
}
