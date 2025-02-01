import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAddProduct extends StatelessWidget {
  BuildAddProduct(
      {super.key, required this.salesInvoiceCubit, required this.saveButton});
  final SalesInvoiceCubit salesInvoiceCubit;
  Widget saveButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60.h,
        ),
        saveButton,
        SizedBox(
          height: 60.h,
        ),
      ],
    );
  }
}
