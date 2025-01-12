import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:code_icons/data/model/response/vendors/vendors_dm.dart';
import 'package:code_icons/domain/entities/invoice/drawer/drawer_entity.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectVendorEntity.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectCostCenter.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/invoice/drawer_dm.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectCustomerEntity.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectCurrency.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemCode.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemName.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectUOM.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectdrawerentity.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectableDropDownlist.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/GlobalVariables.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/pdf_generator.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';

class EditPRInvoiceForm extends StatefulWidget {
  const EditPRInvoiceForm({super.key});

  @override
  State<EditPRInvoiceForm> createState() => _EditPRInvoiceFormState();
}

class _EditPRInvoiceFormState extends State<EditPRInvoiceForm> {
  PurchasesCubit purchasesCubit = PurchasesCubit();
  StatefulWidget? myInheritedWidget;

  @override
  void initState() {
    super.initState();
    purchasesCubit.quantityFocusNode.addListener(() {
      if (!purchasesCubit.quantityFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        purchasesCubit.onQtyTextFieldLoseFocus();
      }
    });
    purchasesCubit.unitPriceFocusNode.addListener(() {
      if (!purchasesCubit.unitPriceFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        purchasesCubit.onUnitPriceTextFieldLoseFocus();
      }
    });
    purchasesCubit.discountPFocusNode.addListener(() {
      if (!purchasesCubit.discountPFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        purchasesCubit.onDiscountPTextFieldLoseFocus();
      }
    });
    purchasesCubit.discountVFocusNode.addListener(() {
      if (!purchasesCubit.discountVFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        purchasesCubit.onDiscountVTextFieldLoseFocus();
      }
    });
    purchasesCubit.invoiceDiscountVFocusNode.addListener(() {
      if (!purchasesCubit.invoiceDiscountVFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        purchasesCubit.onInvoiceDiscountVFocusNodeTextFieldLoseFocus();
      }
    });
    purchasesCubit.invoiceDiscountPFocusNode.addListener(() {
      if (!purchasesCubit.invoiceDiscountPFocusNode.hasFocus) {
        // Trigger the function when the TextField loses focus (tap outside)
        purchasesCubit.onInvoiceDiscountPTextFieldLoseFocus();
      }
    });
/*     purchasesCubit.selectedItem = PurchaseItemEntity();
 */
    purchasesCubit.initialze();
/*     purchasesCubit.setupListeners();
 */
    /* purchasesCubit.addSalesDiscountValueListener();
    purchasesCubit.addSalesDiscountRateListener(); */
    /*  ControllerManager()
        .prQuantityController
        .addListener(purchasesCubit.updatePriceAndDiscountsIncludingTaxes); */
    /*   ControllerManager()
        .clearControllers(controllers: ControllerManager().salesControllers); */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        /*  ControllerManager().purchaseInvoiceDateController.text =
            DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());
        ControllerManager().invoiceReceiveDateController.text =
            DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());
        ControllerManager().invoiceDueDateController.text =
            DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now()); */
        ControllerManager()
            .clearControllers(controllers: ControllerManager().prControllers);
        ControllerManager().clearControllers(
            controllers: ControllerManager().prinvoiceControllers);
      }
    });
    purchasesCubit.fetchCustomerData(skip: 0, take: 2);

    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var invoiceId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) =>
          purchasesCubit..fetchPrInvoicesDataById(id: invoiceId),
      child: Form(
        key: purchasesCubit.formKey,
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
                maxOpenSections: 2,
                headerBackgroundColor: AppColors.lightBlueColor,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                children: [
                  buildInvoiceInfoSection(context),
                  buildItemInfoSection(context),
                  buildSelectedItemsList(context),
                ],
              ),
              BlocBuilder<PurchasesCubit, PurchasesState>(
                bloc: purchasesCubit,
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
                                controller: ControllerManager()
                                    .prinvoiceTotalPriceController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () {
                                  ControllerManager()
                                      .prinvoiceTotalPriceController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prinvoiceTotalPriceController
                                        .value
                                        .text
                                        .length,
                                  );
                                },
                              ),
                            ),
                            /*       Expanded(
                              child: BuildTextField(
                                label: "اجمالى الضرائب",
                                keyboardType: TextInputType.number,
                                controller: ControllerManager()
                                    .prinvoiceTotalTaxesController,
                                /*  validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                }, */
                                readOnly: true,
                                onTap: () {
                                  ControllerManager()
                                      .prinvoiceTotalTaxesController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prinvoiceTotalTaxesController
                                        .value
                                        .text
                                        .length,
                                  );
                                },
                              ),
                            ),
                           */
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BuildTextField(
                                label: "نسبه الخصم",
                                focusNode:
                                    purchasesCubit.invoiceDiscountPFocusNode,
                                onEditingComplete: () {
                                  // Trigger the calculation when the user presses Enter
                                  purchasesCubit.updatePriceFromPercentage();
                                },
                                keyboardType: TextInputType.number,
                                controller: ControllerManager()
                                    .prinvoiceDiscountPercentageController,
                                /*  validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                }, */
                                onTap: () {
                                  ControllerManager()
                                      .prinvoiceDiscountPercentageController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prinvoiceDiscountPercentageController
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
                                focusNode:
                                    purchasesCubit.invoiceDiscountVFocusNode,
                                keyboardType: TextInputType.number,
                                controller: ControllerManager()
                                    .prinvoiceDiscountValueController,
                                /*    validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                }, */
                                onEditingComplete: () {
                                  // Trigger the calculation when the user presses Enter
                                  purchasesCubit.updatePriceFromValue();
                                },
                                onTap: () {
                                  ControllerManager()
                                      .prinvoiceDiscountValueController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prinvoiceDiscountValueController
                                        .value
                                        .text
                                        .length,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<PurchasesCubit, PurchasesState>(
                          bloc: purchasesCubit,
                          builder: (context, state) {
                            return Visibility(
                              visible: purchasesCubit.drawerIsShown,
                              child: BuildTextField(
                                label: "المدفوع",
                                keyboardType: TextInputType.number,
                                controller:
                                    ControllerManager().prinvoicePaidController,
                                onTap: () {
                                  ControllerManager()
                                      .prinvoicePaidController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prinvoicePaidController
                                        .value
                                        .text
                                        .length,
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
                                    ControllerManager().prinvoiceNetController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  ControllerManager()
                                      .prinvoiceNetController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prinvoiceNetController
                                        .value
                                        .text
                                        .length,
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
                    title: "تعديل",
                    context: context,
                    onPressed: () async {
                      purchasesCubit.updateSalesReport(
                          context: context, id: invoiceId);
                    },
                  ),
                  buildSaveButton(
                    mainAxisAlignment: MainAxisAlignment.end,
                    title: "طباعه",
                    context: context,
                    onPressed: () async {
/*                       buildInvoicePrint(purchasesCubit.selectedItemsList);
 */
                      purchasesCubit.getInvoicePrint(
                          id: invoiceId.toString(), context: context);
                      /*   PdfGenerator.createPdf(
                          purchasesCubit: purchasesCubit,
                          selectedItemsList:
                              purchasesCubit.selectedItemsList); */
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  AccordionSection buildItemInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "2",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      header: const Text('تفاصيل الفاتوره',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BlocConsumer<PurchasesCubit, PurchasesState>(
        bloc: purchasesCubit /* ..getStoreData() */,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddPurchasesItemloading) {
            return buildProductInfoWhileSelecting(context);
          } else if (state is getItemDataByIDSuccess) {
            return buildSelectedItemInfo(context, state.salesItemDm);
          } else if (state is EditPurchasesItemSuccess) {
            return buildSelectedItemInfoWhileEdit(
                context, state.salesItemDm, state.selectedItemsList);
          } else if (state is GetAllDatSuccess) {
            return buildAddFirstProduct(context);
          } else if (state is UpdatePurchasesRequestSuccess ||
              state is AddPurchasesItemloading ||
              state is GetInvoiceItemsSuccess ||
              state is AddPurchasesRequestError ||
              state is AddPurchasesItemSuccess) {
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
        BlocListener<PurchasesCubit, PurchasesState>(
          bloc: purchasesCubit,
          listener: (context, state) {
            if (state is UpdatePurchasesRequestSuccess) {
              /*    DialogUtils.hideLoading(context); */
/*               DialogUtils.hideLoading(context);
 */
              /*  SchedulerBinding.instance.addPostFrameCallback((_) {
                // add your code here.
              }); */

              /*   Navigator.pushReplacementNamed(
                context,
                AllInvoicesScreenCards.routeName,
                /*   (route) {
                  return false;
                }, */
              );
           */
              /*    QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                title: "تمت التعديل بنجاح",
                titleColor: AppColors.greenColor,
                /* text: state.errorMsg, */
              ); */
            } else if (state is AddPurchasesRequestError) {
              if (state.errorMsg.contains("400")) {
                SnackBarUtils.showSnackBar(
                  context: GlobalVariable.navigatorState.currentContext!,
                  label: "برجاء ادخال البيانات صحيحه",
                  backgroundColor: AppColors.redColor,
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
              }
            } /* else if (state is UpdateSalesInvoiceLoading) {
              DialogUtils.showLoading(
                  context: context, message: "state.loadingMessege");
            }  */
            else if (state is AddPurchasesRequestError) {
              QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: "حدث خطأ ما",
                titleColor: AppColors.redColor,
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
              purchasesCubit.waitForAddItems();
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
              purchasesCubit.waitForAddItems();
              purchasesCubit.clearDiscounts();
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
                    child: BlocConsumer<PurchasesCubit, PurchasesState>(
                  bloc: purchasesCubit,
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
                        itemList: context.read<PurchasesCubit>().itemsList,
                        onChanged: (value) {
                          purchasesCubit.selectedItem = value;
                          purchasesCubit.getItemByID(
                              id: purchasesCubit.selectedItem.itemId!);
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
                      itemList: context.read<PurchasesCubit>().itemsList,
                      onChanged: (value) {
                        purchasesCubit.selectedItem = value;
                        purchasesCubit.getItemByID(
                            id: purchasesCubit.selectedItem.itemId!);
                      },
                    );
                  },
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: BlocConsumer<PurchasesCubit, PurchasesState>(
                  bloc: purchasesCubit,
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
                        itemList: purchasesCubit.itemsList,
                        onChanged: (value) {
                          /* PurchasesCubit.selectItem(
                              code: state.selectedItem.itemCode1!); */
                          /* state.selectedItem.itemNameAr = value; */
                          /*  purchasesCubit.selectItem(name: value); */
                          purchasesCubit.selectedItem = value;
                          purchasesCubit.getItemByID(
                              id: purchasesCubit.selectedItem.itemId!);
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
                      itemList: purchasesCubit.itemsList,
                      onChanged: (value) {
                        purchasesCubit.selectedItem = value;
                        purchasesCubit.getItemByID(
                            id: purchasesCubit.selectedItem.itemId!);
                        /*  purchasesCubit.selectItem(name: value); */
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
    return BlocConsumer<PurchasesCubit, PurchasesState>(
      bloc: purchasesCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: purchasesCubit.formKeyItems,
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
                          initialItem: purchasesCubit.selectedItem,
                          title: "الكود",
                          hintText: "اختيار الكود",
                          itemList: context.read<PurchasesCubit>().itemsList,
                          onChanged: (value) {
                            purchasesCubit.selectedItem = value;
                            purchasesCubit.getItemByID(
                                id: purchasesCubit.selectedItem.itemId!);
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
                          initialItem: purchasesCubit.selectedItem,
                          title: "الاسم",
                          hintText: "اختيار الاسم",
                          itemList: purchasesCubit.itemsList,
                          onChanged: (value) {
                            purchasesCubit.selectedItem = value;
                            purchasesCubit.getItemByID(
                                id: purchasesCubit.selectedItem.itemId!);
                            /*   purchasesCubit.getTaxByid(
                                id: purchasesCubit.selectedItem
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
                          itemList: purchasesCubit.selectedItem.itemUom!,
                          initialItem:
                              purchasesCubit.selectedItem.itemUom!.isNotEmpty
                                  ? purchasesCubit.selectedItem.itemUom!.first
                                  : null, // Handle empty list
                          onChanged: (value) {
                            purchasesCubit.selectedUom = value;
                            purchasesCubit.selectUom(
                                name: purchasesCubit.selectedUom!.uom!);
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
                    controller: ControllerManager().prUnitPriceController,
                    icon: Icons.phone_iphone,
                    focusNode: purchasesCubit.unitPriceFocusNode,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال سعر";
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      // Trigger the calculation when the user presses Enter
                      purchasesCubit
                          .doDiscountPercentage(purchasesCubit.selectedItem);
                      FocusScope.of(context)
                          .requestFocus(purchasesCubit.quantityFocusNode);
                      purchasesCubit.updateTotalQty();
                      /* purchasesCubit.updateQtyInclidingTaxes();
                             */
                    },
                    onTap: () {
                      ControllerManager().prUnitPriceController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .prUnitPriceController
                            .value
                            .text
                            .length,
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
                          focusNode: purchasesCubit.quantityFocusNode,
                          controller: ControllerManager().prQuantityController,
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
                            purchasesCubit.doDiscountPercentage(
                                purchasesCubit.selectedItem);
                            purchasesCubit.updateTotalQty();
                            FocusScope.of(context).requestFocus(
                                purchasesCubit.discountPFocusNode);

                            /* purchasesCubit.updateQtyInclidingTaxes();
                            purchasesCubit.updateTotalQty(); */
                          },
                          onTap: () {
                            ControllerManager().prQuantityController.selection =
                                TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .prQuantityController
                                  .value
                                  .text
                                  .length,
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: context
                                .read<PurchasesCubit>()
                                .settings
                                .supportsDimensionsBl ??
                            false,
                        child: Expanded(
                          child: BuildTextField(
                            label: "إجمالي الكمية",
                            readOnly: true,
                            hint: "إجمالي الكمية",
                            controller:
                                ControllerManager().prTotalQuantityController,
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            /*   validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "يجب ادخال الكميه";
                                                  }
                                                  return null;
                                                }, */
                            onTap: () {
                              ControllerManager()
                                  .prTotalQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .prTotalQuantityController
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
                              ControllerManager().prDiscountRateController,
                          focusNode: purchasesCubit.discountPFocusNode,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال النسبه";
                            }
                            return null;
                          }, */
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            purchasesCubit.doDiscountPercentage(
                                purchasesCubit.selectedItem);
                            FocusScope.of(context).requestFocus(
                                purchasesCubit.discountVFocusNode);
                            /*  if (purchasesCubit
                                    .selectedItem.calcBeforeDisc! ==
                                true) {
                              purchasesCubit
                                  .calcTaxesAfterDiscountIncludingTaxesFormRate();
                            } else {
                              purchasesCubit
                                  .calcTaxesBeforeDiscountIncludingTaxesFormRate();
                              /*  updatePriceAndDiscountsIncludingTaxesForValue(); */
                            } */
                          },
                          onTap: () {
                            ControllerManager()
                                .prDiscountRateController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .prDiscountRateController
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
                          focusNode: purchasesCubit.discountVFocusNode,
                          controller:
                              ControllerManager().prDiscountValueController,
                          icon: Icons.phone_iphone,
                          /* validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال قيمة";
                            }
                            return null;
                          }, */
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            purchasesCubit
                                .doDiscountValue(purchasesCubit.selectedItem);
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () {
                            ControllerManager()
                                .prDiscountValueController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .prDiscountValueController
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
                    controller: ControllerManager().prTotalTaxesController,
                    icon: Icons.phone_iphone,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                    onTap: () {
                      ControllerManager().prTotalTaxesController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .prTotalTaxesController
                            .value
                            .text
                            .length,
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
                          controller: ControllerManager().prPriceController,
                          icon: Icons.phone_iphone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال السعر";
                            }
                            return null;
                          },
                          onTap: () {
                            ControllerManager().prPriceController.selection =
                                TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .prPriceController
                                  .value
                                  .text
                                  .length,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: BuildTextField(
                          label: "الكميه المتاحه",
                          hint: "الكميه المتاحه",
                          readOnly: true,
                          controller:
                              ControllerManager().prAvailableQuantityController,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                          onTap: () {
                            ControllerManager()
                                .prAvailableQuantityController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .prAvailableQuantityController
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
                            .read<PurchasesCubit>()
                            .settings
                            .supportsBatchNumberBl ??
                        false,
                    child: BuildTextField(
                      label: "رقم التشغيليه",
                      hint: "رقم التشغيليه",
                      controller: ControllerManager()
                          .prInvoiceOperationNumberController,
                      icon: Icons.phone_iphone,
                      /*   validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "يجب ادخال الارتفاع";
                                        }
                                        return null;
                                      }, */
                      onTap: () {
                        ControllerManager()
                            .prInvoiceOperationNumberController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .prInvoiceOperationNumberController
                              .value
                              .text
                              .length,
                        );
                      },
                    ),
                  ),
                  BlocBuilder<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit,
                    builder: (context, state) {
                      return Visibility(
                        visible: context
                                .read<PurchasesCubit>()
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
                                        ControllerManager().prLengthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      ControllerManager()
                                          .prLengthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
                                            .prLengthController
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
                                        ControllerManager().prWidthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      ControllerManager()
                                          .prWidthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
                                            .prWidthController
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
                                  ControllerManager().prHeightController,
                              icon: Icons.phone_iphone,
                              /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                              onTap: () {
                                ControllerManager()
                                    .prHeightController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .prHeightController
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
                    controller: ControllerManager().salesTaxesNameController,
                    icon: Icons.phone_iphone,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                    onTap: () {
                      ControllerManager().salesTaxesNameController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
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
                    controller:
                        ControllerManager().prInvoiceDescriptionController,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                    onTap: () {
                      ControllerManager()
                          .prInvoiceDescriptionController
                          .selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .prInvoiceDescriptionController
                            .value
                            .text
                            .length,
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
                      purchasesCubit.saveSelectedItem();
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
    return BlocConsumer<PurchasesCubit, PurchasesState>(
      bloc: purchasesCubit,
      listener: (context, state) {},
      builder: (context, state) {
        while (state is EditPurchasesItemSuccess) {
          return Form(
            key: purchasesCubit.formKeyItems,
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
                            initialItem: purchasesCubit.itemsList.firstWhere(
                                (element) =>
                                    element.itemId == state.salesItemDm.itemId),
                            title: "الكود",
                            hintText: "اختيار الكود",
                            itemList: purchasesCubit.itemsList,
                            onChanged: (value) {
                              purchasesCubit.selectedItem = value;
                              purchasesCubit.getItemByID(
                                  id: purchasesCubit.selectedItem.itemId!);
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
                            initialItem: purchasesCubit.itemsList.firstWhere(
                                (element) =>
                                    element.itemId == state.salesItemDm.itemId),
                            title: "الاسم",
                            hintText: "اختيار الاسم",
                            itemList: purchasesCubit.itemsList,
                            onChanged: (value) {
                              purchasesCubit.selectedItem = value;
                              purchasesCubit.getItemByID(
                                  id: purchasesCubit.selectedItem.itemId!);
                              /*   purchasesCubit.getTaxByid(
                                id: purchasesCubit.selectedItem
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
                              purchasesCubit.selectedUom = value;
                              purchasesCubit.selectUom(
                                  name: purchasesCubit.selectedUom!.uom!);
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
                      focusNode: purchasesCubit.unitPriceFocusNode,
                      controller: ControllerManager().prUnitPriceController,
                      icon: Icons.phone_iphone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال سعر";
                        }
                        return null;
                      },
                      onEditingComplete: () {
                        // Trigger the calculation when the user presses Enter
                        purchasesCubit
                            .doDiscountPercentage(purchasesCubit.selectedItem);
                        FocusScope.of(context)
                            .requestFocus(purchasesCubit.quantityFocusNode);

                        /* purchasesCubit.updateQtyInclidingTaxes();
                            purchasesCubit.updateTotalQty(); */
                      },
                      onTap: () {
                        ControllerManager().prUnitPriceController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .prUnitPriceController
                              .value
                              .text
                              .length,
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
                            controller:
                                ControllerManager().prQuantityController,
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            focusNode: purchasesCubit.quantityFocusNode,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الكمية";
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              purchasesCubit.doDiscountPercentage(
                                  purchasesCubit.selectedItem);
                              FocusScope.of(context).requestFocus(
                                  purchasesCubit.discountPFocusNode);
                              purchasesCubit.updateTotalQty();

                              /* purchasesCubit.updateQtyInclidingTaxes();
                            purchasesCubit.updateTotalQty(); */
                            },
                            onTap: () {
                              ControllerManager()
                                  .prQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .prQuantityController
                                    .value
                                    .text
                                    .length,
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: context
                                  .read<PurchasesCubit>()
                                  .settings
                                  .supportsDimensionsBl ??
                              false,
                          child: Expanded(
                            child: BuildTextField(
                              label: "إجمالي الكمية",
                              readOnly: true,
                              hint: "إجمالي الكمية",
                              controller:
                                  ControllerManager().prTotalQuantityController,
                              icon: Icons.diversity_3_sharp,
                              keyboardType: TextInputType.number,
                              /*   validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "يجب ادخال الكميه";
                                                  }
                                                  return null;
                                                }, */
                              onTap: () {
                                ControllerManager()
                                    .prTotalQuantityController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .prTotalQuantityController
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
                            focusNode: purchasesCubit.discountPFocusNode,
                            keyboardType: TextInputType.number,
                            controller:
                                ControllerManager().prDiscountRateController,
                            icon: Icons.phone_iphone,
                            /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال النسبه";
                            }
                            return null;
                          }, */
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              purchasesCubit.doDiscountPercentage(
                                  purchasesCubit.selectedItem);
                              FocusScope.of(context).requestFocus(
                                  purchasesCubit.discountVFocusNode);
                              /*  if (purchasesCubit
                                    .selectedItem.calcBeforeDisc! ==
                                true) {
                              purchasesCubit
                                  .calcTaxesAfterDiscountIncludingTaxesFormRate();
                            } else {
                              purchasesCubit
                                  .calcTaxesBeforeDiscountIncludingTaxesFormRate();
                              /*  updatePriceAndDiscountsIncludingTaxesForValue(); */
                            } */
                            },
                            onTap: () {
                              ControllerManager()
                                  .prDiscountRateController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .prDiscountRateController
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
                            focusNode: purchasesCubit.discountVFocusNode,
                            keyboardType: TextInputType.number,
                            controller:
                                ControllerManager().prDiscountValueController,
                            icon: Icons.phone_iphone,
                            /* validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال قيمة";
                            }
                            return null;
                          }, */
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              purchasesCubit
                                  .doDiscountValue(purchasesCubit.selectedItem);
                              FocusScope.of(context).unfocus();
                            },
                            onTap: () {
                              ControllerManager()
                                  .prDiscountValueController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .prDiscountValueController
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
                      controller: ControllerManager().prTotalTaxesController,
                      icon: Icons.phone_iphone,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                      onTap: () {
                        ControllerManager().prTotalTaxesController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .prTotalTaxesController
                              .value
                              .text
                              .length,
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
                            controller: ControllerManager().prPriceController,
                            icon: Icons.phone_iphone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال السعر";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager().prPriceController.selection =
                                  TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .prPriceController
                                    .value
                                    .text
                                    .length,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: "الكميه المتاحه",
                            hint: "الكميه المتاحه",
                            readOnly: true,
                            controller: ControllerManager()
                                .prAvailableQuantityController,
                            icon: Icons.phone_iphone,
                            /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                            onTap: () {
                              ControllerManager()
                                  .prAvailableQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .prAvailableQuantityController
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
                    BuildTextField(
                      label: "رقم التشغيليه",
                      hint: "رقم التشغيليه",
                      controller: ControllerManager()
                          .prInvoiceOperationNumberController,
                      icon: Icons.phone_iphone,
                      /*   validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الارتفاع";
                      }
                      return null;
                    }, */
                      onTap: () {
                        ControllerManager()
                            .prInvoiceOperationNumberController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .prInvoiceOperationNumberController
                              .value
                              .text
                              .length,
                        );
                      },
                    ),
                    BlocBuilder<PurchasesCubit, PurchasesState>(
                      bloc: purchasesCubit,
                      builder: (context, state) {
                        return Visibility(
                          visible: context
                                  .read<PurchasesCubit>()
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
                                      controller: ControllerManager()
                                          .prLengthController,
                                      icon: Icons.phone_iphone,
                                      /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                      onTap: () {
                                        ControllerManager()
                                            .prLengthController
                                            .selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: ControllerManager()
                                              .prLengthController
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
                                          ControllerManager().prWidthController,
                                      icon: Icons.phone_iphone,
                                      /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                      onTap: () {
                                        ControllerManager()
                                            .prWidthController
                                            .selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: ControllerManager()
                                              .prWidthController
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
                                    ControllerManager().prHeightController,
                                icon: Icons.phone_iphone,
                                /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                                onTap: () {
                                  ControllerManager()
                                      .prHeightController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .prHeightController
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
                      controller: ControllerManager().salesTaxesNameController,
                      icon: Icons.phone_iphone,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                      onTap: () {
                        ControllerManager().salesTaxesNameController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
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
                      controller:
                          ControllerManager().prInvoiceDescriptionController,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                      onTap: () {
                        ControllerManager()
                            .prInvoiceDescriptionController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .prInvoiceDescriptionController
                              .value
                              .text
                              .length,
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
                        purchasesCubit.editSelectedItem(
                            purchasesCubit.indexOfEditableItem);
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
      header: const Text('بيانات الفاتورة',
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
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الفرع";
                          }
                          return null;
                        },
                        title: "الفرع",
                        hintText: "اختيار الفرع",
                        itemList: purchasesCubit.storeNamesList,
                        initialItem: purchasesCubit.storeNamesList.isNotEmpty
                            ? purchasesCubit.selectedStore.storeNameAr
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectStore(name: value);
                        },
                      );
                    },
                  )),
                ],
              ),
              /*   Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit..fetchCustomerData(skip: 0, take: 20),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectCustomerEntity(
                        /*   validator: (value) {
                          if (value == null) {
                            return "يجب ادخال العميل";
                          }
                          return null;
                        }, */
                        title: "العملاء",
                        hintText: "اختيار العميل",
                        itemList: purchasesCubit.customerData,
                        initialItem: purchasesCubit.customerData.isNotEmpty
                            ? purchasesCubit.selectedCustomer
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectedCustomer = value;
                        },
                      );
                    },
                  )),
                ],
              ), */
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectVendorEntity(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال المورد";
                          }
                          return null;
                        },
                        title: "الموردين",
                        hintText: "اختيار المورد",
                        itemList: purchasesCubit.vendorsList,
                        initialItem: purchasesCubit.vendorsList.isNotEmpty
                            ? purchasesCubit.vendorsList.firstWhere(
                                (element) =>
                                    element.id ==
                                    purchasesCubit.selectedCustomer.id,
                                orElse: () => purchasesCubit.vendorsList.first
                                    as VendorsDM,
                                /* context
                                                .read<PurchasesCubit>()
                                                .selectedCustomer
                                                .id, */
                              )
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectedVendor = value;
                        },
                      );
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit,
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
                        itemList: purchasesCubit.costCenterList,
                        initialItem: purchasesCubit.costCenterList.isNotEmpty
                            ? purchasesCubit.costCenterList.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectedCostCenter = value;
                        },
                      );
                    },
                  )),
                ],
              ),
              BuildTextField(
                label: "التاريخ",
                hint: "التاريخ ",
                controller: ControllerManager().purchaseInvoiceDateController,
                readOnly: true,
                icon: Icons.app_registration,
                color: AppColors.greyColor,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller:
                          ControllerManager().purchaseInvoiceDateController,
                      dateStorageMap: purchasesCubit.dateStorageMap,
                      key: "purchaseDateController");
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ ";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit..getCurrencyData(),
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
                        itemList: purchasesCubit.currencyList,
                        initialItem: purchasesCubit.currencyList.isNotEmpty
                            ? purchasesCubit.selectedCurrency
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectedCurrency = value;
                          context.read<PurchasesCubit>().updateRate();
                          /*   ControllerManager().prinvoiceRateController.text =
                              context
                                  .read<PurchasesCubit>()
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
                      controller: ControllerManager().prinvoiceRateController,
                      icon: Icons.diversity_3_sharp,
                      /*   validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "لا يمكن ترك الحقل فارغاً";
                        }
                        return null;
                      }, */
                      onTap: () {
                        ControllerManager().prinvoiceRateController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .prinvoiceRateController
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
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit /* ..fetchpaymentTypeList() */,
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
                        itemList: purchasesCubit.paymentTypes,
                        initialItem: purchasesCubit.paymentTypes.isNotEmpty
                            ? purchasesCubit.selectedPaymentType
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectedPaymentType = value;
                          purchasesCubit.changeDrawer(value);
                        },
                      );
                    },
                  )),
                ],
              ),
              BlocBuilder<PurchasesCubit, PurchasesState>(
                bloc: purchasesCubit,
                builder: (context, state) {
                  return Visibility(
                    visible: purchasesCubit.drawerIsShown,
                    child: Row(
                      children: [
                        Expanded(
                            child: BlocBuilder<PurchasesCubit, PurchasesState>(
                          bloc: purchasesCubit,
                          builder: (context, state) {
                            purchasesCubit.selectedDrawerEntity =
                                purchasesCubit.selectDrawer(
                                    purchasesCubit.drawerEntityList.first);
                            return SelectDrawerEntity(
                              /*   validator: (value) {
                                                                                  if (value == null) {
                                                                                    return "يجب ادخال الخزينه";
                                                                                  }
                                                                                  return null;
                                                                                }, */
                              title: "الخزينه",
                              hintText: "الخزينه",
                              itemList: purchasesCubit.drawerEntityList,
                              initialItem:
                                  purchasesCubit.drawerEntityList.isNotEmpty
                                      ? purchasesCubit.selectedDrawerEntity
                                      : purchasesCubit.drawerEntityList
                                          .first, // Handle empty list
                              onChanged: (value) {
                                purchasesCubit.selectedDrawerEntity = value;
                                purchasesCubit.selectedDrawerEntity =
                                    purchasesCubit.selectDrawer(value);
                                if (purchasesCubit.selectedPaymentType ==
                                    "كاش") {
                                  ControllerManager()
                                          .invoicePaidController
                                          .text =
                                      ControllerManager()
                                          .invoiceNetController
                                          .text;
                                }
                              },
                            );
                          },
                        )),
                      ],
                    ),
                  );
                },
              ),
              BuildTextField(
                label: "ملاحظات",
                hint: "ملاحظات",
                minLines: 1,
                maxLines: 5,
                controller: ControllerManager().prinvoiceNotesController,
                icon: Icons.phone_iphone,
                /*  validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال ملاحظات";
                  }
                  return null;
                }, */
                onTap: () {
                  ControllerManager().prinvoiceNotesController.selection =
                      TextSelection(
                    baseOffset: 0,
                    extentOffset: ControllerManager()
                        .prinvoiceNotesController
                        .value
                        .text
                        .length,
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
      isOpen: false,
      header: const Text('الفاتورة',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
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
            ),
            BlocConsumer<PurchasesCubit, PurchasesState>(
              bloc: purchasesCubit,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is GetInvoiceItemsSuccess ||
                    state is GetAllDatSuccess ||
                    state is AddPurchasesItemloading ||
                    state is SalesInvoiceLoading ||
                    state is getItemDataByIDSuccess ||
                    state is AddPurchasesItemSuccess ||
                    state is AddPurchasesRequestError ||
                    state is EditPurchasesItemSuccess) {
                  if (purchasesCubit.selectedItemsList.isEmpty) {
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
                      itemCount: purchasesCubit.selectedItemsList.length,
                      itemBuilder: (context, index) {
                        final request = purchasesCubit.selectedItemsList[index];
                        return Column(
                          children: [
                            BlocBuilder<PurchasesCubit, PurchasesState>(
                              bloc: purchasesCubit,
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
                            "لا يوجد فواتير",
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
    );
  }

  Widget buildItemCard(InvoiceItemDetailsDm request, int index) {
    return BlocBuilder<PurchasesCubit, PurchasesState>(
      bloc: purchasesCubit,
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
              SizedBox(
                width: 120.w,
                child: BlocBuilder<PurchasesCubit, PurchasesState>(
                  bloc: purchasesCubit,
                  builder: (context, state) {
                    return Text(
                      context
                              .read<PurchasesCubit>()
                              .itemsList
                              .firstWhere(
                                (element) =>
                                    element.itemId == request.itemNameAr,
                                orElse: () =>
                                    SalesItemDm(), // Return null if no matching element is found
                              )
                              ?.itemNameAr // Use safe navigation to prevent accessing properties on null
                              ?.toString() ??
                          '', // Fallback text if no item is found
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    );
                  },
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Text(
                " الكمية  : ",
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(),
              Text(
                request.qty!.toInt().toString(),
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
          children: [
            SwipeActionCell(
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
                  content: purchasesCubit.getIconButton(Colors.red, Icons.edit),
                  onTap: (handler) async {
                    purchasesCubit.indexOfEditableItem = index;
                    /*   purchasesCubit.editItem(
                        context: context,
                        selectedItemsList: purchasesCubit.selectedItemsList,
                        index: index);
                    purchasesCubit.swipeActionController.closeAllOpenCell(); */

                    /* purchasesCubit.removeItem(index); */
                    // Implement delete functionality
                  },
                ),
                SwipeAction(
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
                  content:
                      purchasesCubit.getIconButton(Colors.blue, Icons.delete),
                  onTap: (handler) async {
                    /* purchasesCubit.editItem(
                        selectedItemsList: purchasesCubit.selectedItemsList,
                        index: index); */
                    purchasesCubit.removeItem(index);
                    /*    purchasesCubit.swipeActionController.closeAllOpenCell(); */

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
                          BlocBuilder<PurchasesCubit, PurchasesState>(
                            bloc: purchasesCubit,
                            builder: (context, state) {
                              return buildDetailRow(
                                label: "اسم المنتج",
                                value: purchasesCubit.itemsList
                                    .firstWhere(
                                      (element) =>
                                          element.itemId == request.itemNameAr,
                                      orElse: () => SalesItemDm(itemNameAr: ""),
                                    )
                                    .itemNameAr
                                    .toString(),
                              );
                            },
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
                            value: purchasesCubit.uomlist
                                .firstWhere(
                                  (element) => element.uomId == request.uom,
                                  orElse: () => UomDataModel(),
                                )
                                .uom
                                .toString(),
                          ),
                          // Length

                          if (purchasesCubit.settings.supportsDimensionsBl ==
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
                          if (purchasesCubit.settings.supportsDimensionsBl ==
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
                          if (purchasesCubit.settings.supportsDimensionsBl ==
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
/*   Widget buildInvoicePrint(List<InvoiceItemDetailsDm> selectedItemsList) {
    return selectedItemsList.isNotEmpty
        ? ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            children: [
              // List of selected items
              ...selectedItemsList.map((item) {
                return Wrap(
                  spacing: 10.w,
                  runSpacing: 20.h,
                  children: [
                    // Product Name
                    buildDetailRow(
                      label: "اسم المنتج",
                      value: item.itemNameAr.toString(),
                    ),
                    // Quantity
                    Row(
                      children: [
                        Expanded(
                          child: buildDetailRow(
                            label: "الكمية",
                            value: "${item.qty}",
                          ),
                        ),
                      ],
                    ),
                    // UOM
                    buildDetailRow(
                      label: "وحدة القياس",
                      value: purchasesCubit.uomlist
                          .firstWhere((element) => element.uomId == item.uom)
                          .uom
                          .toString(),
                    ),
                    // Dimensions (Length, Width, Height)
                    if (purchasesCubit.settings.supportsDimensionsBl == true)
                      Row(
                        children: [
                          Expanded(
                            child: buildDetailRow(
                              label: "الطول",
                              value: "${item.length}",
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: buildDetailRow(
                              label: "العرض",
                              value: "${item.width}",
                            ),
                          ),
                        ],
                      ),
                    if (purchasesCubit.settings.supportsDimensionsBl == true)
                      Row(
                        children: [
                          buildDetailRow(
                            label: "الارتفاع",
                            value: "${item.height}",
                          ),
                        ],
                      ),
                    // Discount Percentage
                    buildDetailRow(
                      label: "قيمة الخصم",
                      value: "${item.precentagevalue}",
                    ),
                    buildDetailRow(
                      label: "إجمالي الضرائب",
                      value: "${item.alltaxesvalue}",
                    ),
                    // Price
                    buildDetailRow(
                      label: "السعر ",
                      value: "${item.prprice}",
                    ),
                    // Current Quantity
                    buildDetailRow(
                      label: "الكمية الحالية",
                      value: "${item.currentQty}",
                    ),
                    // Total Quantity Value
                    buildDetailRow(
                      label: "إجمالي الكمية",
                      value: "${item.allQtyValue}",
                    ),
                    // Total Taxes
                  ],
                );
              }).toList(),

              // Divider to separate the item list from total values
              Divider(
                thickness: 2,
                color: Colors.black,
              ),

              // Total Price
              buildDetailRow(
                label: "إجمالي السعر",
                value: ControllerManager().prinvoiceTotalPriceController.text,
              ),

              // Total Taxes
              buildDetailRow(
                label: "إجمالي الضرائب",
                value: ControllerManager().prinvoiceTotalTaxesController.text,
              ),

              // Paid Amount
              buildDetailRow(
                label: "المبلغ المدفوع",
                value: ControllerManager().prinvoiceNetController.text,
              ),
            ],
          )
        : Container();
  }
 */
}
