import 'package:code_icons/domain/entities/HR/attendanceResponse/attendance_response_entity.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/cubit/all_attendance_cubit.dart';
import 'package:code_icons/presentation/HR/attendance/attendanceScreen.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class AttendanceCard extends StatelessWidget {
  AttendanceCard(
      {required this.entity, required this.index, required this.date});
  int index;
  DateTime date;

  AllAttendanceCubit allAttendanceCubit =
      AllAttendanceCubit(iAttendance: injectIAttendance());

  AttendanceResponseEntity entity;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "توقيت : ",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
              Text(
                "${entity.timingBl}",
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        iconColor: AppColors.lightBlueColor,
        collapsedIconColor: AppColors.lightBlueColor,
        maintainState: true,
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        children: [
          BlocConsumer<AllAttendanceCubit, AllAttendanceState>(
            bloc: allAttendanceCubit,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AttendanceScreen(
                        id: entity.idBl,
                        isEditable: true,
                      ),
                    ),
                  );
                },
                child: SwipeActionCell(
                  leadingActions: [
                    SwipeAction(
                      nestedAction: SwipeNestedAction(
                        content: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.blueColor,
                                AppColors.lightBlueColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          width: 80.sp,
                          height: 50.sp,
                          child: const OverflowBox(
                            maxWidth: double.infinity,
                            child: Center(
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      color: Colors.transparent,
                      content: _getIconButton(Colors.red, Icons.delete),
                      onTap: (handler) async {
                        context
                            .read<AllAttendanceCubit>()
                            .deleteAttendanceRequest(
                                attendanceID: entity.idBl.toString(),
                                date: date);
                      },
                    ),
                  ],
                  key: ValueKey(index),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 20.h,
                              children: [
                                buildRowInfo(
                                  title: "الحضور",
                                  value: allAttendanceCubit
                                      .getAttendanceTime(entity.attendanceBl!),
                                ),
                                buildRowInfo(
                                  title: "الانصراف",
                                  value: allAttendanceCubit
                                      .getAttendanceTime(entity.departureBl!),
                                  color: Colors.blueGrey.withOpacity(0.1),
                                ),
                                buildRowInfo(
                                  title: "بدايه الحضور",
                                  value: allAttendanceCubit.getAttendanceTime(
                                      entity.startAttendanceBl!),
                                ),
                                buildRowInfo(
                                  title: "نهايه الحضور",
                                  value: allAttendanceCubit.getAttendanceTime(
                                      entity.endAttendanceBl!),
                                  color: Colors.blueGrey.withOpacity(0.1),
                                ),
                                buildRowInfo(
                                  title: "بدايه الانصراف",
                                  value: allAttendanceCubit.getAttendanceTime(
                                      entity.startDepartureBl!),
                                ),
                                buildRowInfo(
                                  title: "نهايه الانصراف",
                                  value: allAttendanceCubit.getAttendanceTime(
                                      entity.endDepartureBl!),
                                  color: Colors.blueGrey.withOpacity(0.1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ]);
  }

  Container buildRowInfo({
    required String title,
    required String value,
    Color? color,
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color ?? AppColors.lightBlueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon ?? Icons.av_timer_rounded, size: 25.sp),
          SizedBox(width: 10.w),
          Text(
            "${title} : ${value}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconButton(color, icon) {
    return Container(
      width: 80.sp,
      height: 50.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [AppColors.redColor, AppColors.lightRedColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        /// set you real bg color in your content
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
