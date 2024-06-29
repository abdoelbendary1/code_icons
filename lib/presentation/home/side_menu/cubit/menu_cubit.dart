import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_state.dart';
import 'package:code_icons/presentation/home/side_menu/screens/E-commerce%20Setting_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/SystemSettings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  final menus = {
    "Main settings": {
      'icon': Icons.settings,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Storage": {
      'icon': Icons.storage,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Sales": {
      'icon': Icons.point_of_sale,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Purchases": {
      'icon': Icons.attach_money,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Contracting": {
      'icon': Icons.contact_page,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Real Estate Investment": {
      'icon': Icons.real_estate_agent_outlined,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Import": {
      'icon': Icons.import_export,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Ship Management": {
      'icon': Icons.local_shipping,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Hospital management": {
      'icon': Icons.local_hospital,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Human Resources": {
      'icon': Icons.how_to_reg_rounded,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Receipts and payments": {
      'icon': Icons.payment,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Finance": {
      'icon': Icons.money,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Collections": {
      'icon': Icons.collections_bookmark_sharp,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Reports": {
      'icon': Icons.request_page_sharp,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    
  };
  void loadMenu() {
    try {
      emit(MenuLoaded(menus));
    } catch (e) {
      emit(MenuError("Failed to load menu items"));
    }
  }
}
