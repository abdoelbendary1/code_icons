import 'package:code_icons/presentation/Sales/Invoice/addInvoice/Sales_Invoice_body.dart';
import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SalesInvoice extends StatefulWidget {
  SalesInvoice({super.key});
  static String routeName = "SalesInvoice";

  @override
  State<SalesInvoice> createState() => _SalesInvoiceState();
}

class _SalesInvoiceState extends State<SalesInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
          body: const SalesInvoiceBody(), title: "فاتورة مبيعات"),
    );
  }
}