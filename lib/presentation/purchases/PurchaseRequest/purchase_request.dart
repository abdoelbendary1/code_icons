import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/trade_chamber/features/add_reciept/presentation/view/widgets/reciet_collections_body.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/purchase_request_body.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PurchaseRequest extends StatefulWidget {
  PurchaseRequest({super.key});
  static String routeName = "PurchaseRequest";

  @override
  State<PurchaseRequest> createState() => _PurchaseRequestState();
}

class _PurchaseRequestState extends State<PurchaseRequest> {
  PurchasesCubit purchasesCubit = PurchasesCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*   key: purchasesCubit.scaffoldKey, */
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
          body: const PurchaseRequestBody(), title: "طلب شراء"),
    );
  }
}
