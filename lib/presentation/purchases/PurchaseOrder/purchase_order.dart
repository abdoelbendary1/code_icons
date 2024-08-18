import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/reciets_collections/reciet_collections_body.dart';
import 'package:code_icons/presentation/purchases/PurchaseOrder/purchase_order_body.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PurchaseOrder extends StatefulWidget {
  PurchaseOrder({super.key});
  static String routeName = "PurchaseOrder";

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  PurchasesCubit purchasesCubit = PurchasesCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*   key: purchasesCubit.scaffoldKey, */
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
          body: const PurchaseOrderBody(), title: "أمر شراء"),
    );
  }
}
