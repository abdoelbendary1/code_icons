import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_card_for_one_addition.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSelectedItemsList extends StatelessWidget {
  const BuildSelectedItemsList({super.key, required this.salesInvoiceCubit});
  final SalesInvoiceCubit salesInvoiceCubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "سجل",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor.withOpacity(0.8),
                  fontSize: 25,
                ),
              ),
              const Text(
                "تفاصيل المبيعات",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: AppColors.greyColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
            bloc: salesInvoiceCubit,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is AddPurchasesItemSuccess ||
                  state is FetchCustomersSuccess ||
                  state is GetAllDatSuccess ||
                  state is AddPurchasesItemloading ||
                  state is EditPurchasesItemSuccess ||
                  state is AddPurchasesRequestError ||
                  state is SalesInvoiceLoading ||
                  state is AddSalesCustomerSuccess ||
                  /*  state is GetAllDatSuccess || */
                  state is getItemDataByIDSuccess) {
                if (salesInvoiceCubit.selectedItemsList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          const Text(
                            "لا يوجد فواتير",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: salesInvoiceCubit.selectedItemsList.length,
                    itemBuilder: (context, index) {
                      final request =
                          salesInvoiceCubit.selectedItemsList[index];
                      return Column(
                        children: [
                          BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                            bloc: salesInvoiceCubit,
                            builder: (context, state) {
                              return BuildCardForOneAddition(
                                salesInvoiceCubit: salesInvoiceCubit,
                                request: request,
                                index: index,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "لا يوجد فواتير ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
