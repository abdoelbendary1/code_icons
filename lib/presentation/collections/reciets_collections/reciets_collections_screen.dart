import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/reciets_collections/reciet_collections_body.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecietsCollectionsScreen extends StatelessWidget {
  RecietsCollectionsScreen({super.key});
  static String routeName = "RecietsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(body: RecietScreenBody(), title: "إضافه دفتر"),
    );
  }
}
