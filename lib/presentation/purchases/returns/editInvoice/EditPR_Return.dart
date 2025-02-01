import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/Sales_Invoice_body.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/edit_purchases_invoice/presentation/view/EditSales_Invoice_body.dart';
import 'package:code_icons/AUT/features/sales/returns/features/show_all_returns/presentation/view/All_returns.dart';
import 'package:code_icons/AUT/features/sales/returns/features/edit_purchases_returns/presentation/view/EditSales_Return_body.dart';
import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/purchases/returns/All_pr_returns.dart';
import 'package:code_icons/presentation/purchases/returns/editInvoice/EditPR_Return_body.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditPrReturn extends StatefulWidget {
  EditPrReturn({super.key});
  static String routeName = "EditPrReturn";

  @override
  State<EditPrReturn> createState() => _EditPrReturnState();
}

class _EditPrReturnState extends State<EditPrReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
        body: const EditPrReturnBody(),
        title: "مردود مشتريات",
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
            AllPrReturnsScreenCards.routeName,
          );
        },
      ),
    );
  }
}
