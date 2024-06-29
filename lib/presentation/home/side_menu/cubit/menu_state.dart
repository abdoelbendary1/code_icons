import 'package:code_icons/data/model/data_model/menu_item.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoaded extends MenuState {
  Map<String, Map<String, dynamic>> menus;

  MenuLoaded(this.menus);
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);
}
