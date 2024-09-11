import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/cubit/all_attendance_cubit.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/widgets/Attendance_card.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AllAttendancesScreen extends StatefulWidget {
  const AllAttendancesScreen({super.key});

  static const routeName = "AllAttendancesScreen";

  @override
  State<AllAttendancesScreen> createState() => _AllAttendancesScreenState();
}

DateTime date1 = DateTime.now();

final controller = BoardDateTimeController();
final textController1 = BoardDateTimeTextController();
final textController2 = BoardDateTimeTextController();

final formKey = GlobalKey<FormState>();
AllAttendanceCubit allAttendanceCubit =
    AllAttendanceCubit(iAttendance: injectIAttendance());

class _AllAttendancesScreenState extends State<AllAttendancesScreen> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => allAttendanceCubit,
      child: Scaffold(
          appBar: buildAppBar(
            context: context,
            title: "توقيتات الحضور والانصراف",
          ),
          extendBody: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<AllAttendanceCubit, AllAttendanceState>(
                    bloc: allAttendanceCubit
                      ..getAllAttendance(date: DateTime.now()),
                    builder: (context, state) {
                      return EasyInfiniteDateTimeLine(
                        locale: "ar",
                        firstDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                        ),
                        focusDate: _focusDate,
                        lastDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          31,
                        ),
                        onDateChange: (selectedDate) {
                          _focusDate = selectedDate;
                          allAttendanceCubit.getAllAttendance(
                              date: selectedDate);
                        },
                        dayProps: const EasyDayProps(
                          // You must specify the width in this case.
                          width: 64.0,
                          // The height is not required in this case.
                          height: 120.0,
                        ),
                      );
                    },
                  ),
                  BlocConsumer<AllAttendanceCubit, AllAttendanceState>(
                    bloc: allAttendanceCubit,
                    listener: (context, state) {
                      if (state is DeleteAttendanceError) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: state.errorMsg,
                          titleColor: AppColors.redColor,
                        );
                        if (state.errorMsg.contains("400")) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            showConfirmBtn: false,
                            title: state.errorMsg,
                            titleColor: AppColors.redColor,
                          );
                        } else if (state.errorMsg.contains("500")) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            showConfirmBtn: false,
                            title: state.errorMsg,
                            titleColor: AppColors.redColor,
                          );
                        }
                      } else if (state is DeleteAttendanceSuccess) {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.success,
                          showConfirmBtn: false,
                          title: "تم حذف السجل بنجاح",
                          titleColor: AppColors.lightBlueColor,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AllAttendanceInitial) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            const LoadingStateAnimation(),
                          ],
                        );
                      }
                      if (state is GetAllAttendanceSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 8.0),
                          child: ListView.separated(
                            /*  gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ), */
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.0.w),
                                child: AttendanceCard(
                                  entity: state.attendances[index],
                                  index: index,
                                  date: _focusDate,
                                ),
                              );
                            },
                            itemCount: state.attendances.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        );
                      } else if (state is GetAllAttendanceError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.errorMsg,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        );
                      }
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 8.0),
                          child: Container());
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
