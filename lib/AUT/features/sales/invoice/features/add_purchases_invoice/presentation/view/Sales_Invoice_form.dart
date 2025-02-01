import 'package:accordion/accordion.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_invoice_info_section.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_item_info_section.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/widgets/build_selected_items_list.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';

import 'package:accordion/controllers.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/edit_purchases_invoice/presentation/view/EditSales_Invoice.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:select_dialog/select_dialog.dart';

class SalesInvoiceForm extends StatefulWidget {
  const SalesInvoiceForm({super.key});

  @override
  State<SalesInvoiceForm> createState() => _SalesInvoiceFormState();
}

class _SalesInvoiceFormState extends State<SalesInvoiceForm> {
  late SalesInvoiceCubit salesInvoiceCubit = SalesInvoiceCubit();
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
            buildSaveButton(
                context: context,
                onPressed: () {
                  SelectDialog.showModal<InvoiceReportDm>(
                    context,
                    backgroundColor: AppColors.whiteColor,
                    searchHint: "بحث",
                    itemBuilder: (context, item, isSelected) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.code.toString()),
                      );
                    },
                    label: "Select Invoice",
                    items: salesInvoiceCubit.returns,
                    onChange: (selected) async {
                      await salesInvoiceCubit.fetchSalesReturnDataByID(
                          id: selected.id!);
                    },
                  );
                },
                title: "تحميل فاتورة",
                mainAxisAlignment: MainAxisAlignment.start),
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
              headerPadding: EdgeInsets.all(20.w),
              children: [
                buildInvoiceInfo(),
                buildItemInfoSection(),
                buildInvoiceData(),
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
                    salesInvoiceCubit.postSalesReport(context: context);
                  },
                ),
                /* buildSaveButton(
                  mainAxisAlignment: MainAxisAlignment.end,
                  title: "طباعه",
                  context: context,
                  onPressed: () async {
    /*                       buildInvoicePrint(salesInvoiceCubit.selectedItemsList);
     */
                    salesInvoiceCubit.getInvoicePrint(id: "3");
                    /*   PdfGenerator.createPdf(
                        salesInvoiceCubit: salesInvoiceCubit,
                        selectedItemsList:
                            salesInvoiceCubit.selectedItemsList); */
                  },
                ), */
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  AccordionSection buildInvoiceData() {
    return AccordionSection(
      contentBorderColor: Colors.white,
      contentBorderWidth: 0,
      accordionId: "3",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      header: const Text('الفاتورة',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BuildSelectedItemsList(
        salesInvoiceCubit: salesInvoiceCubit,
      ),
    );
  }

  AccordionSection buildInvoiceInfo() {
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
        content: BuildInvoiceInfoSection(
          controllerManager: controllerManager,
          salesInvoiceCubit: salesInvoiceCubit,
          saveButton: buildSaveButton(
              context: context,
              onPressed: () {
                InvoiceCustomerDm invoiceCustomer = InvoiceCustomerDm(
                  cusNameAr:
                      controllerManager.invoiceAddCustomerNameController.text,
                  mobile:
                      controllerManager.invoiceAddCustomerPhoneController.text,
                  taxCardNumber:
                      controllerManager.invoiceAddCustomerTaxNumController.text,
                  csType: 0,
                  countryId: salesInvoiceCubit.countryCode,
                );
                salesInvoiceCubit.addCustomer(invoiceCustomer, context);
              },
              title: "إضافه",
              mainAxisAlignment: MainAxisAlignment.end),
        ));
  }

  AccordionSection buildItemInfoSection() {
    return AccordionSection(
        key: salesInvoiceCubit.accKey,
        sectionOpeningHapticFeedback: SectionHapticFeedback.none,
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
        content: BuildItemInfoSection(
          controllerManager: controllerManager,
          formKeyItems: formKeyItems,
          salesInvoiceCubit: salesInvoiceCubit,
        ));
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
}
