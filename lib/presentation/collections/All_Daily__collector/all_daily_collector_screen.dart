import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/add_collection_view.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllDailyCollectorScreen extends StatelessWidget {
  const AllDailyCollectorScreen({super.key});

  static const routeName = "AllDailyCollectorScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'AllDailyCollectorScreen',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                /* fixedSize: Size(160.h, 50.w), */
                backgroundColor: AppColors.blueGreyColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AddCollectionView.routeName);
              },
              child: Text(
                "Add Collection",
              ),
            ),
          )
        ],
      ),
    );
  }
}
