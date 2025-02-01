import 'package:code_icons/AUT/core/widgets/build_details_data_row.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class BuildCardForOneAddition extends StatelessWidget {
  const BuildCardForOneAddition({
    super.key,
    required this.salesInvoiceCubit,
    required this.request,
    required this.index,
  });
  final SalesInvoiceCubit salesInvoiceCubit;
  final InvoiceItemDetailsDm request;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
      bloc: salesInvoiceCubit,
      builder: (context, state) {
        return ExpansionTile(
          iconColor: AppColors.lightBlueColor,
          collapsedIconColor: AppColors.lightBlueColor,
          maintainState: true,
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              // Wrap the first Text widget with Flexible to handle overflow              Spacer(),

              Flexible(
                flex: 3,
                child: Wrap(
                  children: [
                    Text(
                      salesInvoiceCubit.itemsList
                          .firstWhere(
                              (element) => element.itemId == request.itemNameAr)
                          .itemNameAr
                          .toString(),
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),

              // "الكمية" text

              // Wrap qty Text widget with Flexible or Expanded to manage overflow
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      " الكمية  : ",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      request.qty!.toInt().toString(),
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Handles overflow with ellipsis
                      maxLines: 1, // Restrict to one line if needed
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            SwipeActionCell(
              controller: salesInvoiceCubit.swipeActionController,
              firstActionWillCoverAllSpaceOnDeleting: false,
              closeWhenScrolling: true,
              editModeOffset: 2,
              fullSwipeFactor: 5,
              leadingActions: [
                SwipeAction(
                  closeOnTap: true,
                  performsFirstActionWithFullSwipe: true,
                  nestedAction: SwipeNestedAction(
                    nestedWidth: 80.w,
                    curve: decelerateEasing,
                    impactWhenShowing: true,
                    content: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [AppColors.redColor, AppColors.lightRedColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      width: 80.sp,
                      height: 50.sp,
                      child: const OverflowBox(
                        maxWidth: double.infinity,
                        child: Center(
                          child: Text(
                            'تعديل',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                  content:
                      salesInvoiceCubit.getIconButton(Colors.red, Icons.edit),
                  onTap: (handler) async {
                    salesInvoiceCubit.indexOfEditableItem = index;
                    salesInvoiceCubit.editItem(
                        context: context,
                        selectedItemsList: salesInvoiceCubit.selectedItemsList,
                        index: index);
                    salesInvoiceCubit.swipeActionController.closeAllOpenCell();

                    /*  salesInvoiceCubit.accKey.currentState?.context
                        .read<SalesInvoiceCubit>()
                        .focusOnUnitPriceField(context); */

                    /* salesInvoiceCubit.removeItem(index); */
                    // Implement delete functionality
                  },
                ),
                SwipeAction(
                  forceAlignmentToBoundary: true,
                  closeOnTap: true,
                  nestedAction: SwipeNestedAction(
                    content: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [AppColors.lightRedColor, AppColors.redColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      width: 80.sp,
                      height: 50.sp,
                      child: const OverflowBox(
                        maxWidth: double.infinity,
                        child: Center(
                          child: Text(
                            'حذف',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                  content: salesInvoiceCubit.getIconButton(
                      Colors.blue, Icons.delete),
                  onTap: (handler) async {
                    salesInvoiceCubit.removeItem(index);
                    salesInvoiceCubit.swipeActionController.closeAllOpenCell();

                    // Implement delete functionality
                  },
                ),
              ],
              key: ValueKey(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 20.h,
                        children: [
                          // Product Name
                          BuildDetailsDataRow(
                            label: "اسم المنتج",
                            value: salesInvoiceCubit.itemsList
                                .firstWhere((element) =>
                                    element.itemId == request.itemNameAr)
                                .itemNameAr
                                .toString(),
                          ),
                          BuildDetailsDataRow(
                            label: "سعر الوحده",
                            value: "${request.prprice}",
                          ),
                          // Quantity
                          Row(
                            children: [
                              Expanded(
                                child: BuildDetailsDataRow(
                                  label: "الكمية",
                                  value: "${request.qty}",
                                ),
                              ),
                            ],
                          ),
                          // UOM

                          // Description
                          BuildDetailsDataRow(
                            label: "وحدة القياس",
                            value: salesInvoiceCubit.uomlist
                                .firstWhere(
                                    (element) => element.uomId == request.uom)
                                .uom
                                .toString(),
                          ),
                          // Length

                          if (salesInvoiceCubit.settings.supportsDimensionsBl ==
                              true)
                            Row(
                              children: [
                                Expanded(
                                  child: BuildDetailsDataRow(
                                    label: "الطول",
                                    value: "${request.length}",
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Expanded(
                                  child: BuildDetailsDataRow(
                                    label: "العرض",
                                    value: "${request.width}",
                                  ),
                                ),
                              ],
                            ),
                          // Width

                          // Height
                          if (salesInvoiceCubit.settings.supportsDimensionsBl ==
                              true)
                            Row(
                              children: [
                                BuildDetailsDataRow(
                                  label: "الارتفاع",
                                  value: "${request.height}",
                                ),
                              ],
                            ),
                          // Discount Percentage

                          // Discount Value
                          BuildDetailsDataRow(
                            label: "قيمة الخصم",
                            value: "${request.precentagevalue}",
                          ),
                          BuildDetailsDataRow(
                            label: "إجمالي الضرائب",
                            value: "${request.alltaxesvalue}",
                          ),
                          BuildDetailsDataRow(
                            label: "السعر ",
                            value: "${request.totalprice}",
                          ),
                          // Price

                          // Current Quantity
                          BuildDetailsDataRow(
                            label: "الكمية الحالية",
                            value: "${request.currentQty}",
                          ),
                          if (salesInvoiceCubit.settings.supportsDimensionsBl ==
                              true)
                            BuildDetailsDataRow(
                              label: "إجمالي الكمية",
                              value: "${request.allQtyValue}",
                            ),
                          // Total Quantity Value

                          // Total Taxes

                          // Total Price
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
