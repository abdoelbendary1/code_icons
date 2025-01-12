import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/controller/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/controller/cubit/unlimited_collection_state.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/data/model/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:code_icons/data/model/data_model/unRegistered_collection_table.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/view/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';

class UnRegisteredCollectionsScreenCards extends StatefulWidget {
  const UnRegisteredCollectionsScreenCards({super.key});

  static const routeName = "UnRegisteredCollectionsScreenCards";

  @override
  State<UnRegisteredCollectionsScreenCards> createState() =>
      _UnRegisteredCollectionsScreenCardsState();
}

class _UnRegisteredCollectionsScreenCardsState
    extends State<UnRegisteredCollectionsScreenCards> {
  UnlimitedCollectionCubit unlimitedCollectionCubit = UnlimitedCollectionCubit(
    postUnRegisteredTradeCollectionUseCase:
        injectPostUnRegisteredTradeCollectionUseCase(),
    getUnRegisteredTradeCollectionUseCase:
        injectFetchAllUnRegisteredCollectionsUseCase(),
    authManager: injectAuthManagerInterface(),
  );

  late UnlimitedCollectionsDataSource _dataSource;
  DataGridController dataGridController = DataGridController();

  var renderOverlay = true;
  static const _pageSize = 20;
  int skip = 0; // Initialize skip for paging
  int take = 20; // Define items per page
  final PagingController<int, UnRegisteredCollectionEntity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    // Initialize PagingController to start with page key 0
    _pagingController.addPageRequestListener((pageKey) {
      unlimitedCollectionCubit.getAllCollctions(skip: pageKey, take: _pageSize);
    });

    unlimitedCollectionCubit.stream.listen((state) {
      if (state is GetUnlimitedCollectionsSuccess) {
        final isLastPage = state.collectiion.length < take;

        if (isLastPage) {
          _pagingController.appendLastPage(state.collectiion);
        } else {
          final nextPageKey = skip + take; // Increment skip for the next page
          _pagingController.appendPage(state.collectiion, nextPageKey);
        }
      } else if (state is GetUnlimitedCollectionsError) {
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
        buttonSize: const Size(56.0, 56.0),
        childrenButtonSize: const Size(56.0, 56.0),
        direction: SpeedDialDirection.up,
        renderOverlay: true,
        overlayOpacity: 0.5,
        overlayColor: Colors.black,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
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
                      'إضافة حافظة غير مقيدة',
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
              Navigator.pushReplacementNamed(
                  context, UnlimitedCollection.routeName);
            },
          ),
        ],
      ),
      appBar: buildAppBar(context: context, title: "الحوافظ الغير مقيدة"),
      body: PagedListView<int, UnRegisteredCollectionEntity>(
        pagingController: _pagingController,
        builderDelegate:
            PagedChildBuilderDelegate<UnRegisteredCollectionEntity>(
          itemBuilder: (context, collection, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection.brandNameBl ?? 'Unknown Brand',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    /* Text(
                      'المحصل: ${collection ?? 'غ.م'}',
                      style: TextStyle(color: Colors.grey[600]),
                    ), */
                  ],
                ),
                childrenPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow('الاسم', collection.brandNameBl),
                  buildDetailRow('رقم الايصال', collection.receiptBl),
                  buildDetailRow('تاريخ السجل', collection.receiptDateBl),
                  buildDetailRow(
                      'تعويض', collection.divisionBl?.toStringAsFixed(2)),
                  buildDetailRow(
                      'حالي', collection.currentBl?.toStringAsFixed(2)),
                  buildDetailRow('النشاط', collection.activityBl),
                  buildDetailRow(
                      'إجمالي', collection.totalBl?.toStringAsFixed(2)),
                ],
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) => LoadingStateAnimation(),
          newPageProgressIndicatorBuilder: (_) => LoadingStateAnimation(),
          noItemsFoundIndicatorBuilder: (_) =>
              Center(child: Text('No collections found')),
        ),
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
