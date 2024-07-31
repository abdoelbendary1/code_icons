import 'package:code_icons/domain/entities/sectionEntity/menuItemEntity.dart';
import 'package:flutter/material.dart';

class MenuItem extends MenuItemEntity {
  MenuItem({
    required super.title,
    required super.route,
    required super.icon,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      title: json['title'],
      route: json['route'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'route': route,
      'icon': icon.codePoint,
    };
  }
}
