import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/form.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/add_custom_form.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});
  static final String routeName = "AddCustomerScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: CustomSliverAppBar(
          title: "إضافه عميل",
          body: AddCustomerCardsForm(),
        ),
      ),
    );
  }
}
