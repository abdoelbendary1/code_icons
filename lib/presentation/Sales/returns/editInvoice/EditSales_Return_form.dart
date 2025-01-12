import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:code_icons/presentation/Sales/Invoice/cubit/SalesInvoiceCubit_cubit.dart';
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

class EditSalesReturnForm extends StatefulWidget {
  const EditSalesReturnForm({super.key});

  @override
  State<EditSalesReturnForm> createState() => _EditSalesReturnFormState();
}

class _EditSalesReturnFormState extends State<EditSalesReturnForm> {
  SalesInvoiceCubit salesInvoiceCubit = SalesInvoiceCubit();
  StatefulWidget? myInheritedWidget;

  @override
  void initState() {
    super.initState();
    PdfGenerator.init();
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
    /*  ControllerManager()
        .salesQuantityController
        .addListener(salesInvoiceCubit.updatePriceAndDiscountsIncludingTaxes); */
    /*   ControllerManager()
        .clearControllers(controllers: ControllerManager().salesControllers); */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        /*  ControllerManager().invoiceDateController.text =
            DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());
        ControllerManager().invoiceReceiveDateController.text =
            DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());
        ControllerManager().invoiceDueDateController.text =
            DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now()); */
        ControllerManager().clearControllers(
            controllers: ControllerManager().salesControllers);
        ControllerManager().clearControllers(
            controllers: ControllerManager().invoiceControllers);
      }
    });
    salesInvoiceCubit.fetchCustomerData(skip: 0, take: 2);

    Future.delayed(const Duration(seconds: 1));
  }

  final formKeyItems = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var invoiceId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) =>
          salesInvoiceCubit..fetchSalesReturnDataByID(id: invoiceId),
      child: Form(
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
              BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                bloc: salesInvoiceCubit,
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
                                    .invoiceTotalPriceController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () {
                                  ControllerManager()
                                      .invoiceTotalPriceController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
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
                                controller: ControllerManager()
                                    .invoiceTotalTaxesController,
                                /*  validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                }, */
                                readOnly: true,
                                onTap: () {
                                  ControllerManager()
                                      .invoiceTotalTaxesController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
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
                                  salesInvoiceCubit.updatePriceFromPercentage();
                                },
                                keyboardType: TextInputType.number,
                                controller: ControllerManager()
                                    .invoiceDiscountPercentageController,
                                /*  validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                }, */
                                onTap: () {
                                  ControllerManager()
                                      .invoiceDiscountPercentageController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
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
                                focusNode:
                                    salesInvoiceCubit.invoiceDiscountVFocusNode,
                                keyboardType: TextInputType.number,
                                controller: ControllerManager()
                                    .invoiceDiscountValueController,
                                /*    validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                }, */
                                onEditingComplete: () {
                                  // Trigger the calculation when the user presses Enter
                                  salesInvoiceCubit.updatePriceFromValue();
                                },
                                onTap: () {
                                  ControllerManager()
                                      .invoiceDiscountValueController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
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
                                    ControllerManager().invoicePaidController,
                                onTap: () {
                                  ControllerManager()
                                      .invoicePaidController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .invoicePaidController
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
                                    ControllerManager().invoiceNetController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "لا يمكن ترك الحقل فارغاً";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  ControllerManager()
                                      .invoiceNetController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
                                        .invoiceNetController
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
                      salesInvoiceCubit.updateSalesReturnReport(
                          context: context, id: invoiceId);
                    },
                  ),
                  buildSaveButton(
                    mainAxisAlignment: MainAxisAlignment.end,
                    title: "طباعه",
                    context: context,
                    onPressed: () async {
/*                       buildInvoicePrint(salesInvoiceCubit.selectedItemsList);
 */
                      salesInvoiceCubit.getInvoicePrint(
                          id: invoiceId.toString(), context: context);
                      /*   PdfGenerator.createPdf(
                          salesInvoiceCubit: salesInvoiceCubit,
                          selectedItemsList:
                              salesInvoiceCubit.selectedItemsList); */
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
      header: const Text('تفاصيل المردود',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
        bloc: salesInvoiceCubit..getStoreData(),
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
              state is AddPurchasesItemSuccess ||
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
              QuickAlert.show(
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
                        itemList: context.read<SalesInvoiceCubit>().itemsList,
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
                      itemList: context.read<SalesInvoiceCubit>().itemsList,
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
                          itemList: context.read<SalesInvoiceCubit>().itemsList,
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
                    controller: ControllerManager().salesUnitPriceController,
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
                      salesInvoiceCubit.updateTotalQty();
                      /* salesInvoiceCubit.updateQtyInclidingTaxes();
                             */
                    },
                    onTap: () {
                      ControllerManager().salesUnitPriceController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .salesUnitPriceController
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
                          focusNode: salesInvoiceCubit.quantityFocusNode,
                          controller:
                              ControllerManager().salesQuantityController,
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
                            FocusScope.of(context).requestFocus(
                                salesInvoiceCubit.discountPFocusNode);

                            /* salesInvoiceCubit.updateQtyInclidingTaxes();
                            salesInvoiceCubit.updateTotalQty(); */
                          },
                          onTap: () {
                            ControllerManager()
                                .salesQuantityController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .salesQuantityController
                                  .value
                                  .text
                                  .length,
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
                            controller: ControllerManager()
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
                              ControllerManager()
                                  .salesTotalQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
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
                              ControllerManager().salesDiscountRateController,
                          focusNode: salesInvoiceCubit.discountPFocusNode,
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
                            ControllerManager()
                                .salesDiscountRateController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
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
                          focusNode: salesInvoiceCubit.discountVFocusNode,
                          controller:
                              ControllerManager().salesDiscountValueController,
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
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () {
                            ControllerManager()
                                .salesDiscountValueController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
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
                    controller: ControllerManager().salesTotalTaxesController,
                    icon: Icons.phone_iphone,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                    onTap: () {
                      ControllerManager().salesTotalTaxesController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .salesTotalTaxesController
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
                          controller: ControllerManager().salesPriceController,
                          icon: Icons.phone_iphone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال السعر";
                            }
                            return null;
                          },
                          onTap: () {
                            ControllerManager().salesPriceController.selection =
                                TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .salesPriceController
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
                              .salesAvailableQuantityController,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                          onTap: () {
                            ControllerManager()
                                .salesAvailableQuantityController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
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
                          ControllerManager().salesOperationNumberController,
                      icon: Icons.phone_iphone,
                      /*   validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "يجب ادخال الارتفاع";
                                        }
                                        return null;
                                      }, */
                      onTap: () {
                        ControllerManager()
                            .salesOperationNumberController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
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
                                    controller: ControllerManager()
                                        .salesLengthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      ControllerManager()
                                          .salesLengthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
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
                                    controller: ControllerManager()
                                        .salesWidthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      ControllerManager()
                                          .salesWidthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
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
                                  ControllerManager().salesHeightController,
                              icon: Icons.phone_iphone,
                              /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                              onTap: () {
                                ControllerManager()
                                    .salesHeightController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
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
                    controller: ControllerManager().salesDescriptionController,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                    onTap: () {
                      ControllerManager().salesDescriptionController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .salesDescriptionController
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
                      focusNode: salesInvoiceCubit.unitPriceFocusNode,
                      controller: ControllerManager().salesUnitPriceController,
                      icon: Icons.phone_iphone,
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
                        FocusScope.of(context)
                            .requestFocus(salesInvoiceCubit.quantityFocusNode);

                        /* salesInvoiceCubit.updateQtyInclidingTaxes();
                            salesInvoiceCubit.updateTotalQty(); */
                      },
                      onTap: () {
                        ControllerManager().salesUnitPriceController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .salesUnitPriceController
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
                                ControllerManager().salesQuantityController,
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            focusNode: salesInvoiceCubit.quantityFocusNode,
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
                              ControllerManager()
                                  .salesQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .salesQuantityController
                                    .value
                                    .text
                                    .length,
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
                              controller: ControllerManager()
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
                                ControllerManager()
                                    .salesTotalQuantityController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
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
                            focusNode: salesInvoiceCubit.discountPFocusNode,
                            keyboardType: TextInputType.number,
                            controller:
                                ControllerManager().salesDiscountRateController,
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
                              ControllerManager()
                                  .salesDiscountRateController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
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
                            controller: ControllerManager()
                                .salesDiscountValueController,
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
                              FocusScope.of(context).unfocus();
                            },
                            onTap: () {
                              ControllerManager()
                                  .salesDiscountValueController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
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
                      controller: ControllerManager().salesTotalTaxesController,
                      icon: Icons.phone_iphone,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                      onTap: () {
                        ControllerManager()
                            .salesTotalTaxesController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .salesTotalTaxesController
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
                            controller:
                                ControllerManager().salesPriceController,
                            icon: Icons.phone_iphone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال السعر";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                  .salesPriceController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .salesPriceController
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
                                .salesAvailableQuantityController,
                            icon: Icons.phone_iphone,
                            /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                            onTap: () {
                              ControllerManager()
                                  .salesAvailableQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
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
                            ControllerManager().salesOperationNumberController,
                        icon: Icons.phone_iphone,
                        /*   validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "يجب ادخال الارتفاع";
                                          }
                                          return null;
                                        }, */
                        onTap: () {
                          ControllerManager()
                              .salesOperationNumberController
                              .selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
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
                                      controller: ControllerManager()
                                          .salesLengthController,
                                      icon: Icons.phone_iphone,
                                      /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                      onTap: () {
                                        ControllerManager()
                                            .salesLengthController
                                            .selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: ControllerManager()
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
                                      controller: ControllerManager()
                                          .salesWidthController,
                                      icon: Icons.phone_iphone,
                                      /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                      onTap: () {
                                        ControllerManager()
                                            .salesWidthController
                                            .selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: ControllerManager()
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
                                    ControllerManager().salesHeightController,
                                icon: Icons.phone_iphone,
                                /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                                onTap: () {
                                  ControllerManager()
                                      .salesHeightController
                                      .selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: ControllerManager()
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
                          ControllerManager().salesDescriptionController,
                      /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                      onTap: () {
                        ControllerManager()
                            .salesDescriptionController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .salesDescriptionController
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
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الفرع";
                          }
                          return null;
                        },
                        title: "الفرع",
                        hintText: "اختيار الفرع",
                        itemList: salesInvoiceCubit.storeNamesList,
                        initialItem: salesInvoiceCubit.storeNamesList.isNotEmpty
                            ? salesInvoiceCubit.selectedStore.storeNameAr
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
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit
                      ..fetchCustomerData(skip: 0, take: 20),
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
                        itemList: salesInvoiceCubit.customerData,
                        initialItem: salesInvoiceCubit.customerData.isNotEmpty
                            ? salesInvoiceCubit.selectedCustomer
                            : null, // Handle empty list
                        onChanged: (value) {
                          salesInvoiceCubit.selectedCustomer = value;
                        },
                      );
                    },
                  )),
                ],
              ),
              BuildTextField(
                label: "التاريخ",
                hint: "التاريخ ",
                controller: ControllerManager().invoiceDateController,
                readOnly: true,
                icon: Icons.app_registration,
                color: AppColors.greyColor,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller: ControllerManager().invoiceDateController,
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
              /*         BuildTextField(
                label: "تاريخ الاستلام",
                hint: "التاريخ ",
                color: AppColors.greyColor,
                controller: ControllerManager().invoiceReceiveDateController,
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller:
                          ControllerManager().invoiceReceiveDateController,
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
                controller: ControllerManager().invoiceDueDateController,
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller: ControllerManager().invoiceDueDateController,
                      dateStorageMap: salesInvoiceCubit.dateStorageMap,
                      key: "purchaseDateController");
                },
                /*   validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ ";
                  }
                  return null;
                }, */
              ),
             */
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
                            ? salesInvoiceCubit.selectedCurrency
                            : null, // Handle empty list
                        onChanged: (value) {
                          salesInvoiceCubit.selectedCurrency = value;
                          context.read<SalesInvoiceCubit>().updateRate();
                          /*   ControllerManager().invoiceRateController.text =
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
                      controller: ControllerManager().invoiceRateController,
                      icon: Icons.diversity_3_sharp,
                      /*   validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "لا يمكن ترك الحقل فارغاً";
                        }
                        return null;
                      }, */
                      onTap: () {
                        ControllerManager().invoiceRateController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .invoiceRateController
                              .value
                              .text
                              .length,
                        );
                      },
                    ),
                  ),
                ],
              ),
              /*   Row(
                children: [
                  Expanded(
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit /* ..fetchpaymentTypeList() */,
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
                            ? salesInvoiceCubit.selectedPaymentType
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
                            salesInvoiceCubit.selectedDrawerEntity =
                                salesInvoiceCubit.selectDrawer(DrawerDm(id: 1));
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
                                      ? salesInvoiceCubit.selectedDrawerEntity
                                      : null, // Handle empty list
                              onChanged: (value) {
                                salesInvoiceCubit.selectedDrawerEntity = value;
                                salesInvoiceCubit.selectedDrawerEntity =
                                    salesInvoiceCubit.selectDrawer(value);
                                if (salesInvoiceCubit.selectedPaymentType ==
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
               */
              BuildTextField(
                label: "ملاحظات",
                hint: "ملاحظات",
                minLines: 1,
                maxLines: 5,
                controller: ControllerManager().invoiceNotesController,
                icon: Icons.phone_iphone,
                /*  validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال ملاحظات";
                  }
                  return null;
                }, */
                onTap: () {
                  ControllerManager().invoiceNotesController.selection =
                      TextSelection(
                    baseOffset: 0,
                    extentOffset: ControllerManager()
                        .invoiceNotesController
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
                    "تفاصيل المردودات",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.greyColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
              bloc: salesInvoiceCubit,
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
                    state is EditPurchasesItemSuccess ||
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
              SizedBox(
                width: 120.w,
                child: BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                  bloc: salesInvoiceCubit,
                  builder: (context, state) {
                    return Text(
                      context
                              .read<SalesInvoiceCubit>()
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
                  content:
                      salesInvoiceCubit.getIconButton(Colors.red, Icons.edit),
                  onTap: (handler) async {
                    salesInvoiceCubit.indexOfEditableItem = index;
                    salesInvoiceCubit.editItem(
                        context: context,
                        selectedItemsList: salesInvoiceCubit.selectedItemsList,
                        index: index);
                    salesInvoiceCubit.swipeActionController.closeAllOpenCell();

                    /* salesInvoiceCubit.removeItem(index); */
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
                  content: salesInvoiceCubit.getIconButton(
                      Colors.blue, Icons.delete),
                  onTap: (handler) async {
                    /* salesInvoiceCubit.editItem(
                        selectedItemsList: salesInvoiceCubit.selectedItemsList,
                        index: index); */
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
                          BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                            bloc: salesInvoiceCubit,
                            builder: (context, state) {
                              return buildDetailRow(
                                label: "اسم المنتج",
                                value: salesInvoiceCubit.itemsList
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
                            value: salesInvoiceCubit.uomlist
                                .firstWhere(
                                  (element) => element.uomId == request.uom,
                                  orElse: () => UomDataModel(),
                                )
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
                      value: salesInvoiceCubit.uomlist
                          .firstWhere((element) => element.uomId == item.uom)
                          .uom
                          .toString(),
                    ),
                    // Dimensions (Length, Width, Height)
                    if (salesInvoiceCubit.settings.supportsDimensionsBl == true)
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
                    if (salesInvoiceCubit.settings.supportsDimensionsBl == true)
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
                value: ControllerManager().invoiceTotalPriceController.text,
              ),

              // Total Taxes
              buildDetailRow(
                label: "إجمالي الضرائب",
                value: ControllerManager().invoiceTotalTaxesController.text,
              ),

              // Paid Amount
              buildDetailRow(
                label: "المبلغ المدفوع",
                value: ControllerManager().invoiceNetController.text,
              ),
            ],
          )
        : Container();
  }
 */
}
