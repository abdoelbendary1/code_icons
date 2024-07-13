import 'package:code_icons/data/model/data_model/trader_DM.dart';
import 'package:flutter/material.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TraderCard extends StatelessWidget {
  TraderDM trader;

  TraderCard({
    required this.trader,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(trader.imageUrl),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trader.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                Text(trader.gender, style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
