import 'package:code_icons/domain/entities/settings/StForm/st_form_entity.dart';
import 'package:flutter/material.dart';

class MenuItemEntity {
  final String title;
  final String route;
  final IconData icon;
  StFormEntity? stFormEntity;

  MenuItemEntity({
    required this.title,
    required this.route,
    required this.icon,
    this.stFormEntity,
  });
}
