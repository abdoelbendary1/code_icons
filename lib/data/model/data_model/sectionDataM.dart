import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:flutter/material.dart';

class SectionDataModel extends SectionEntity {
  SectionDataModel({
    required super.name,
    required super.icon,
    required super.route,
    required super.items,
  });

  factory SectionDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<MenuItem> itemsList = list.map((i) => MenuItem.fromJson(i)).toList();

    return SectionDataModel(
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      route: json['route'],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'route': route,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
