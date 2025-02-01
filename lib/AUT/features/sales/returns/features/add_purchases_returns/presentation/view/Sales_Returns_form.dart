import 'package:accordion/accordion.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/AUT/features/sales/invoice/view/widgets/counrtyPicker.dart';
import 'package:accordion/controllers.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/edit_purchases_invoice/presentation/view/EditSales_Invoice.dart';
import 'package:code_icons/AUT/features/sales/returns/features/edit_purchases_returns/presentation/view/EditSales_Return.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectCustomerEntity.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectCurrency.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemCode.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemName.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectUOM.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectdrawerentity.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectableDropDownlist.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SalesReturnForm extends StatefulWidget {
  const SalesReturnForm({super.key});

  @override
  State<SalesReturnForm> createState() => _SalesReturnFormState();
}

class _SalesReturnFormState extends State<SalesReturnForm> {
  late SalesInvoiceCubit salesInvoiceCubit = SalesInvoiceCubit();
  StatefulWidget? myInheritedWidget;
  ControllerManager controllerManager = ControllerManager();

  @override
  void initState() {
    super.initState();
    /*  salesInvoiceCubit == getIt<SalesInvoiceCubit>(); */

    salesInvoiceCubit.quantityFocusNode.addListener(() {
      if (!salesInvoiceCubit.quantityFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        salesInvoiceCubit.onQtyTextFieldLoseFocus();
      }
    });
    salesInvoiceCubit.unitPriceFocusNode.addListener(() {
      if (!salesInvoiceCubit.unitPriceFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        salesInvoiceCubit.onUnitPriceTextFieldLoseFocus();
      }
    });
    salesInvoiceCubit.discountPFocusNode.addListener(() {
      if (!salesInvoiceCubit.discountPFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        salesInvoiceCubit.onDiscountPTextFieldLoseFocus();
      }
    });
    salesInvoiceCubit.discountVFocusNode.addListener(() {
      if (!salesInvoiceCubit.discountVFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        salesInvoiceCubit.onDiscountVTextFieldLoseFocus();
      }
    });
    salesInvoiceCubit.invoiceDiscountVFocusNode.addListener(() {
      if (!salesInvoiceCubit.invoiceDiscountVFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        salesInvoiceCubit.onInvoiceDiscountVFocusNodeTextFieldLoseFocus();
      }
    });
    salesInvoiceCubit.invoiceDiscountPFocusNode.addListener(() {
      if (!salesInvoiceCubit.invoiceDiscountPFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        salesInvoiceCubit.onInvoiceDiscountPTextFieldLoseFocus();
      }
    });

/*     salesInvoiceCubit.selectedItem = PurchaseItemEntity();
 */
    salesInvoiceCubit.initialze();
/*     salesInvoiceCubit.setupListeners();
 */
    /* salesInvoiceCubit.addSalesDiscountValueListener();
    salesInvoiceCubit.addSalesDiscountRateListener(); */
    /*  controllerManager
        .salesQuantityController
        .addListener(salesInvoiceCubit.updatePriceAndDiscountsIncludingTaxes); */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        /* controllerManager.clearControllers(
            controllers: controllerManager.salesControllers); */
        controllerManager.clearControllers(
            controllers: controllerManager.salesControllers);
        /*  controllerManager.clearControllers(
            controllers: controllerManager.invoiceControllers); */
      }
    });

    /*  salesInvoiceCubit.fetchCustomerData(skip: 0, take: 2); */

    Future.delayed(const Duration(seconds: 1));
  }

  final formKeyItems = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: salesInvoiceCubit.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Accordion(
              paddingBetweenClosedSections: 20,
              disableScrolling: true,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              contentBorderWidth: 0,
              contentBackgroundColor: Colors.transparent,
              headerBackgroundColorOpened: AppColors.greenColor,
              maxOpenSections: 3,
              headerBackgroundColor: AppColors.lightBlueColor,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                buildInvoiceInfoSection(context),
                buildItemInfoSection(context),
                buildSelectedItemsList(context),
              ],
            ),
            BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
              bloc: salesInvoiceCubit..updateDateControllers(),
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BuildTextField(
                              label: "الاجمالى",
                              keyboardType: TextInputType.number,
                              controller:
                                  controllerManager.invoiceTotalPriceController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: () {
                                controllerManager.invoiceTotalPriceController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .invoiceTotalPriceController
                                      .value
                                      .text
                                      .length,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: BuildTextField(
                              label: "اجمالى الضرائب",
                              keyboardType: TextInputType.number,
                              controller:
                                  controllerManager.invoiceTotalTaxesController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: () {
                                controllerManager.invoiceTotalTaxesController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .invoiceTotalTaxesController
                                      .value
                                      .text
                                      .length,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BuildTextField(
                              label: "نسبه الخصم",
                              focusNode:
                                  salesInvoiceCubit.invoiceDiscountPFocusNode,
                              onEditingComplete: () {
                                // Trigger the calculation when the user presses Enter
                                /*   salesInvoiceCubit
                                    .updateDiscountFromPercentage(); */
                                salesInvoiceCubit.updatePriceFromPercentage();
                              },
                              keyboardType: TextInputType.number,
                              controller: controllerManager
                                  .invoiceDiscountPercentageController,
                              /*  validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              }, */
                              onTap: () {
                                controllerManager
                                    .invoiceDiscountPercentageController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .invoiceDiscountPercentageController
                                      .value
                                      .text
                                      .length,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: BuildTextField(
                              label: "قيمه الخصم",
                              keyboardType: TextInputType.number,
                              focusNode:
                                  salesInvoiceCubit.invoiceDiscountVFocusNode,
                              controller: controllerManager
                                  .invoiceDiscountValueController,
                              /*    validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              }, */
                              onEditingComplete: () {
                                // Trigger the calculation when the user presses Enter
                                /*  salesInvoiceCubit.updateDiscountFromValue(); */
                                salesInvoiceCubit.updatePriceFromValue();
                              },
                              onTap: () {
                                controllerManager.invoiceDiscountValueController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .invoiceDiscountValueController
                                      .value
                                      .text
                                      .length,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                        bloc: salesInvoiceCubit,
                        builder: (context, state) {
                          return Visibility(
                            visible: salesInvoiceCubit.drawerIsShown,
                            child: BuildTextField(
                              label: "المدفوع",
                              keyboardType: TextInputType.number,
                              controller:
                                  controllerManager.invoicePaidController,
                              onTap: () {
                                controllerManager.invoicePaidController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .invoicePaidController.value.text.length,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BuildTextField(
                              label: "الصافى",
                              readOnly: true,
                              keyboardType: TextInputType.number,
                              controller:
                                  controllerManager.invoiceNetController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              },
                              onTap: () {
                                controllerManager.invoiceNetController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .invoiceNetController.value.text.length,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildSaveButton(
                  mainAxisAlignment: MainAxisAlignment.end,
                  title: AppLocalizations.of(context)!.save,
                  context: context,
                  onPressed: () async {
                    salesInvoiceCubit.postReturnReport(context: context);
                  },
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  AccordionSection buildItemInfoSection(BuildContext context) {
    return AccordionSection(
      key: salesInvoiceCubit.accKey,
      sectionOpeningHapticFeedback: SectionHapticFeedback.none,
      accordionId: "2",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      header: const Text('تفاصيل المردود',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
        bloc: salesInvoiceCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddPurchasesItemloading) {
            return buildProductInfoWhileSelecting(context);
          } else if (state is getItemDataByIDSuccess) {
            return buildSelectedItemInfo(context, state.salesItemDm);
          } else if (state is EditPurchasesItemSuccess) {
            return Focus(
              focusNode: salesInvoiceCubit.editItemFocusNode,
              canRequestFocus: true,
              child: buildSelectedItemInfoWhileEdit(
                  context, state.salesItemDm, state.selectedItemsList),
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
      ),
    );
  }

  Row buildSaveButton({
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
              Navigator.popAndPushNamed(context, EditSalesReturn.routeName,
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

  Column buildProductInfoWhileSelecting(BuildContext context) {
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

  Widget buildSelectedItemInfo(
      BuildContext context, SalesItemDm purchaseItemEntity) {
    return BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
      bloc: salesInvoiceCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKeyItems,
          child: Column(
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
                        child: SelectItemEntityCode(
                          validator: (value) {
                            if (value == null) {
                              return "يجب ادخال الكود";
                            }
                            return null;
                          },
                          initialItem: salesInvoiceCubit.selectedItem,
                          title: "الكود",
                          hintText: "اختيار الكود",
                          itemList: salesInvoiceCubit.itemsList,
                          onChanged: (value) {
                            salesInvoiceCubit.selectedItem = value;
                            salesInvoiceCubit.getItemByID(
                                id: salesInvoiceCubit.selectedItem.itemId!);
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SelectItemEntityName(
                          validator: (value) {
                            if (value == null) {
                              return "يجب ادخال الاسم";
                            }
                            return null;
                          },
                          initialItem: salesInvoiceCubit.selectedItem,
                          title: "الاسم",
                          hintText: "اختيار الاسم",
                          itemList: salesInvoiceCubit.itemsList,
                          onChanged: (value) {
                            salesInvoiceCubit.selectedItem = value;
                            salesInvoiceCubit.getItemByID(
                                id: salesInvoiceCubit.selectedItem.itemId!);
                            /*   salesInvoiceCubit.getTaxByid(
                                id: salesInvoiceCubit.selectedItem
                                    .itemTaxsRelation!.first.eTaxId!); */
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SelectItemEntityUOM(
                          validator: (value) {
                            if (value == null) {
                              return "يجب ادخال الوحده";
                            }
                            return null;
                          },
                          title: "وحدة القياس",
                          hintText: "اختيار وحدة القياس",
                          itemList: salesInvoiceCubit.selectedItem.itemUom!,
                          initialItem: salesInvoiceCubit
                                  .selectedItem.itemUom!.isNotEmpty
                              ? salesInvoiceCubit.selectedItem.itemUom!.first
                              : null, // Handle empty list
                          onChanged: (value) {
                            salesInvoiceCubit.selectedUom = value;
                            salesInvoiceCubit.selectUom(
                                name: salesInvoiceCubit.selectedUom!.uom!);
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Replace the old controllers with the new Sales-prefixed controllers
                  BuildTextField(
                    label: "سعر الوحدة",
                    hint: "سعر الوحدة",
                    keyboardType: TextInputType.number,
                    controller: controllerManager.salesUnitPriceController,
                    icon: Icons.phone_iphone,
                    focusNode: salesInvoiceCubit.unitPriceFocusNode,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال سعر";
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      // Trigger the calculation when the user presses Enter
                      salesInvoiceCubit
                          .doDiscountPercentage(salesInvoiceCubit.selectedItem);
                      FocusScope.of(context)
                          .requestFocus(salesInvoiceCubit.quantityFocusNode);
                      /* salesInvoiceCubit.updateQtyInclidingTaxes();
                            salesInvoiceCubit.updateTotalQty(); */
                    },
                    onTap: () {
                      controllerManager.salesUnitPriceController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .salesUnitPriceController.value.text.length,
                      );
                    },
                  ),

                  // Quantity Fields
                  Row(
                    children: [
                      Expanded(
                        child: BuildTextField(
                          label: "الكمية",
                          hint: "الكمية",
                          focusNode: salesInvoiceCubit.quantityFocusNode,
                          controller: controllerManager.salesQuantityController,
                          icon: Icons.diversity_3_sharp,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكمية";
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            salesInvoiceCubit.doDiscountPercentage(
                                salesInvoiceCubit.selectedItem);
                            FocusScope.of(context).requestFocus(
                                salesInvoiceCubit.discountPFocusNode);
                            salesInvoiceCubit.updateTotalQty();

                            /* salesInvoiceCubit.updateQtyInclidingTaxes();
                            salesInvoiceCubit.updateTotalQty(); */
                          },
                          onTap: () {
                            controllerManager.salesQuantityController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .salesQuantityController.value.text.length,
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: context
                                .read<SalesInvoiceCubit>()
                                .settings
                                .supportsDimensionsBl ??
                            false,
                        child: Expanded(
                          child: BuildTextField(
                            label: "إجمالي الكمية",
                            readOnly: true,
                            hint: "إجمالي الكمية",
                            controller:
                                controllerManager.salesTotalQuantityController,
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            /*   validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "يجب ادخال الكميه";
                                                  }
                                                  return null;
                                                }, */
                            onTap: () {
                              controllerManager.salesTotalQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
                                    .salesTotalQuantityController
                                    .value
                                    .text
                                    .length,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Discount Fields
                  Row(
                    children: [
                      Expanded(
                        child: BuildTextField(
                          label: "نسبة الخصم",
                          hint: "نسبة الخصم",
                          keyboardType: TextInputType.number,
                          focusNode: salesInvoiceCubit.discountPFocusNode,
                          controller:
                              controllerManager.salesDiscountRateController,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال النسبه";
                            }
                            return null;
                          }, */
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            salesInvoiceCubit.doDiscountPercentage(
                                salesInvoiceCubit.selectedItem);
                            FocusScope.of(context).requestFocus(
                                salesInvoiceCubit.discountVFocusNode);
                            /*  if (salesInvoiceCubit
                                    .selectedItem.calcBeforeDisc! ==
                                true) {
                              salesInvoiceCubit
                                  .calcTaxesAfterDiscountIncludingTaxesFormRate();
                            } else {
                              salesInvoiceCubit
                                  .calcTaxesBeforeDiscountIncludingTaxesFormRate();
                              /*  updatePriceAndDiscountsIncludingTaxesForValue(); */
                            } */
                          },
                          onTap: () {
                            controllerManager.salesDiscountRateController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .salesDiscountRateController
                                  .value
                                  .text
                                  .length,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: BuildTextField(
                          label: "قيمة الخصم",
                          hint: "قيمة الخصم",
                          keyboardType: TextInputType.number,
                          controller:
                              controllerManager.salesDiscountValueController,
                          icon: Icons.phone_iphone,
                          focusNode: salesInvoiceCubit.discountVFocusNode,

                          /* validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال قيمة";
                            }
                            return null;
                          }, */
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            salesInvoiceCubit.doDiscountValue(
                                salesInvoiceCubit.selectedItem);
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () {
                            controllerManager.salesDiscountValueController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .salesDiscountValueController
                                  .value
                                  .text
                                  .length,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  BuildTextField(
                    label: "إجمالى الضرائب",
                    readOnly: true,
                    hint: "إجمالى",
                    controller: controllerManager.salesTotalTaxesController,
                    icon: Icons.phone_iphone,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                    onTap: () {
                      controllerManager.salesTotalTaxesController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .salesTotalTaxesController.value.text.length,
                      );
                    },
                  ),
                  // Other Fields
                  Row(
                    children: [
                      Expanded(
                        child: BuildTextField(
                          label: "السعر",
                          hint: "السعر",
                          readOnly: true,
                          controller: controllerManager.salesPriceController,
                          icon: Icons.phone_iphone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال السعر";
                            }
                            return null;
                          },
                          onTap: () {
                            controllerManager.salesPriceController.selection =
                                TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .salesPriceController.value.text.length,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: BuildTextField(
                          label: "الكميه المتاحه",
                          hint: "الكميه المتاحه",
                          readOnly: true,
                          controller: controllerManager
                              .salesAvailableQuantityController,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                          onTap: () {
                            controllerManager.salesAvailableQuantityController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .salesAvailableQuantityController
                                  .value
                                  .text
                                  .length,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Operation Number, Length, Width, Height
                  Visibility(
                    visible: context
                            .read<SalesInvoiceCubit>()
                            .settings
                            .supportsBatchNumberBl ??
                        false,
                    child: BuildTextField(
                      label: "رقم التشغيليه",
                      hint: "رقم التشغيليه",
                      controller:
                          controllerManager.salesOperationNumberController,
                      icon: Icons.phone_iphone,
                      /*   validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "يجب ادخال الارتفاع";
                                        }
                                        return null;
                                      }, */
                      onTap: () {
                        controllerManager.salesOperationNumberController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .salesOperationNumberController.value.text.length,
                        );
                      },
                    ),
                  ),
                  BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit,
                    builder: (context, state) {
                      return Visibility(
                        visible: context
                                .read<SalesInvoiceCubit>()
                                .settings
                                .supportsDimensionsBl ??
                            false,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: BuildTextField(
                                    label: "الطول",
                                    hint: "الطول",
                                    controller:
                                        controllerManager.salesLengthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      controllerManager.salesLengthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: controllerManager
                                            .salesLengthController
                                            .value
                                            .text
                                            .length,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: BuildTextField(
                                    label: "العرض",
                                    hint: "العرض",
                                    controller:
                                        controllerManager.salesWidthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      controllerManager.salesWidthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: controllerManager
                                            .salesWidthController
                                            .value
                                            .text
                                            .length,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            BuildTextField(
                              label: "الارتفاع",
                              hint: "الارتفاع",
                              controller:
                                  controllerManager.salesHeightController,
                              icon: Icons.phone_iphone,
                              /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                              onTap: () {
                                controllerManager.salesHeightController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .salesHeightController.value.text.length,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Taxes and Description Fields

                  /*  BuildTextField(
                    label: "الضريبه",
                    readOnly: true,
                    controller: controllerManager.salesTaxesNameController,
                    icon: Icons.phone_iphone,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                    onTap: () {
                      controllerManager.salesTaxesNameController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .salesTaxesNameController
                            .value
                            .text
                            .length,
                      );
                    },
                  ),
                   */
                  BuildTextField(
                    label: "الوصف",
                    hint: "الوصف",
                    minLines: 3,
                    controller: controllerManager.salesDescriptionController,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                    onTap: () {
                      controllerManager.salesDescriptionController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .salesDescriptionController.value.text.length,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  buildSaveButton(
                    mainAxisAlignment: MainAxisAlignment.center,
                    title: " اضافه المنتج",
                    context: context,
                    onPressed: () async {
                      if (formKeyItems.currentState!.validate()) {
                        salesInvoiceCubit.saveSelectedItemAfterCheck(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSelectedItemInfoWhileEdit(
      BuildContext context,
      SalesItemDm purchaseItemEntity,
      List<InvoiceItemDetailsDm> selectedItemsList) {
    return BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
      bloc: salesInvoiceCubit,
      listener: (context, state) {},
      builder: (context, state) {
        while (state is EditPurchasesItemSuccess) {
          return Form(
            key: formKeyItems,
            child: Column(
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
                          child: SelectItemEntityCode(
                            validator: (value) {
                              if (value == null) {
                                return "يجب ادخال الكود";
                              }
                              return null;
                            },
                            initialItem: salesInvoiceCubit.itemsList.firstWhere(
                                (element) =>
                                    element.itemId == state.salesItemDm.itemId),
                            title: "الكود",
                            hintText: "اختيار الكود",
                            itemList: salesInvoiceCubit.itemsList,
                            onChanged: (value) {
                              salesInvoiceCubit.selectedItem = value;
                              salesInvoiceCubit.getItemByID(
                                  id: salesInvoiceCubit.selectedItem.itemId!);
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SelectItemEntityName(
                            validator: (value) {
                              if (value == null) {
                                return "يجب ادخال الاسم";
                              }
                              return null;
                            },
                            initialItem: salesInvoiceCubit.itemsList.firstWhere(
                                (element) =>
                                    element.itemId == state.salesItemDm.itemId),
                            title: "الاسم",
                            hintText: "اختيار الاسم",
                            itemList: salesInvoiceCubit.itemsList,
                            onChanged: (value) {
                              salesInvoiceCubit.selectedItem = value;
                              salesInvoiceCubit.getItemByID(
                                  id: salesInvoiceCubit.selectedItem.itemId!);
                              /*   salesInvoiceCubit.getTaxByid(
                                id: salesInvoiceCubit.selectedItem
                                    .itemTaxsRelation!.first.eTaxId!); */
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SelectItemEntityUOM(
                            validator: (value) {
                              if (value == null) {
                                return "يجب ادخال الوحده";
                              }
                              return null;
                            },
                            title: "وحدة القياس",
                            hintText: "اختيار وحدة القياس",
                            itemList: state.salesItemDm.itemUom!,
                            initialItem: state.salesItemDm.itemUom!.isNotEmpty
                                ? state.salesItemDm.itemUom!.first
                                : null, // Handle empty list
                            onChanged: (value) {
                              salesInvoiceCubit.selectedUom = value;
                              salesInvoiceCubit.selectUom(
                                  name: salesInvoiceCubit.selectedUom!.uom!);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Replace the old controllers with the new Sales-prefixed controllers
                    BuildTextField(
                      label: "سعر الوحدة",
                      hint: "سعر الوحدة",
                      keyboardType: TextInputType.number,
                      controller: controllerManager.salesUnitPriceController,
                      icon: Icons.phone_iphone,
                      focusNode: salesInvoiceCubit.unitPriceFocusNode,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال سعر";
                        }
                        return null;
                      },
                      onEditingComplete: () {
                        // Trigger the calculation when the user presses Enter
                        salesInvoiceCubit.doDiscountPercentage(
                            salesInvoiceCubit.selectedItem);

                        /* salesInvoiceCubit.updateQtyInclidingTaxes();
                            salesInvoiceCubit.updateTotalQty(); */
                      },
                      onTap: () {
                        controllerManager.salesUnitPriceController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .salesUnitPriceController.value.text.length,
                        );
                      },
                    ),

                    // Quantity Fields
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "الكمية",
                            hint: "الكمية",
                            focusNode: salesInvoiceCubit.quantityFocusNode,
                            controller:
                                controllerManager.salesQuantityController,
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الكمية";
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              salesInvoiceCubit.doDiscountPercentage(
                                  salesInvoiceCubit.selectedItem);
                              salesInvoiceCubit.updateTotalQty();

                              /*   salesInvoiceCubit.updateQtyInclidingTaxes();
                              salesInvoiceCubit.updateTotalQty(); */
                            },
                            onTap: () {
                              controllerManager.salesQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
                                    .salesQuantityController.value.text.length,
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: context
                                  .read<SalesInvoiceCubit>()
                                  .settings
                                  .supportsDimensionsBl ??
                              false,
                          child: Expanded(
                            child: BuildTextField(
                              label: "إجمالي الكمية",
                              readOnly: true,
                              hint: "إجمالي الكمية",
                              controller: controllerManager
                                  .salesTotalQuantityController,
                              icon: Icons.diversity_3_sharp,
                              keyboardType: TextInputType.number,
                              /*   validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "يجب ادخال الكميه";
                                                  }
                                                  return null;
                                                }, */
                              onTap: () {
                                controllerManager.salesTotalQuantityController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .salesTotalQuantityController
                                      .value
                                      .text
                                      .length,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Discount Fields
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "نسبة الخصم",
                            hint: "نسبة الخصم",
                            keyboardType: TextInputType.number,
                            controller:
                                controllerManager.salesDiscountRateController,
                            icon: Icons.phone_iphone,
                            focusNode: salesInvoiceCubit.discountPFocusNode,

                            /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال النسبه";
                            }
                            return null;
                          }, */
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              /*  salesInvoiceCubit.updatePrice(); */
                              salesInvoiceCubit.doDiscountPercentage(
                                  salesInvoiceCubit.selectedItem);
                            },
                            onTap: () {
                              controllerManager.salesDiscountRateController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
                                    .salesDiscountRateController
                                    .value
                                    .text
                                    .length,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: "قيمة الخصم",
                            hint: "قيمة الخصم",
                            focusNode: salesInvoiceCubit.discountVFocusNode,
                            keyboardType: TextInputType.number,
                            controller:
                                controllerManager.salesDiscountValueController,
                            icon: Icons.phone_iphone,
                            /* validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال قيمة";
                            }
                            return null;
                          }, */
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              salesInvoiceCubit.doDiscountValue(
                                  salesInvoiceCubit.selectedItem);
                            },
                            onTap: () {
                              controllerManager.salesDiscountValueController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
                                    .salesDiscountValueController
                                    .value
                                    .text
                                    .length,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    BuildTextField(
                      label: "إجمالى الضرائب",
                      readOnly: true,
                      hint: "إجمالى",
                      controller: controllerManager.salesTotalTaxesController,
                      icon: Icons.phone_iphone,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                      onTap: () {
                        controllerManager.salesTotalTaxesController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .salesTotalTaxesController.value.text.length,
                        );
                      },
                    ),
                    // Other Fields
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "السعر",
                            hint: "السعر",
                            readOnly: true,
                            controller: controllerManager.salesPriceController,
                            icon: Icons.phone_iphone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال السعر";
                              }
                              return null;
                            },
                            onTap: () {
                              controllerManager.salesPriceController.selection =
                                  TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
                                    .salesPriceController.value.text.length,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: "الكميه المتاحه",
                            hint: "الكميه المتاحه",
                            readOnly: true,
                            controller: controllerManager
                                .salesAvailableQuantityController,
                            icon: Icons.phone_iphone,
                            /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                            onTap: () {
                              controllerManager.salesAvailableQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
                                    .salesAvailableQuantityController
                                    .value
                                    .text
                                    .length,
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // Operation Number, Length, Width, Height
                    Visibility(
                      visible: context
                              .read<SalesInvoiceCubit>()
                              .settings
                              .supportsBatchNumberBl ??
                          false,
                      child: BuildTextField(
                        label: "رقم التشغيليه",
                        hint: "رقم التشغيليه",
                        controller:
                            controllerManager.salesOperationNumberController,
                        icon: Icons.phone_iphone,
                        /*   validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "يجب ادخال الارتفاع";
                                          }
                                          return null;
                                        }, */
                        onTap: () {
                          controllerManager.salesOperationNumberController
                              .selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: controllerManager
                                .salesOperationNumberController
                                .value
                                .text
                                .length,
                          );
                        },
                      ),
                    ),
                    BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                      bloc: salesInvoiceCubit,
                      builder: (context, state) {
                        return Visibility(
                          visible: context
                                  .read<SalesInvoiceCubit>()
                                  .settings
                                  .supportsDimensionsBl ??
                              false,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: BuildTextField(
                                      label: "الطول",
                                      hint: "الطول",
                                      controller: controllerManager
                                          .salesLengthController,
                                      icon: Icons.phone_iphone,
                                      /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                      onTap: () {
                                        controllerManager.salesLengthController
                                            .selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: controllerManager
                                              .salesLengthController
                                              .value
                                              .text
                                              .length,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: BuildTextField(
                                      label: "العرض",
                                      hint: "العرض",
                                      controller: controllerManager
                                          .salesWidthController,
                                      icon: Icons.phone_iphone,
                                      /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                      onTap: () {
                                        controllerManager.salesWidthController
                                            .selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: controllerManager
                                              .salesWidthController
                                              .value
                                              .text
                                              .length,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              BuildTextField(
                                label: "الارتفاع",
                                hint: "الارتفاع",
                                controller:
                                    controllerManager.salesHeightController,
                                icon: Icons.phone_iphone,
                                /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                                onTap: () {
                                  controllerManager.salesHeightController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: controllerManager
                                        .salesHeightController
                                        .value
                                        .text
                                        .length,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // Taxes and Description Fields

                    /*  BuildTextField(
                      label: "الضريبه",
                      readOnly: true,
                      controller: controllerManager.salesTaxesNameController,
                      icon: Icons.phone_iphone,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                      onTap: () {
                        controllerManager.salesTaxesNameController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .salesTaxesNameController
                              .value
                              .text
                              .length,
                        );
                      },
                    ),
                     */
                    BuildTextField(
                      label: "الوصف",
                      hint: "الوصف",
                      minLines: 3,
                      controller: controllerManager.salesDescriptionController,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                      onTap: () {
                        controllerManager.salesDescriptionController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .salesDescriptionController.value.text.length,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildSaveButton(
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
                  ],
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  AccordionSection buildInvoiceInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "1",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      header: const Text('بيانات المردود',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        /*    validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الفرع";
                          }
                          return null;
                        }, */
                        title: "الفرع",
                        hintText: "اختيار الفرع",
                        itemList: salesInvoiceCubit.storeNamesList,
                        initialItem: salesInvoiceCubit.storeNamesList.isNotEmpty
                            ? salesInvoiceCubit.storeNamesList.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          salesInvoiceCubit.selectStore(name: value);
                        },
                      );
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                        bloc: salesInvoiceCubit
                          ..fetchCustomerData(skip: 0, take: 2),
                        listener: (context, state) {
                          if (state is AddSalesCustomerLoading) {
                            DialogUtils.showLoading(
                                context: context, message: "message");
                          }
                        },
                        builder: (context, state) {
                          if (state is AddSalesCustomerSuccess) {
                            print(
                                "salesInvoiceCubit.selectedCustomer.cusNameAr : ${salesInvoiceCubit.selectedCustomer.cusNameAr}");
                            print(salesInvoiceCubit.selectedCustomer.id);
                            return SelectCustomerEntity(
                              title: "العملاء",
                              hintText: "اختيار العميل",
                              itemList: salesInvoiceCubit.customerData,
                              initialItem:
                                  state.customerEntity, // Handle empty list
                              onChanged: (value) {
                                salesInvoiceCubit.selectedCustomer = value;
                              },
                            );
                          } else {
                            print(
                                "salesInvoiceCubit.selectedCustomer.cusNameAr : ${salesInvoiceCubit.selectedCustomer.cusNameAr}");
                            print(salesInvoiceCubit.selectedCustomer.id);

                            return SelectCustomerEntity(
                              title: "العملاء",
                              hintText: "اختيار العميل",
                              itemList: salesInvoiceCubit.customerData,
                              initialItem: salesInvoiceCubit
                                      .customerData.isNotEmpty
                                  ? salesInvoiceCubit.customerData.firstWhere(
                                      (element) =>
                                          element.id ==
                                          salesInvoiceCubit.selectedCustomer.id,
                                      orElse: () => salesInvoiceCubit
                                          .customerData
                                          .first as InvoiceCustomerDm,
                                      /* context
                                                .read<SalesInvoiceCubit>()
                                                .selectedCustomer
                                                .id, */
                                    )
                                  : null, // Handle empty list
                              onChanged: (value) {
                                salesInvoiceCubit.selectedCustomer = value;
                              },
                            );
                          }
                        },
                      )),
                  Expanded(
                      flex: 2,
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                        bloc: salesInvoiceCubit,
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 45.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: AppColors.blueColor,
                                  minimumSize: Size.fromHeight(60.h),
                                ),
                                onPressed: () {
                                  controllerManager.clearControllers(
                                      controllers:
                                          controllerManager.addSalesCustomer);

                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    backgroundColor: AppColors.whiteColor,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 12.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              // BuildTextField for invoice source code
                                              BuildTextField(
                                                label: "اسم العميل",
                                                hint: "الاسم",
                                                controller: controllerManager
                                                    .invoiceAddCustomerNameController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddCustomerNameController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddCustomerNameController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ),
                                              BuildTextField(
                                                label: "الرقم الضريبي",
                                                hint: "الرقم الضريبي",
                                                controller: controllerManager
                                                    .invoiceAddCustomerTaxNumController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddCustomerTaxNumController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddCustomerTaxNumController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ),
                                              BuildTextField(
                                                label: "الجوال",
                                                hint: "الجوال",
                                                controller: controllerManager
                                                    .invoiceAddCustomerPhoneController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddCustomerPhoneController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddCustomerPhoneController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "الدولة",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              CountryDropdown(
                                                countries: salesInvoiceCubit
                                                    .listOfCountries(),
                                                salesInvoiceCubit:
                                                    salesInvoiceCubit,
                                              ),

                                              SizedBox(
                                                height: 45.h,
                                              ),
                                              buildSaveButton(
                                                  context: context,
                                                  onPressed: () {
                                                    InvoiceCustomerDm
                                                        invoiceCustomer =
                                                        InvoiceCustomerDm(
                                                      cusNameAr: controllerManager
                                                          .invoiceAddCustomerNameController
                                                          .text,
                                                      mobile: controllerManager
                                                          .invoiceAddCustomerPhoneController
                                                          .text,
                                                      taxCardNumber:
                                                          controllerManager
                                                              .invoiceAddCustomerTaxNumController
                                                              .text,
                                                      csType: 0,
                                                      countryId:
                                                          salesInvoiceCubit
                                                              .countryCode,
                                                    );
                                                    salesInvoiceCubit
                                                        .addCustomer(
                                                            invoiceCustomer,
                                                            context);
                                                  },
                                                  title: "إضافه",
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.whiteColor,
                                  size: 25,
                                ),
                              )
                            ],
                          );
                        },
                      )),
                ],
              ),
              /*     Row(
                children: [
                  Expanded(
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit..getCostCenterData(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectCostCenterEntity(
                        /*   validator: (value) {
                          if (value == null) {
                            return "يجب ادخال مركز التكلفة";
                          }
                          return null;
                        }, */
                        title: "مركز التكلفة",
                        hintText: "اختيار مركز",
                        itemList: salesInvoiceCubit.costCenterList,
                        initialItem: salesInvoiceCubit.costCenterList.isNotEmpty
                            ? salesInvoiceCubit.costCenterList.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          salesInvoiceCubit.selectedCostCenter = value;
                        },
                      );
                    },
                  )),
                ],
              ),
               */
              BuildTextField(
                label: "التاريخ",
                hint: "التاريخ ",
                controller: controllerManager.invoiceDateController,
                readOnly: true,
                icon: Icons.app_registration,
                color: AppColors.greyColor,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller: controllerManager.invoiceDateController,
                      dateStorageMap: salesInvoiceCubit.dateStorageMap,
                      key: "purchaseDateController");
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ ";
                  }
                  return null;
                },
              ),
              /*  BuildTextField(
                label: "تاريخ الاستلام",
                hint: "التاريخ ",
                color: AppColors.greyColor,
                controller: controllerManager.invoiceReceiveDateController,
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller:
                          controllerManager.invoiceReceiveDateController,
                      dateStorageMap: salesInvoiceCubit.dateStorageMap,
                      key: "purchaseDateController");
                },
                /*  validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ ";
                  }
                  return null;
                }, */
              ),
              BuildTextField(
                label: "تاريخ الاستحقاق",
                hint: "التاريخ ",
                color: AppColors.greyColor,
                controller: controllerManager.invoiceDueDateController,
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller: controllerManager.invoiceDueDateController,
                      dateStorageMap: salesInvoiceCubit.dateStorageMap,
                      key: "purchaseDateController");
                },
                /*   validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ ";
                  }
                  return null;
                }, */
              ), */
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit..getCurrencyData(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectCurrencyEntity(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال العمله";
                          }
                          return null;
                        },
                        title: "العمله",
                        hintText: "اختيار",
                        itemList: salesInvoiceCubit.currencyList,
                        initialItem: salesInvoiceCubit.currencyList.isNotEmpty
                            ? salesInvoiceCubit.currencyList.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          salesInvoiceCubit.selectedCurrency = value;
                          salesInvoiceCubit.updateRate();
                          /*   controllerManager.invoiceRateController.text =
                              context
                                  .read<SalesInvoiceCubit>()
                                  .selectedCurrency
                                  .rate
                                  .toString(); */
                        },
                      );
                    },
                  )),
                  Expanded(
                    child: BuildTextField(
                      label: "المعامل",
                      hint: "المعامل",
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: controllerManager.invoiceRateController,
                      icon: Icons.diversity_3_sharp,
                      onTap: () {
                        controllerManager.invoiceRateController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .invoiceRateController.value.text.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
              /*    Row(
                children: [
                  Expanded(
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit..fetchpaymentTypeList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال طبيعه الدفع";
                          }
                          return null;
                        },
                        title: "طبيعة الدفع",
                        hintText: "طبيعه الدفع",
                        itemList: salesInvoiceCubit.paymentTypes,
                        initialItem: salesInvoiceCubit.paymentTypes.isNotEmpty
                            ? salesInvoiceCubit.paymentTypes.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          salesInvoiceCubit.selectedPaymentType = value;
                          salesInvoiceCubit.changeDrawer(value);
                        },
                      );
                    },
                  )),
                ],
              ),
              BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                bloc: salesInvoiceCubit,
                builder: (context, state) {
                  return Visibility(
                    visible: salesInvoiceCubit.drawerIsShown,
                    child: Row(
                      children: [
                        Expanded(
                            child: BlocBuilder<SalesInvoiceCubit,
                                SalesInvoiceState>(
                          bloc: salesInvoiceCubit,
                          builder: (context, state) {
                            return SelectDrawerEntity(
                              /*   validator: (value) {
                                                                                  if (value == null) {
                                                                                    return "يجب ادخال الخزينه";
                                                                                  }
                                                                                  return null;
                                                                                }, */
                              title: "الخزينه",
                              hintText: "الخزينه",
                              itemList: salesInvoiceCubit.drawerEntityList,
                              initialItem:
                                  salesInvoiceCubit.drawerEntityList.isNotEmpty
                                      ? salesInvoiceCubit.drawerEntityList.first
                                      : null, // Handle empty list
                              onChanged: (value) {
                                salesInvoiceCubit.selectedDrawerEntity = value;
                              },
                            );
                          },
                        )),
                      ],
                    ),
                  );
                },
              ), */
              BuildTextField(
                label: "ملاحظات",
                hint: "ملاحظات",
                minLines: 1,
                maxLines: 5,
                controller: controllerManager.invoiceNotesController,
                icon: Icons.phone_iphone,
                /*  validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال ملاحظات";
                  }
                  return null;
                }, */
                onTap: () {
                  controllerManager.invoiceNotesController.selection =
                      TextSelection(
                    baseOffset: 0,
                    extentOffset: controllerManager
                        .invoiceNotesController.value.text.length,
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  AccordionSection buildSelectedItemsList(BuildContext context) {
    return AccordionSection(
      contentBorderColor: Colors.white,
      contentBorderWidth: 0,
      accordionId: "3",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      header: const Text('المردود',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: SingleChildScrollView(
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
                  "تفاصيل المردودات",
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
                    state is GetAllDatSuccess ||
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
                              "لا يوجد مردودات",
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
                                return buildItemCard(request, index);
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
                            "لا يوجد مردودات ",
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
      ),
      /* Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
            bloc: SalesInvoiceCubit,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AddPurchasesItemSuccess) {
                if (state.selectedItemsList.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "القائمة فارغه",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  );
                } else {}
              }
            },
          ),
        ],
      ), */
    );
  }

  Widget buildItemCard(InvoiceItemDetailsDm request, int index) {
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
                          buildDetailRow(
                            label: "اسم المنتج",
                            value: salesInvoiceCubit.itemsList
                                .firstWhere((element) =>
                                    element.itemCode1 == request.itemCode1)
                                .itemNameAr
                                .toString(),
                          ),
                          buildDetailRow(
                            label: "سعر الوحده",
                            value: "${request.prprice}",
                          ),
                          // Quantity
                          Row(
                            children: [
                              Expanded(
                                child: buildDetailRow(
                                  label: "الكمية",
                                  value: "${request.qty}",
                                ),
                              ),
                            ],
                          ),
                          // UOM

                          // Description
                          buildDetailRow(
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
                                  child: buildDetailRow(
                                    label: "الطول",
                                    value: "${request.length}",
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Expanded(
                                  child: buildDetailRow(
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
                                buildDetailRow(
                                  label: "الارتفاع",
                                  value: "${request.height}",
                                ),
                              ],
                            ),
                          // Discount Percentage

                          // Discount Value
                          buildDetailRow(
                            label: "قيمة الخصم",
                            value: "${request.precentagevalue}",
                          ),
                          buildDetailRow(
                            label: "إجمالي الضرائب",
                            value: "${request.alltaxesvalue}",
                          ),
                          buildDetailRow(
                            label: "السعر ",
                            value: "${request.totalprice}",
                          ),
                          // Price

                          // Current Quantity
                          buildDetailRow(
                            label: "الكمية الحالية",
                            value: "${request.currentQty}",
                          ),
                          if (salesInvoiceCubit.settings.supportsDimensionsBl ==
                              true)
                            buildDetailRow(
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
  } // Helper function to create a reusable row for each detail

  Widget buildDetailRow({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 8.h),
              Icon(Icons.label_outline, size: 20.sp),
            ],
          ),
          SizedBox(width: 8.w),

          // Use Flexible or Expanded to make sure text wraps properly
          Expanded(
            child: Text(
              "$label: $value",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.sp,
              ),
              softWrap: true, // Enables wrapping
              overflow:
                  TextOverflow.visible, // Allows text to go to the next line
            ),
          ),
        ],
      ),
    );
  }
}
