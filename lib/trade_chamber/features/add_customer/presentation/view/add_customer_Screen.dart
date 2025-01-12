import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/trade_chamber/features/add_customer/presentation/view/form.dart';
import 'package:code_icons/trade_chamber/features/add_customer/presentation/view/widgets/add_custom_form.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});
  static const String routeName = "AddCustomerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
        title: "إضافه عميل",
        body: const AddCustomerCardsForm(),
      ),
    );
  }
}
