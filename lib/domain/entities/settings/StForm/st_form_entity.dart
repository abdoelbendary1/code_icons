import 'package:flutter/material.dart';

class StFormEntity {
  int? id;
  int? formId;
  String? formName;
  String? modules;

  String? route;
  IconData? icon;

  StFormEntity(
      {this.id,
      this.formId,
      this.formName,
      this.modules,
      this.icon,
      this.route});
}
