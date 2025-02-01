import 'package:code_icons/AUT/features/sales/invoice/view/All_invoices.dart';
import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/All_invoices.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/editInvoice/Edit_PRInvoice_body.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditPRInvoice extends StatefulWidget {
  EditPRInvoice({super.key});
  static String routeName = "EditPRInvoice";

  @override
  State<EditPRInvoice> createState() => _EditPRInvoiceState();
}

class _EditPRInvoiceState extends State<EditPRInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
        body: const EditPRInvoiceBody(),
        title: "فاتورة مشتريات",
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
            AllPrInvoicesScreenCards.routeName,
          );
        },
      ),
    );
  }
}
