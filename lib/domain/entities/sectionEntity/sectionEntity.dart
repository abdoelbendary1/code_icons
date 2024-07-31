import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:flutter/material.dart';

class SectionEntity {
  final String name;
  final IconData icon;
  final String route;
  final List<MenuItem> items;
  

  SectionEntity({
    required this.name,
    required this.icon,
    required this.route,
    required this.items,
   
  });
}
