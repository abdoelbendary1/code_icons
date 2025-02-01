import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/domain/entities/invoice/customers/invoice_customer_entity.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/add_purchases_invoice/presentation/view/Sales_Invoice.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/AUT/features/sales/invoice/features/edit_purchases_invoice/presentation/view/EditSales_Invoice.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/add_collection_view.dart';
import 'package:code_icons/presentation/storage/items/cubit/items_cubit.dart';
import 'package:code_icons/presentation/storage/items/storageBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/trade_chamber/features/show_all_collections/presentation/controller/cubit/all_daily_collector_cubit.dart';
import 'package:code_icons/services/di.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AllStorageItesmScreenCards extends StatefulWidget {
  AllStorageItesmScreenCards({super.key});

  static const routeName = "AllStorageItesmScreenCards";

  @override
  State<AllStorageItesmScreenCards> createState() =>
      _AllStorageItesmScreenCardsState();
}

class _AllStorageItesmScreenCardsState
    extends State<AllStorageItesmScreenCards> {
  ItemsCubit itemsCubit = ItemsCubit(
    addItemUseCase: injcetAddItemUseCase(),
    fetchUOMUsecase: injectFetchUOMUseCase(),
    addItemCategoryUseCase: injectAddItemCategoryUseCase(),
    itemCompanyUseCase: injcetAddItemCompanyUseCase(),
  );

  static const _pageSize = 20;
  int skip = 0; // Initialize skip to start from the first page
  int take = 20; // Define the number of items per page (take size)
  final PagingController<int, SalesItemDm> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    itemsCubit.fetchPurchaseItemData();
    _pagingController.addPageRequestListener((pageKey) {
      /* allDailyCollectorCubit.fetchAllCollections(
          skip: pageKey, take: _pageSize); */
      itemsCubit.fetchPurchaseItemData();
    });

    itemsCubit.stream.listen((state) {
      if (state is getAllItemsSuccess) {
        final isLastPage = state.items.length < take;

        _pagingController.appendLastPage(state.items);
        /* if (isLastPage) {
        } else {
          skip += take; // Update the skip value for the next page
          _pagingController.appendPage(state.invoices, skip);
        } */
      } else if (state is getAllItemsError) {
        print(state.errorMsg);
        _pagingController.error = state.errorMsg;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
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
                      ' إضافة صنف',
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
              Navigator.pushReplacementNamed(context, AddItemsScreen.routeName);
            },
          ),
        ],
      ),
      appBar: buildAppBar(context: context, title: "الاصناف"),
      body: BlocConsumer<ItemsCubit, ItemsState>(
        listener: (context, state) {
          if (state is getAllItemsError) {
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
        bloc: itemsCubit,
        builder: (context, state) {
          return PagedListView<int, SalesItemDm>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<SalesItemDm>(
              itemBuilder: (context, collection, index) {
                return BlocBuilder<ItemsCubit, ItemsState>(
                  bloc: itemsCubit,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اسم الصنف : ${itemsCubit.items[index].itemNameAr}",
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
                              /*  Navigator.popAndPushNamed(
                                  context, EditSalesInvoice.routeName,
                                  arguments: collection.itemId); */
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  (collection.smallUOMPrice == null)
                                      ? buildDetailRow('سعر البيع', "0.0")
                                      : buildDetailRow('سعر البيع',
                                          collection.smallUOMPrice.toString()),
                                  (collection.smallUOMPrice == null)
                                      ? buildDetailRow('سعر الشراء', "0.0")
                                      : buildDetailRow(
                                          'سعر الشراء',
                                          collection.smallUOMprPrice
                                              .toString()),
                                  /*   buildDetailRow(
                                      'الاجمالي', collection.toString()),
                                  buildDetailRow('نسبة الخصم',
                                      collection.invDiscountP.toString()),
                                  buildDetailRow('قيمة الخصم',
                                      collection.invDiscountV.toString()),
                                  buildDetailRow(
                                      'المدفوع', collection.paid.toString()), */
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
