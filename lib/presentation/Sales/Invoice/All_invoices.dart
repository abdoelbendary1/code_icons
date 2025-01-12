import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/presentation/Sales/Invoice/addInvoice/Sales_Invoice.dart';
import 'package:code_icons/presentation/Sales/Invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/Sales/Invoice/editInvoice/EditSales_Invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/widgets/SelectCustomerEntity.dart';

class AllInvoicesScreenCards extends StatefulWidget {
  AllInvoicesScreenCards({super.key});

  static const routeName = "AllInvoicesScreenCards";

  @override
  State<AllInvoicesScreenCards> createState() => _AllInvoicesScreenCardsState();
}

class _AllInvoicesScreenCardsState extends State<AllInvoicesScreenCards> {
  SalesInvoiceCubit salesInvoiceCubit = SalesInvoiceCubit();

  static const _pageSize = 20;
  int skip = 0; // Initialize skip to start from the first page
  int take = 20; // Define the number of items per page (take size)
  /*  final PagingController<int, InvoiceReportDm> salesInvoiceCubit.pagingController =
      PagingController(firstPageKey: 0); */

  @override
  void initState() {
    super.initState();
    /*  salesInvoiceCubit.initData(); */

    salesInvoiceCubit.pagingController.addPageRequestListener((pageKey) {
      /* allDailyCollectorCubit.fetchAllCollections(
          skip: pageKey, take: _pageSize); */
      salesInvoiceCubit.fetchAllSalesInvoiceData().whenComplete(
          () => salesInvoiceCubit.fetchCustomerData(skip: skip, take: take));
    });

    salesInvoiceCubit.stream.listen((state) {
      /*   if (state is GetAllInvoicesSuccess) {
        final isLastPage = state.invoices.length < take;

        salesInvoiceCubit.pagingController.appendLastPage(state.invoices);
        /* if (isLastPage) {
        } else {
          skip += take; // Update the skip value for the next page
          salesInvoiceCubit.pagingController.appendPage(state.invoices, skip);
        } */
      }  */
      if (state is GetAllDatSuccess) {
        final isLastPage = salesInvoiceCubit.invoices.length < take;

        salesInvoiceCubit.pagingController
            .appendLastPage(salesInvoiceCubit.invoices);
        /* if (isLastPage) {
        } else {
          skip += take; // Update the skip value for the next page
          salesInvoiceCubit.pagingController.appendPage(state.invoices, skip);
        } */
      } else if (state is GetCustomerInvoicesSuccess) {
        final isLastPage = state.invoices.length < take;

        salesInvoiceCubit.pagingController.appendLastPage(state.invoices);
        /* if (isLastPage) {
        } else {
          skip += take; // Update the skip value for the next page
          salesInvoiceCubit.pagingController.appendPage(state.invoices, skip);
        } */
      } else if (state is GetAllInvoicesError) {
        print(state.errorMsg);
        salesInvoiceCubit.pagingController.error = state.errorMsg;
      }
    });
  }

  @override
  void dispose() {
    /* salesInvoiceCubit.pagingController.dispose(); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        gradientBoxShape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.blueColor, AppColors.lightBlueColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        switchLabelPosition: true,
        spaceBetweenChildren: 10,
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: AppColors.blueColor,
        foregroundColor: Colors.white,
        activeBackgroundColor: AppColors.blueColor,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(
            56.0, 56.0), // it's the SpeedDial size which defaults to 56 itself
        childrenButtonSize:
            const Size(56.0, 56.0), // it's the same as buttonSize by default
        direction: SpeedDialDirection.up, // default is SpeedDialDirection.up
        renderOverlay: true, // default is true
        overlayOpacity: 0.5, // default is 0.5
        overlayColor: Colors.black, // default is Colors.black
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0, // default is 6.0
        shape: const CircleBorder(), // default is CircleBorder
        children: [
          SpeedDialChild(
            /*  child: const Icon(Icons.add, color: Colors.white), */
            backgroundColor: AppColors.blueColor,
            labelWidget: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                gradient: const LinearGradient(
                  colors: [AppColors.blueColor, AppColors.lightBlueColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' إضافة فاتورة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, SalesInvoice.routeName);
            },
          ),
        ],
      ),
      appBar: buildAppBar(context: context, title: "الفواتير"),
      body: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
        listener: (context, state) {
          if (state is GetAllInvoicesError) {
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
        },
        bloc: salesInvoiceCubit,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اختيار العميل ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor.withOpacity(0.8),
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text(
                      "لمردودات المبيعات",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyColor,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
                    bloc: salesInvoiceCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      /*  if (state is GetAllDatSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SelectCustomerEntity(
                            /*   validator: (value) {
                            if (value == null) {
                              return "يجب ادخال العميل";
                            }
                            return null;
                          }, */
                            title: "العملاء",
                            hintText: "اختيار د",
                            itemList: salesInvoiceCubit.customerData,
                            /*   initialItem:
                                salesInvoiceCubit.customerData.isNotEmpty
                                    ? salesInvoiceCubit.selectedCustomer
                                    : null, */ // Handle empty list
                            onChanged: (value) {
                              salesInvoiceCubit.selectedCustomer = value;
                              salesInvoiceCubit.getCustomerInvoices(
                                  salesInvoiceCubit.selectedCustomer.id!);
                            },
                          ),
                        );
                      } */
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SelectCustomerEntity(
                          /*   validator: (value) {
                            if (value == null) {
                              return "يجب ادخال العميل";
                            }
                            return null;
                          }, */
                          title: "العملاء",
                          hintText: "اختيار العميل",
                          itemList: salesInvoiceCubit.customerData,
                          /*   initialItem: salesInvoiceCubit.customerData.isNotEmpty
                              ? salesInvoiceCubit.selectedCustomer
                              : null,  */ // Handle empty list
                          onChanged: (value) {
                            salesInvoiceCubit.selectedCustomer = value;
                            salesInvoiceCubit.getCustomerInvoices(
                                salesInvoiceCubit.selectedCustomer.id!);
                          },
                        ),
                      );
                    },
                  )),
                ],
              ),
              Expanded(
                child: PagedListView<int, InvoiceReportDm>(
                  pagingController: salesInvoiceCubit.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<InvoiceReportDm>(
                    itemBuilder: (context, collection, index) {
                      return BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                        bloc: salesInvoiceCubit,
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ExpansionTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "اسم العميل : ${salesInvoiceCubit.customerData.firstWhere(
                                              (customer) =>
                                                  customer.id ==
                                                  collection.customer,
                                              orElse: () => InvoiceCustomerDm(
                                                  cusNameAr: ""),
                                            ).cusNameAr.toString()}" /*  "رقم الفاتورة : ${collection.id.toString()}" */,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  childrenPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, EditSalesInvoice.routeName,
                                            arguments: collection.id);
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            buildDetailRow('رقم الفاتوره',
                                                collection.code.toString()),
                                            (collection.invTaxes == null)
                                                ? buildDetailRow(
                                                    'اجمالى الضرائب', "0.0")
                                                : buildDetailRow(
                                                    'اجمالى الضرائب',
                                                    collection.invTaxes
                                                        .toString()),
                                            buildDetailRow('الاجمالي',
                                                collection.total.toString()),
                                            buildDetailRow(
                                                'نسبة الخصم',
                                                collection.invDiscountP
                                                    .toString()),
                                            buildDetailRow(
                                                'قيمة الخصم',
                                                collection.invDiscountV
                                                    .toString()),
                                            buildDetailRow('الصافى',
                                                collection.net.toString()),
                                            buildDetailRow('المدفوع',
                                                collection.paid.toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) =>
                        LoadingStateAnimation(),
                    newPageProgressIndicatorBuilder: (_) =>
                        LoadingStateAnimation(),
                    noItemsFoundIndicatorBuilder: (_) =>
                        const Center(child: Text('لا يوجد فواتير')),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildDetailRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            value ?? 'N/A',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
