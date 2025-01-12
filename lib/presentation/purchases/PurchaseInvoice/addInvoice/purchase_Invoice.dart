import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/trade_chamber/features/add_reciept/presentation/view/widgets/reciet_collections_body.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/addInvoice/purchase_Invoice_body.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PurchaseInvoice extends StatefulWidget {
  PurchaseInvoice({super.key});
  static String routeName = "PurchaseInvoice";

  @override
  State<PurchaseInvoice> createState() => _PurchaseInvoiceState();
}

class _PurchaseInvoiceState extends State<PurchaseInvoice> {
  PurchasesCubit purchasesCubit = PurchasesCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
          body: const PurchaseInvoiceBody(), title: "فاتورة شراء"),
    );
  }
}
