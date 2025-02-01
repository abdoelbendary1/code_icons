// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemName.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectUOM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectItemCode.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';

class BuildSelectedItemInfoWhileEdit extends StatelessWidget {
  BuildSelectedItemInfoWhileEdit({
    super.key,
    required this.salesInvoiceCubit,
    required this.controllerManager,
    required this.formKey,
    required this.saveButton,
  });
  final SalesInvoiceCubit salesInvoiceCubit;
  final ControllerManager controllerManager;
  final GlobalKey<FormState> formKey;
  Widget saveButton;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
      bloc: salesInvoiceCubit,
      listener: (context, state) {},
      builder: (context, state) {
        while (state is EditPurchasesItemSuccess) {
          return Form(
            key: formKey,
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
                    saveButton,
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
