import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/vendors/vendors_dm.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/editInvoice/EditPRInvoice.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectVendorEntity.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectCostCenter.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectCurrency.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemCode.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemName.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectUOM.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectdrawerentity.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectableDropDownlist.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_state.dart';
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

class PurchaseInvoiceForm extends StatefulWidget {
  const PurchaseInvoiceForm({super.key});

  @override
  State<PurchaseInvoiceForm> createState() => _PurchaseInvoiceFormState();
}

class _PurchaseInvoiceFormState extends State<PurchaseInvoiceForm> {
  PurchasesCubit purchasesCubit = PurchasesCubit();
  StatefulWidget? myInheritedWidget;
  ControllerManager controllerManager = ControllerManager();

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
    ControllerManager().clearControllers(
        controllers: ControllerManager().purchaseRequestControllers);
    /* ControllerManager().clearControllers(
        controllers: ControllerManager().recietCollectionController);
    PurchasesCubit.petLastReciet(); */
    /* purchasesCubit.selectedItem = PurchaseItemEntity(); */
    purchasesCubit.fetchProductInfoDatalists();

    purchasesCubit.getItemsData();
    purchasesCubit.fetchUom();
    purchasesCubit.fetchVendors();
    purchasesCubit.getCurrencyData();
    purchasesCubit.loadSysSettings();
    purchasesCubit.getCostCenterData();
    purchasesCubit.getDrawerData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        /* controllerManager.clearControllers(
            controllers: controllerManager.salesControllers); */
        controllerManager.clearControllers(
            controllers: controllerManager.prControllers);
        /*  controllerManager.clearControllers(
            controllers: controllerManager.invoiceControllers); */
      }
    });

    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
              maxOpenSections: 1,
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
              bloc: purchasesCubit..updateDateControllers(),
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
                              controller: controllerManager
                                  .prinvoiceTotalPriceController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: () {
                                controllerManager.prinvoiceTotalPriceController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .prinvoiceTotalPriceController
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
                              controller: controllerManager
                                  .prinvoiceTotalTaxesController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: () {
                                controllerManager.prinvoiceTotalTaxesController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .prinvoiceTotalTaxesController
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
                                  purchasesCubit.invoiceDiscountPFocusNode,
                              onEditingComplete: () {
                                // Trigger the calculation when the user presses Enter
                                /*   purchasesCubit
                                    .updateDiscountFromPercentage(); */
                                purchasesCubit.updatePriceFromPercentage();
                              },
                              keyboardType: TextInputType.number,
                              controller: controllerManager
                                  .prinvoiceDiscountPercentageController,
                              /*  validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              }, */
                              onTap: () {
                                controllerManager
                                    .prinvoiceDiscountPercentageController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
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
                              keyboardType: TextInputType.number,
                              focusNode:
                                  purchasesCubit.invoiceDiscountVFocusNode,
                              controller: controllerManager
                                  .prinvoiceDiscountValueController,
                              /*    validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              }, */
                              onEditingComplete: () {
                                // Trigger the calculation when the user presses Enter
                                /*  purchasesCubit.updateDiscountFromValue(); */
                                purchasesCubit.updatePriceFromValue();
                              },
                              onTap: () {
                                controllerManager
                                    .prinvoiceDiscountValueController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
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
                                  controllerManager.prinvoicePaidController,
                              onTap: () {
                                controllerManager.prinvoicePaidController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
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
                                  controllerManager.prinvoiceNetController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "لا يمكن ترك الحقل فارغاً";
                                }
                                return null;
                              },
                              onTap: () {
                                controllerManager.prinvoiceNetController
                                    .selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .prinvoiceNetController.value.text.length,
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
            SizedBox(height: 10.h),
            buildSaveButton(
              mainAxisAlignment: MainAxisAlignment.end,
              title: AppLocalizations.of(context)!.save,
              context: context,
              onPressed: () async {
                purchasesCubit.postSalesReport(context: context);
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  /*  AccordionSection buildItemInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "2",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
      header: const Text('بيانات المنتج',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BlocConsumer<PurchasesCubit, PurchasesState>(
        bloc: purchasesCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddPurchasesItemloading ||
              state is PurchasesItemSelected) {
            return buildProductInfoWhileSelecting(context);
          } else if (state is PurchasesInitial) {
            return buildAddFirstProduct(context);
          } else if (state is AddPurchasesItemSuccess) {
            return buildItemsListWithAddition(context);
          } else if (state is AddPurchasesItemError) {
            return LoadingStateAnimation();
          }
          return Container();
        },
      ),
    );
  }
 */
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
        bloc: purchasesCubit,
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
          } else if (state is AddPurchasesItemSuccess ||
              state is AddPurchasesRequestError ||
              state is PurchasesInitial ||
              state is AddPurchasesItemloading ||
              state is SalesInvoiceLoading ||
              state is FetchCustomersSuccess ||
              state is GetAllDatSuccess ||
              state is AddSalesCustomerSuccess ||
              state is GetAllDatSuccess) {
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
                    controller: controllerManager.prUnitPriceController,
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
                    },
                    onTap: () {
                      controllerManager.prUnitPriceController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .prUnitPriceController.value.text.length,
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
                          controller: controllerManager.prQuantityController,
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
                            /*   purchasesCubit.doDiscountPercentage(
                                purchasesCubit.selectedItem); */
                            purchasesCubit.doDiscountPercentage(
                                purchasesCubit.selectedItem);
                            FocusScope.of(context).requestFocus(
                                purchasesCubit.discountPFocusNode);
                            purchasesCubit.updateTotalQty();
                          },
                          onTap: () {
                            controllerManager.prQuantityController.selection =
                                TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .prQuantityController.value.text.length,
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
                                controllerManager.prTotalQuantityController,
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            /*   validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "يجب ادخال الكميه";
                                                  }
                                                  return null;
                                                }, */
                            onTap: () {
                              controllerManager.prTotalQuantityController
                                  .selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerManager
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
                          focusNode: purchasesCubit.discountPFocusNode,
                          controller:
                              controllerManager.prDiscountRateController,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال النسبه";
                            }
                            return null;
                          }, */
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            /*  purchasesCubit.doDiscountPercentage(
                                purchasesCubit.selectedItem); */
                            purchasesCubit.doDiscountPercentage(
                                purchasesCubit.selectedItem);
                            FocusScope.of(context).requestFocus(
                                purchasesCubit.discountVFocusNode);
                          },
                          onTap: () {
                            controllerManager.prDiscountRateController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .prDiscountRateController.value.text.length,
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
                              controllerManager.prDiscountValueController,
                          icon: Icons.phone_iphone,
                          focusNode: purchasesCubit.discountVFocusNode,

                          /* validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال قيمة";
                            }
                            return null;
                          }, */
                          onEditingComplete: () {
                            // Trigger the calculation when the user presses Enter
                            /*     purchasesCubit.doDiscountValue(
                                purchasesCubit.selectedItem); */
                            purchasesCubit
                                .doDiscountValue(purchasesCubit.selectedItem);
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () {
                            controllerManager.prDiscountValueController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .prDiscountValueController.value.text.length,
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
                    controller: controllerManager.prTotalTaxesController,
                    icon: Icons.phone_iphone,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال إجمالى";
                      }
                      return null;
                    }, */
                    onTap: () {
                      controllerManager.prTotalTaxesController.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .prTotalTaxesController.value.text.length,
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
                          controller: controllerManager.prPriceController,
                          icon: Icons.phone_iphone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال السعر";
                            }
                            return null;
                          },
                          onTap: () {
                            controllerManager.prPriceController.selection =
                                TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
                                  .prPriceController.value.text.length,
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
                              controllerManager.prAvailableQuantityController,
                          icon: Icons.phone_iphone,
                          /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال الكميه";
                            }
                            return null;
                          }, */
                          onTap: () {
                            controllerManager.prAvailableQuantityController
                                .selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: controllerManager
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
                      controller:
                          controllerManager.prInvoiceOperationNumberController,
                      icon: Icons.phone_iphone,
                      /*   validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "يجب ادخال الارتفاع";
                                        }
                                        return null;
                                      }, */
                      onTap: () {
                        controllerManager.prInvoiceOperationNumberController
                            .selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
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
                                        controllerManager.prLengthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال الطول";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      controllerManager.prLengthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: controllerManager
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
                                        controllerManager.prWidthController,
                                    icon: Icons.phone_iphone,
                                    /*  validator: (value) {
                                                                    if (value == null || value.trim().isEmpty) {
                                                                      return "يجب ادخال العرض";
                                                                    }
                                                                    return null;
                                                                  }, */
                                    onTap: () {
                                      controllerManager.prWidthController
                                          .selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset: controllerManager
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
                              controller: controllerManager.prHeightController,
                              icon: Icons.phone_iphone,
                              /*  validator: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "يجب ادخال الارتفاع";
                                                          }
                                                          return null;
                                                        }, */
                              onTap: () {
                                controllerManager.prHeightController.selection =
                                    TextSelection(
                                  baseOffset: 0,
                                  extentOffset: controllerManager
                                      .prHeightController.value.text.length,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  BuildTextField(
                    label: "الوصف",
                    hint: "الوصف",
                    minLines: 3,
                    controller:
                        controllerManager.prInvoiceDescriptionController,
                    /*  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الوصف";
                      }
                      return null;
                    }, */
                    onTap: () {
                      controllerManager.prInvoiceDescriptionController
                          .selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .prInvoiceDescriptionController.value.text.length,
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
            if (state is AddPurchasesInvoiceSuccess) {
              DialogUtils.hideLoading(context);

              DialogUtils.hideLoading(context);
              Navigator.popAndPushNamed(context, EditPRInvoice.routeName,
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
              purchasesCubit.addItem();
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
                        itemList: purchasesCubit.itemsList,
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
                      itemList: purchasesCubit.itemsList,
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

  AccordionSection buildInvoiceInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "1",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
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
                        /*    validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الفرع";
                          }
                          return null;
                        }, */
                        title: "الفرع",
                        hintText: "اختيار الفرع",
                        itemList: purchasesCubit.storeNamesList,
                        initialItem: purchasesCubit.storeNamesList.isNotEmpty
                            ? purchasesCubit.storeNamesList.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectStore(name: value);
                        },
                      );
                    },
                  )),
                ],
              ),
              /*       Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                        bloc: purchasesCubit
                          ..fetchCustomerData(skip: 0, take: 20),
                        listener: (context, state) {
                          if (state is AddSalesCustomerLoading) {
                            DialogUtils.showLoading(
                                context: context, message: "message");
                          }
                        },
                        builder: (context, state) {
                          if (state is AddSalesCustomerSuccess) {
                            print(
                                "purchasesCubit.selectedCustomer.cusNameAr : ${purchasesCubit.selectedCustomer.cusNameAr}");
                            print(purchasesCubit.selectedCustomer.id);
                            return SelectCustomerEntity(
                              title: "العملاء",
                              hintText: "اختيار العميل",
                              itemList: purchasesCubit.customerData,
                              initialItem:
                                  state.customerEntity, // Handle empty list
                              onChanged: (value) {
                                purchasesCubit.selectedCustomer = value;
                              },
                            );
                          } else {
                            print(
                                "purchasesCubit.selectedCustomer.cusNameAr : ${purchasesCubit.selectedCustomer.cusNameAr}");
                            print(purchasesCubit.selectedCustomer.id);

                            return SelectCustomerEntity(
                              title: "العملاء",
                              hintText: "اختيار العميل",
                              itemList: purchasesCubit.customerData,
                              initialItem: purchasesCubit
                                      .customerData.isNotEmpty
                                  ? purchasesCubit.customerData.firstWhere(
                                      (element) =>
                                          element.id ==
                                          purchasesCubit.selectedCustomer.id,
                                      orElse: () => purchasesCubit.customerData
                                          .first as InvoiceCustomerDm,
                                      /* context
                                                .read<PurchasesCubit>()
                                                .selectedCustomer
                                                .id, */
                                    )
                                  : null, // Handle empty list
                              onChanged: (value) {
                                purchasesCubit.selectedCustomer = value;
                              },
                            );
                          }
                        },
                      )),
                  Expanded(
                      flex: 2,
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                        bloc: purchasesCubit,
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
                                  controllerManager
                                      .invoiceAddCustomerNameController
                                      .clear();
                                  controllerManager
                                      .invoiceAddCustomerCountryController
                                      .clear();
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
                                              /* CountryDropdown(
                                                countries: purchasesCubit
                                                    .listOfCountries(),
                                                purchasesCubit:
                                                    purchasesCubit,
                                              ), */

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
                                                      countryId: purchasesCubit
                                                          .countryCode,
                                                    );
                                                    purchasesCubit.addCustomer(
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
               */
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
              BlocBuilder<PurchasesCubit, PurchasesState>(
                bloc: purchasesCubit,
                builder: (context, state) {
                  return BuildTextField(
                    label: "التاريخ",
                    hint: "التاريخ ",
                    controller: controllerManager.purchaseInvoiceDateController,
                    readOnly: true,
                    icon: Icons.app_registration,
                    onTap: () {
                      AppDatePicker.selectDate(
                          context: context,
                          controller:
                              controllerManager.purchaseInvoiceDateController,
                          dateStorageMap: purchasesCubit.dateStorageMap,
                          key: "purchaseDateController");
                    },
                    /* validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال تاريخ ";
                      }
                      return null;
                    }, */
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        /*  validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الاعتماد";
                          }
                          return null;
                        }, */
                        title: "الاعتماد المستندي",
                        hintText: "اختيار",
                        itemList: [],
                        onChanged: (value) {
                          purchasesCubit.selectedStatus = value;
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
                      return SelectCurrencyEntity(
                        /*  validator: (value) {
                          if (value == null) {
                            return "يجب ادخال العمله";
                          }
                          return null;
                        }, */
                        title: "العمله",
                        hintText: "اختيار",
                        itemList: purchasesCubit.currencyList,
                        initialItem: purchasesCubit.currencyList.isNotEmpty
                            ? purchasesCubit.currencyList.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          purchasesCubit.selectedCurrency = value;
                          purchasesCubit.updateRate();
                          /*   controllerManager.invoiceRateController.text =
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
                      controller: controllerManager.purchaseCurRateController,
                      icon: Icons.diversity_3_sharp,
                      onTap: () {
                        /*    controllerManager.purchaseCurRateController.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .purchaseCurRateController.value.text.length,
                        ); */
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit..fetchpaymentTypeList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        /*  validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال طبيعه الدفع";
                          }
                          return null;
                        }, */
                        title: "طبيعة الدفع",
                        hintText: "طبيعه الدفع",
                        itemList: purchasesCubit.paymentTypes,
                        initialItem: purchasesCubit.paymentTypes.isNotEmpty
                            ? purchasesCubit.paymentTypes.first
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
                                      ? purchasesCubit.drawerEntityList.first
                                      : null, // Handle empty list
                              onChanged: (value) {
                                purchasesCubit.selectedDrawerEntity = value;
                              },
                            );
                          },
                        )),
                      ],
                    ),
                  );
                },
              ),

              /*   SizedBox(
                height: 20.h,
              ), */
              /*  SizedBox(
                height: 20.h,
              ), */
              BuildTextField(
                  label: "ملاحظات",
                  hint: "ملاحظات",
                  minLines: 1,
                  maxLines: 5,
                  controller: ControllerManager()
                      .getControllerByName('purchaseNotesController'),
                  icon: Icons.phone_iphone,
                  /*    validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال ملاحظات";
                    }
                    return null;
                  }, */
                  onTap: () {
                    ControllerManager()
                            .getControllerByName('purchaseNotesController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName('purchaseNotesController')
                                .value
                                .text
                                .length);
                  }),
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
                  "تفاصيل المشتريات",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            BlocConsumer<PurchasesCubit, PurchasesState>(
              bloc: purchasesCubit,
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
                    state is GetAllDatSuccess) {
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
      ),
      /* Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<PurchasesCubit, PurchasesState>(
            bloc: PurchasesCubit,
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
              Text(
                purchasesCubit.itemsList
                    .firstWhere(
                        (element) => element.itemId == request.itemNameAr)
                    .itemNameAr
                    .toString(),
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    overflow: TextOverflow.ellipsis),
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
              Text(
                request.qty!.toInt().toString(),
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              /*  Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "في الانتظار",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ), */
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
                    purchasesCubit.editItem(
                        context: context,
                        selectedItemsList: purchasesCubit.selectedItemsList,
                        index: index);
                    /* purchasesCubit.removeItem(index); */
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
                  content:
                      purchasesCubit.getIconButton(Colors.blue, Icons.delete),
                  onTap: (handler) async {
                    /* purchasesCubit.editItem(
                        selectedItemsList: purchasesCubit.selectedItemsList,
                        index: index); */
                    purchasesCubit.removeItem(index);
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
                            value: purchasesCubit.itemsList
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
                            value: purchasesCubit.uomlist
                                .firstWhere(
                                    (element) => element.uomId == request.uom)
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
                            value: "${request.prprice}",
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
        children: [
          Icon(Icons.label_outline, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            "$label: $value",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
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
                      controller: controllerManager.salesUnitPriceController,
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

                        /* purchasesCubit.updateQtyInclidingTaxes();
                            purchasesCubit.updateTotalQty(); */
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
                            focusNode: purchasesCubit.quantityFocusNode,
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
                              purchasesCubit.doDiscountPercentage(
                                  purchasesCubit.selectedItem);
                              purchasesCubit.updateTotalQty();

                              /*   purchasesCubit.updateQtyInclidingTaxes();
                              purchasesCubit.updateTotalQty(); */
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
                                  .read<PurchasesCubit>()
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
                            focusNode: purchasesCubit.discountPFocusNode,

                            /*   validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "يجب ادخال النسبه";
                            }
                            return null;
                          }, */
                            onEditingComplete: () {
                              // Trigger the calculation when the user presses Enter
                              /*  purchasesCubit.updatePrice(); */
                              purchasesCubit.doDiscountPercentage(
                                  purchasesCubit.selectedItem);
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
                            focusNode: purchasesCubit.discountVFocusNode,
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
                              purchasesCubit
                                  .doDiscountValue(purchasesCubit.selectedItem);
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
                              .read<PurchasesCubit>()
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
}
