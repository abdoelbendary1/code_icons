import 'package:code_icons/presentation/Sales/returns/addReturn/Sales_Returns_body.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SalesReturn extends StatefulWidget {
  SalesReturn({super.key});
  static String routeName = "SalesReturn";

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
          body: const SalesReturnBody(), title: "مردود مبيعات"),
    );
  }
}
