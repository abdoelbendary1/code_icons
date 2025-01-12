import 'package:code_icons/presentation/Sales/Invoice/All_invoices.dart';
import 'package:code_icons/presentation/Sales/Invoice/addInvoice/Sales_Invoice_body.dart';
import 'package:code_icons/presentation/Sales/Invoice/editInvoice/EditSales_Invoice_body.dart';
import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditSalesInvoice extends StatefulWidget {
  EditSalesInvoice({super.key});
  static String routeName = "EditSalesInvoice";

  @override
  State<EditSalesInvoice> createState() => _EditSalesInvoiceState();
}

class _EditSalesInvoiceState extends State<EditSalesInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
        body: const EditSalesInvoiceBody(),
        title: "فاتورة مبيعات",
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
            AllInvoicesScreenCards.routeName,
          );
        },
      ),
    );
  }
}