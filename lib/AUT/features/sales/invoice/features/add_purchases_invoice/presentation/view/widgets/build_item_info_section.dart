import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_product_info_while_selecting.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_selected_item_info.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_selected_item_info_while_edit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/edit_purchases_invoice/presentation/view/EditSales_Invoice.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class BuildItemInfoSection extends StatelessWidget {
  const BuildItemInfoSection(
      {super.key,
      required this.salesInvoiceCubit,
      required this.controllerManager,
      required this.formKeyItems});
  final SalesInvoiceCubit salesInvoiceCubit;
  final ControllerManager controllerManager;
  final GlobalKey<FormState> formKeyItems;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
      bloc: salesInvoiceCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AddPurchasesItemloading) {
          return BuildProductInfoWhileSelecting(
              salesInvoiceCubit: salesInvoiceCubit);
        } else if (state is getItemDataByIDSuccess) {
          return BuildSelectedItemInfo(
            controllerManager: controllerManager,
            formKey: formKeyItems,
            salesInvoiceCubit: salesInvoiceCubit,
            saveButton: buildSaveButton(
              mainAxisAlignment: MainAxisAlignment.center,
              title: " اضافه المنتج",
              context: context,
              onPressed: () async {
                if (formKeyItems.currentState!.validate()) {
                  salesInvoiceCubit.saveSelectedItemAfterCheck(context);
                }
              },
            ),
          );
        } else if (state is EditPurchasesItemSuccess) {
          return Focus(
            focusNode: salesInvoiceCubit.editItemFocusNode,
            canRequestFocus: true,
            child: BuildSelectedItemInfoWhileEdit(
              controllerManager: controllerManager,
              formKey: formKeyItems,
              salesInvoiceCubit: salesInvoiceCubit,
              saveButton: buildSaveButton(
                mainAxisAlignment: MainAxisAlignment.center,
                title: " تعديل المنتج",
                context: context,
                onPressed: () async {
                  if (formKeyItems.currentState!.validate()) {
                    salesInvoiceCubit.editSelectedItem(
                        salesInvoiceCubit.indexOfEditableItem);
                  }
                },
              ),
            ),
          );
        } else if (state is GetAllDatSuccess) {
          return buildAddFirstProduct(context);
        } else if (state is AddPurchasesItemSuccess ||
            state is AddPurchasesRequestError ||
            state is AddPurchasesItemloading ||
            state is SalesInvoiceLoading ||
            state is FetchCustomersSuccess ||
            state is GetAllDatSuccess ||
            state is AddSalesCustomerSuccess ||
            state is GetAllDatSuccess ||
            state is getItemDataByIDSuccess) {
          return buildItemsListWithAddition(context);
        } else if (state is AddPurchasesItemError) {
          return LoadingStateAnimation();
        } else if (state is GetPurchasesListloading) {
          return LoadingStateAnimation();
        }
        return Container();
      },
    );
  }
 Widget buildSaveButton({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
    required MainAxisAlignment mainAxisAlignment,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        BlocListener<SalesInvoiceCubit, SalesInvoiceState>(
          bloc: salesInvoiceCubit,
          listener: (context, state) {
            if (state is AddPurchasesRequestSuccess) {
              DialogUtils.hideLoading(context);

              /* SnackBarUtils.showSnackBar(
                context: GlobalVariable.navigatorState.currentContext!,
                label: "تمت الإضافه بنجاح",
                backgroundColor: AppColors.greenColor,
              ); */

              /*  SchedulerBinding.instance.addPostFrameCallback((_) {
                // add your code here.
              }); */
              DialogUtils.hideLoading(context);
              Navigator.popAndPushNamed(context, EditSalesInvoice.routeName,
                  arguments: state.invoiceId);
              QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                title: "تمت الاضافه بنجاح",
                titleColor: AppColors.greenColor,
                /* text: state.errorMsg, */
              );
            } else if (state is AddPurchasesRequestError) {
              if (state.errorMsg.contains("400")) {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMsg,
                  titleColor: AppColors.redColor,
                  /* text: state.errorMsg, */
                );
              } else if (state.errorMsg.contains("500")) {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMsg,
                  titleColor: AppColors.redColor,
                  /* text: state.errorMsg, */
                );

                print(state.errorMsg);
              }
            } else if (state is SalesInvoiceLoading) {
              DialogUtils.showLoading(
                  context: context, message: "state.loadingMessege");
            } else if (state is AddPurchasesRequestError) {
              QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                title: "تمت الاضافه بنجاح",
                titleColor: AppColors.greenColor,
                /* text: state.errorMsg, */
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPressed,
              child: Text(title),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        )
      ],
    );
  }

  Column buildItemsListWithAddition(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        buildSaveButton(
            mainAxisAlignment: MainAxisAlignment.center,
            title: "إضافه منتج جديد",
            context: context,
            onPressed: () async {
              salesInvoiceCubit.waitForAddItems();
            }),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget buildAddFirstProduct(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60.h,
        ),
        buildSaveButton(
            mainAxisAlignment: MainAxisAlignment.center,
            title: "إضافه منتج جديد",
            context: context,
            onPressed: () async {
              salesInvoiceCubit.waitForAddItems();
              salesInvoiceCubit.clearDiscounts();
            }),
        SizedBox(
          height: 60.h,
        ),
      ],
    );
  }

 }
