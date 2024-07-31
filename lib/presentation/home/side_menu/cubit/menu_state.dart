import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoaded extends MenuState {
 Map<String, SectionEntity> menus;

  MenuLoaded(this.menus);
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);
}
