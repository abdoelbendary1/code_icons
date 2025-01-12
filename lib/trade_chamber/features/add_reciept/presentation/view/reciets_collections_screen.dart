import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/trade_chamber/features/add_reciept/presentation/view/widgets/reciet_collections_body.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecietsCollectionsScreen extends StatelessWidget {
  const RecietsCollectionsScreen({super.key});
  static String routeName = "RecietsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(body: const RecietScreenBody(), title: "إضافه دفتر"),
    );
  }
}
