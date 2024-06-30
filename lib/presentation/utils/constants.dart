import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/E-commerce%20Setting_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/SystemSettings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/items_screens/settings_screen.dart';
import 'package:code_icons/presentation/home/side_menu/screens/main_settings/mainSetting.dart';
import 'package:flutter/material.dart';

class AppAssets {
  static const String splashScreen = "assets/images/splash.png";
  static const String logo = "assets/images/logo.png";
  static const String hidePass = "assets/icons/hide.png";
  static const String viewPass = "assets/icons/View.png";
}

class AppLocalData {
  static final menus = {
    "Main settings": {
      'icon': Icons.settings,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Storage": {
      'icon': Icons.storage,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Storage', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Sales": {
      'icon': Icons.point_of_sale,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'sales', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Purchases": {
      'icon': Icons.attach_money,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Contracting": {
      'icon': Icons.contact_page,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Real Estate Investment": {
      'icon': Icons.real_estate_agent_outlined,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Import": {
      'icon': Icons.import_export,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Ship Management": {
      'icon': Icons.local_shipping,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Hospital management": {
      'icon': Icons.local_hospital,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Human Resources": {
      'icon': Icons.how_to_reg_rounded,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Receipts and payments": {
      'icon': Icons.payment,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Finance": {
      'icon': Icons.money,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Collections": {
      'icon': Icons.collections_bookmark_sharp,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
    "Reports": {
      'icon': Icons.request_page_sharp,
      'route': MainSettingScreen.routeName,
      'items': [
        MenuItem(title: 'Settings', route: SettingsScreen.routeName),
        MenuItem(title: 'System Settings', route: SystemSettings.routeName),
        MenuItem(
            title: 'E-commerce Setting', route: EcommerceSetting.routeName),
      ],
    },
  };
}
