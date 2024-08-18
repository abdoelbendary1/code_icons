import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/reciets_collections/reciet_collections_body.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/purchase_Invoice_body.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
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
