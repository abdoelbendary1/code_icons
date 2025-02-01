import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemCode.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildProductInfoWhileSelecting extends StatelessWidget {
  const BuildProductInfoWhileSelecting(
      {super.key, required this.salesInvoiceCubit});
  final SalesInvoiceCubit salesInvoiceCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                    child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                  bloc: salesInvoiceCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is getItemDataByIDSuccess) {
                      return SelectItemEntityCode(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال الكود";
                          }
                          return null;
                        },
                        /* initialItem: state.purchaseItemEntity, */
                        title: "الكود",
                        hintText: "اختيار الكود",
                        itemList: salesInvoiceCubit.itemsList,
                        onChanged: (value) {
                          salesInvoiceCubit.selectedItem = value;
                          salesInvoiceCubit.getItemByID(
                              id: salesInvoiceCubit.selectedItem.itemId!);
                        },
                      );
                    }
                    return SelectItemEntityCode(
                      validator: (value) {
                        if (value == null) {
                          return "يجب ادخال الكود";
                        }
                        return null;
                      },
                      title: "الكود",
                      hintText: "اختيار الكود",
                      itemList: salesInvoiceCubit.itemsList,
                      onChanged: (value) {
                        salesInvoiceCubit.selectedItem = value;
                        salesInvoiceCubit.getItemByID(
                            id: salesInvoiceCubit.selectedItem.itemId!);
                      },
                    );
                  },
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                  bloc: salesInvoiceCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is PurchasesItemSelected) {
                      return SelectItemEntityName(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال الاسم";
                          }
                          return null;
                        },
                        initialItem: state.selectedItem.itemNameAr,
                        title: "الاسم",
                        hintText: "اختيار الاسم",
                        itemList: salesInvoiceCubit.itemsList,
                        onChanged: (value) {
                          /* SalesInvoiceCubit.selectItem(
                              code: state.selectedItem.itemCode1!); */
                          /* state.selectedItem.itemNameAr = value; */
                          /*  salesInvoiceCubit.selectItem(name: value); */
                          salesInvoiceCubit.selectedItem = value;
                          salesInvoiceCubit.getItemByID(
                              id: salesInvoiceCubit.selectedItem.itemId!);
                        },
                      );
                    }

                    return SelectItemEntityName(
                      validator: (value) {
                        if (value == null) {
                          return "يجب ادخال الاسم";
                        }
                        return null;
                      },
                      title: "الاسم",
                      hintText: "اختيار الاسم",
                      itemList: salesInvoiceCubit.itemsList,
                      onChanged: (value) {
                        salesInvoiceCubit.selectedItem = value;
                        salesInvoiceCubit.getItemByID(
                            id: salesInvoiceCubit.selectedItem.itemId!);
                        /*  salesInvoiceCubit.selectItem(name: value); */
                      },
                    );
                  },
                )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
