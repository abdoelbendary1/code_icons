import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/Sales_Invoice_body.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/edit_purchases_invoice/presentation/view/EditSales_Invoice_body.dart';
import 'package:code_icons/AUT/features/sales/returns/features/show_all_returns/presentation/view/All_returns.dart';
import 'package:code_icons/AUT/features/sales/returns/features/edit_purchases_returns/presentation/view/EditSales_Return_body.dart';
import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditSalesReturn extends StatefulWidget {
  EditSalesReturn({super.key});
  static String routeName = "EditSalesReturn";

  @override
  State<EditSalesReturn> createState() => _EditSalesReturnState();
}

class _EditSalesReturnState extends State<EditSalesReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
        body: const EditSalesReturnBody(),
        title: "مردود مبيعات",
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) {
              return false;
            },
          );
          Navigator.pushNamed(
            context,
            AllReturnsScreenCards.routeName,
          );
        },
      ),
    );
  }
}
