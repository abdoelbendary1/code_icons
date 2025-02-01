import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectCustomerEntity.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectableDropDownlist.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectCurrency.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/selectdrawerentity.dart';
import 'package:code_icons/presentation/purchases/returns/widgets/counrtyPicker.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildInvoiceInfoSection extends StatelessWidget {
   BuildInvoiceInfoSection({
    super.key,
    required this.controllerManager,
    required this.salesInvoiceCubit,
    required this.saveButton,
  });
  final SalesInvoiceCubit salesInvoiceCubit;
  final ControllerManager controllerManager;
  Widget saveButton;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                    orElse: () => salesInvoiceCubit.customerData
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
                                              alignment: Alignment.centerRight,
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
                                           saveButton
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
            BuildTextField(
              label: "تاريخ الاستلام",
              hint: "التاريخ ",
              color: AppColors.greyColor,
              controller: controllerManager.invoiceReceiveDateController,
              readOnly: true,
              icon: Icons.app_registration,
              onTap: () {
                AppDatePicker.selectDate(
                    context: context,
                    controller: controllerManager.invoiceReceiveDateController,
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
            ),
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
            Row(
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
                      initialItem: salesInvoiceCubit.getNameByID(
                          salesInvoiceCubit.paymentMethodID!,
                          salesInvoiceCubit.paymentType),
                      /* salesInvoiceCubit.paymentTypes.isNotEmpty
                            ? salesInvoiceCubit.paymentTypes.first
                            : null, */ // Handle empty list
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
                          child:
                              BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
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
            ),
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
    );
  }

}
