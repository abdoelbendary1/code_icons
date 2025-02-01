import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDetailsDataRow extends StatelessWidget {
  const BuildDetailsDataRow({
    super.key,
    this.label,
    this.value,
  });
  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 8.h),
              Icon(Icons.label_outline, size: 20.sp),
            ],
          ),
          SizedBox(width: 8.w),

          // Use Flexible or Expanded to make sure text wraps properly
          Expanded(
            child: Text(
              "$label: $value",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.sp,
              ),
              softWrap: true, // Enables wrapping
              overflow:
                  TextOverflow.visible, // Allows text to go to the next line
            ),
          ),
        ],
      ),
    );
  }
}
