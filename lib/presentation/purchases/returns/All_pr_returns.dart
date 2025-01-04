import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/presentation/Sales/returns/addReturn/Sales_Returns.dart';
import 'package:code_icons/presentation/Sales/returns/editInvoice/EditSales_Return.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_state.dart';
import 'package:code_icons/presentation/purchases/returns/addReturn/PR_Returns.dart';
import 'package:code_icons/presentation/purchases/returns/editInvoice/EditPR_Return.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AllPrReturnsScreenCards extends StatefulWidget {
  const AllPrReturnsScreenCards({super.key});

  static const routeName = "AllPrReturnsScreenCards";

  @override
  State<AllPrReturnsScreenCards> createState() =>
      _AllPrReturnsScreenCardsState();
}

class _AllPrReturnsScreenCardsState extends State<AllPrReturnsScreenCards> {
  PurchasesCubit purchasesCubit = PurchasesCubit();

  static const _pageSize = 20;
  int skip = 0; // Initialize skip to start from the first page
  int take = 20; // Define the number of items per page (take size)
  final PagingController<int, PrReturnDM> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
/*     purchasesCubit.fetchCustomerData(skip: skip, take: take);
 */
    purchasesCubit.getStoreData();

    _pagingController.addPageRequestListener((pageKey) {
      /* allDailyCollectorCubit.fetchAllCollections(
          skip: pageKey, take: _pageSize); */
      purchasesCubit.fetchAllPrReturnsData();
    });

    purchasesCubit.stream.listen((state) {
      if (state is GetAllPrReturnsSuccess) {
        final isLastPage = state.returns.length < take;

        _pagingController.appendLastPage(state.returns);
        /* if (isLastPage) {
        } else {
          skip += take; // Update the skip value for the next page
          _pagingController.appendPage(state.invoices, skip);
        } */
      } else if (state is GetAllInvoicesError) {
        print(state.errorMsg);
        _pagingController.error = state.errorMsg;
      }
    });
  }

  @override
  void dispose() {
    /* _pagingController.dispose(); */
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
                      ' إضافة مردود',
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
              Navigator.pushNamed(context, PrReturn.routeName);
            },
          ),
        ],
      ),
      appBar: buildAppBar(context: context, title: "مردودات"),
      body: BlocConsumer<PurchasesCubit, PurchasesState>(
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
        bloc: purchasesCubit,
        builder: (context, state) {
          return PagedListView<int, PrReturnDM>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<PrReturnDM>(
              itemBuilder: (context, collection, index) {
                return BlocBuilder<PurchasesCubit, PurchasesState>(
                  bloc: purchasesCubit,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اسم الفرع : ${purchasesCubit.storeList.firstWhere(
                                    (store) =>
                                        store.storeId == collection.storeId,
                                    orElse: () =>
                                        StoreDataModel(storeNameAr: ""),
                                  ).storeNameAr.toString()}" /*  "رقم الفاتورة : ${collection.id.toString()}" */,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, EditPrReturn.routeName,
                                  arguments: collection.id);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  buildDetailRow('رقم الفاتوره',
                                      collection.code.toString()),
                                  /*    (collection.invTaxes == null)
                                      ? buildDetailRow('اجمالى الضرائب', "0.0")
                                      : buildDetailRow('اجمالى الضرائب',
                                          collection.invTaxes.toString()), */
                                  buildDetailRow(
                                      'الاجمالي', collection.total.toString()),
                                  buildDetailRow('نسبة الخصم',
                                      collection.invDiscountP.toString()),
                                  buildDetailRow('قيمة الخصم',
                                      collection.invDiscountV.toString()),
                                  buildDetailRow(
                                      'الصافى', collection.net.toString()),
                                  /*    buildDetailRow(
                                      'المدفوع',
                                      collection.paid == null
                                          ? "0.0"
                                          : collection.paid.toString()), */
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              firstPageProgressIndicatorBuilder: (_) => LoadingStateAnimation(),
              newPageProgressIndicatorBuilder: (_) => LoadingStateAnimation(),
              noItemsFoundIndicatorBuilder: (_) =>
                  const Center(child: Text('لا يوجد فواتير')),
            ),
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
