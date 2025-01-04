import 'package:code_icons/presentation/Sales/returns/addReturn/Sales_Returns_body.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/purchases/returns/addReturn/PR_Returns_body.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrReturn extends StatefulWidget {
  PrReturn({super.key});
  static String routeName = "PrReturn";

  @override
  State<PrReturn> createState() => _PrReturnState();
}

class _PrReturnState extends State<PrReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
          body: const PrReturnBody(), title: "مردود مشتريات"),
    );
  }
}
