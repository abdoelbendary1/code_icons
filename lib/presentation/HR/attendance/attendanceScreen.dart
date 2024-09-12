import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/All_Attendances_by_day_screen.dart';
import 'package:code_icons/presentation/HR/attendance/cubit/attendace_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/presentation/utils/timePicker.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({
    super.key,
    this.isEditable = false,
    this.id,
  });
  bool? isEditable;
  String? id;

  static const routeName = "AttendanceScreen";

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

DateTime date1 = DateTime.now();
final controller = BoardDateTimeController();
final textController1 = BoardDateTimeTextController();
final textController2 = BoardDateTimeTextController();

final formKey = GlobalKey<FormState>();

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ControllerManager().attendanceTimingBLController.clear();
    attendaceCubit.getAttendanceEntity(id: widget.id ?? "");
    if (widget.isEditable! == true) {}
  }

  AttendaceCubit attendaceCubit = AttendaceCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: " الحضور والانصراف",
      ),
      extendBody: true,
      body: BlocConsumer<AttendaceCubit, AttendaceState>(
        bloc: attendaceCubit,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GetAttendaceByIDLoading) {
            return LoadingStateAnimation();
          }
          return BoardDateTimeBuilder(
              resizeBottom: false,
              controller: controller,
              builder: (context) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.0.w, vertical: 0.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 50.0.h, top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<AttendaceCubit, AttendaceState>(
                            bloc: attendaceCubit,
                            builder: (context, state) {
                              if (state is GetAttendaceByIDSuccess) {
                                ControllerManager()
                                    .attendanceTimingBLController
                                    .text = state.entity.timingBl ?? "";
                                return BuildTextField(
                                  label: "اسم التوقيت",
                                  hint: "ادخل اسم التوقيت",
                                  controller: ControllerManager()
                                      .attendanceTimingBLController,
                                  icon: Icons.phone_iphone,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يجب ادخال اسم التوقيت";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    ControllerManager()
                                            .attendanceTimingBLController
                                            .selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset: ControllerManager()
                                                .attendanceTimingBLController
                                                .value
                                                .text
                                                .length);
                                  },
                                );
                              }
                              return BuildTextField(
                                label: "اسم التوقيت",
                                hint: "ادخل اسم التوقيت",
                                controller: ControllerManager()
                                    .attendanceTimingBLController,
                                icon: Icons.phone_iphone,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "يجب ادخال اسم التوقيت";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  ControllerManager()
                                          .attendanceTimingBLController
                                          .selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: ControllerManager()
                                              .attendanceTimingBLController
                                              .value
                                              .text
                                              .length);
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<AttendaceCubit, AttendaceState>(
                                  bloc: attendaceCubit,
                                  builder: (context, state) {
                                    if (state is GetAttendaceByIDSuccess) {
                                      ControllerManager()
                                          .attendanceBLTimeController
                                          .setDate(DateTime.parse(
                                              state.entity.attendanceBl!));
                                      attendaceCubit.attendanceBL =
                                          state.entity.attendanceBl!;
                                      return CustomTimePicker(
                                        initialDate: DateTime.parse(
                                            state.entity.attendanceBl!),
                                        title: "الحضور",
                                        controller: ControllerManager()
                                            .attendanceBLTimeController,
                                        suffixIcon: Icons.access_time_outlined,
                                        onChanged: (date) {
                                          attendaceCubit.attendanceBL =
                                              date.toString();
                                        },
                                        onFocusChange: (val, date, text) {},
                                        validators:
                                            BoardDateTimeInputFieldValidators(
                                          showMessage: true,
                                          onRequired: () {
                                            return "يجب ادخال الوقت";
                                          },
                                        ),
                                      );
                                    }
                                    return CustomTimePicker(
                                      title: "الحضور",
                                      controller: ControllerManager()
                                          .attendanceBLTimeController,
                                      suffixIcon: Icons.access_time_outlined,
                                      onChanged: (date) {
                                        attendaceCubit.attendanceBL =
                                            date.toString();
                                      },
                                      onFocusChange: (val, date, text) {},
                                      validators:
                                          BoardDateTimeInputFieldValidators(
                                        onRequired: () {
                                          return "يجب ادخال الوقت";
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<AttendaceCubit, AttendaceState>(
                                  bloc: attendaceCubit,
                                  builder: (context, state) {
                                    if (state is GetAttendaceByIDSuccess) {
                                      ControllerManager()
                                          .departureBLTimeController
                                          .setDate(DateTime.parse(
                                              state.entity.departureBl!));
                                      attendaceCubit.departureBL =
                                          state.entity.departureBl!;
                                      return CustomTimePicker(
                                        initialDate: DateTime.parse(
                                            state.entity.departureBl!),
                                        title: "الانصراف",
                                        suffixIcon: Icons.access_time_outlined,
                                        controller: ControllerManager()
                                            .departureBLTimeController,
                                        onChanged: (date) {
                                          attendaceCubit.departureBL =
                                              date.toString();
                                        },
                                        onFocusChange: (val, date, text) {},
                                        validators:
                                            BoardDateTimeInputFieldValidators(
                                          onRequired: () {
                                            return "يجب ادخال الوقت";
                                          },
                                        ),
                                      );
                                    }
                                    return CustomTimePicker(
                                      title: "الانصراف",
                                      suffixIcon: Icons.access_time_outlined,
                                      controller: ControllerManager()
                                          .departureBLTimeController,
                                      onChanged: (date) {
                                        attendaceCubit.departureBL =
                                            date.toString();
                                      },
                                      onFocusChange: (val, date, text) {},
                                      validators:
                                          BoardDateTimeInputFieldValidators(
                                        onRequired: () {
                                          return "يجب ادخال الوقت";
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<AttendaceCubit, AttendaceState>(
                                  bloc: attendaceCubit,
                                  builder: (context, state) {
                                    if (state is GetAttendaceByIDSuccess) {
                                      ControllerManager()
                                          .startAttendanceBLTimeController
                                          .setDate(DateTime.parse(
                                              state.entity.startAttendanceBl!));
                                      attendaceCubit.startAttendanceBL =
                                          state.entity.startAttendanceBl!;
                                      return CustomTimePicker(
                                        initialDate: DateTime.parse(
                                            state.entity.startAttendanceBl!),
                                        title: "بدايه الحضور",
                                        controller: ControllerManager()
                                            .startAttendanceBLTimeController,
                                        suffixIcon: Icons.access_time_outlined,
                                        onChanged: (date) {
                                          attendaceCubit.startAttendanceBL =
                                              date.toString();
                                        },
                                        validators:
                                            BoardDateTimeInputFieldValidators(
                                          onRequired: () {
                                            return "يجب ادخال الوقت";
                                          },
                                        ),
                                      );
                                    }
                                    return CustomTimePicker(
                                      title: "بدايه الحضور",
                                      controller: ControllerManager()
                                          .startAttendanceBLTimeController,
                                      suffixIcon: Icons.access_time_outlined,
                                      onChanged: (date) {
                                        attendaceCubit.startAttendanceBL =
                                            date.toString();
                                      },
                                      validators:
                                          BoardDateTimeInputFieldValidators(
                                        onRequired: () {
                                          return "يجب ادخال الوقت";
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<AttendaceCubit, AttendaceState>(
                                  bloc: attendaceCubit,
                                  builder: (context, state) {
                                    if (state is GetAttendaceByIDSuccess) {
                                      ControllerManager()
                                          .endAttendanceBLTimeController
                                          .setDate(DateTime.parse(
                                              state.entity.endAttendanceBl!));
                                      attendaceCubit.endAttendanceBL =
                                          state.entity.endAttendanceBl!;
                                      return CustomTimePicker(
                                        validators:
                                            BoardDateTimeInputFieldValidators(
                                          onRequired: () {
                                            return "يجب ادخال الوقت";
                                          },
                                        ),
                                        initialDate: DateTime.parse(
                                            state.entity.endAttendanceBl!),
                                        title: "نهايه الحضور",
                                        controller: ControllerManager()
                                            .endAttendanceBLTimeController,
                                        suffixIcon: Icons.access_time_outlined,
                                        onChanged: (date) {
                                          attendaceCubit.endAttendanceBL =
                                              date.toString();
                                        },
                                        onFocusChange: (val, date, text) {},
                                      );
                                    }
                                    return CustomTimePicker(
                                      validators:
                                          BoardDateTimeInputFieldValidators(
                                        onRequired: () {
                                          return "يجب ادخال الوقت";
                                        },
                                      ),
                                      title: "نهايه الحضور",
                                      controller: ControllerManager()
                                          .endAttendanceBLTimeController,
                                      suffixIcon: Icons.access_time_outlined,
                                      onChanged: (date) {
                                        attendaceCubit.endAttendanceBL =
                                            date.toString();
                                      },
                                      onFocusChange: (val, date, text) {},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<AttendaceCubit, AttendaceState>(
                                  bloc: attendaceCubit,
                                  builder: (context, state) {
                                    if (state is GetAttendaceByIDSuccess) {
                                      ControllerManager()
                                          .startDepartureBLTimeController
                                          .setDate(DateTime.parse(
                                              state.entity.startDepartureBl!));
                                      attendaceCubit.startDepartureBL =
                                          state.entity.startDepartureBl!;
                                      return CustomTimePicker(
                                        validators:
                                            BoardDateTimeInputFieldValidators(
                                          onRequired: () {
                                            return "يجب ادخال الوقت";
                                          },
                                        ),
                                        initialDate: DateTime.parse(
                                            state.entity.startDepartureBl!),
                                        title: "بدايه الانصراف",
                                        suffixIcon: Icons.access_time_outlined,
                                        controller: ControllerManager()
                                            .startDepartureBLTimeController,
                                        onChanged: (date) {
                                          attendaceCubit.startDepartureBL =
                                              date.toString();
                                        },
                                      );
                                    }
                                    return CustomTimePicker(
                                      validators:
                                          BoardDateTimeInputFieldValidators(
                                        onRequired: () {
                                          return "يجب ادخال الوقت";
                                        },
                                      ),
                                      title: "بدايه الانصراف",
                                      suffixIcon: Icons.access_time_outlined,
                                      controller: ControllerManager()
                                          .startDepartureBLTimeController,
                                      onChanged: (date) {
                                        attendaceCubit.startDepartureBL =
                                            date.toString();
                                      },
                                    );
                                  },
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<AttendaceCubit, AttendaceState>(
                                  bloc: attendaceCubit,
                                  builder: (context, state) {
                                    if (state is GetAttendaceByIDSuccess) {
                                      ControllerManager()
                                          .endDepartureBLTimeController
                                          .setDate(DateTime.parse(
                                              state.entity.endDepartureBl!));
                                      attendaceCubit.endDepartureBL =
                                          state.entity.endDepartureBl!;
                                      return CustomTimePicker(
                                        validators:
                                            BoardDateTimeInputFieldValidators(
                                          onRequired: () {
                                            return "يجب ادخال الوقت";
                                          },
                                        ),
                                        initialDate: DateTime.tryParse(
                                            state.entity.endDepartureBl!),
                                        title: "نهايه الانصراف",
                                        suffixIcon: Icons.access_time_outlined,
                                        controller: ControllerManager()
                                            .endDepartureBLTimeController,
                                        onChanged: (date) {
                                          attendaceCubit.endDepartureBL =
                                              date.toString();
                                        },
                                        onFocusChange: (val, date, text) {},
                                      );
                                    }
                                    return CustomTimePicker(
                                      validators:
                                          BoardDateTimeInputFieldValidators(
                                        onRequired: () {
                                          return "يجب ادخال الوقت";
                                        },
                                      ),
                                      title: "نهايه الانصراف",
                                      suffixIcon: Icons.access_time_outlined,
                                      controller: ControllerManager()
                                          .endDepartureBLTimeController,
                                      onChanged: (date) {
                                        attendaceCubit.endDepartureBL =
                                            date.toString();
                                      },
                                      onFocusChange: (val, date, text) {},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          BlocBuilder<AttendaceCubit, AttendaceState>(
                            bloc: attendaceCubit,
                            builder: (context, state) {
                              if (state is GetAttendaceByIDSuccess) {
                                return buildSaveButton(
                                  title: "تعديل",
                                  context: context,
                                  onPressed: () async {
                                    attendaceCubit.updateAttendanceById(
                                        id: state.entity.idBl!);
                                  },
                                );
                              }
                              return buildSaveButton(
                                title: "حفظ",
                                context: context,
                                onPressed: () async {
                                  attendaceCubit.addAttendanceSheet();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              onChange: (val) {
                /*  setState(() {
                    date1 = val;
                    print('on focus changed date: $val');
                  }); */
              });
        },
      ),
    );
  }

  Widget buildSaveButton(
      {required BuildContext context,
      required void Function()? onPressed,
      required String title}) {
    return Row(
      children: [
        const Spacer(),
        BlocListener<AttendaceCubit, AttendaceState>(
          bloc: attendaceCubit,
          listener: (context, state) {
            if (state is AddAttendaceSheetSuccess) {
              Navigator.pushReplacementNamed(
                  context, AllAttendancesScreen.routeName);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                confirmBtnText: "الذهاب الى الصفحه الرئيسيه",
                title: "تمت الإضافه بنجاح",
                titleColor: AppColors.lightBlueColor,
                /*   onConfirmBtnTap: () {}, */
              );
            } else if (state is AddAttendaceSheetError) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMessage,
                titleColor: AppColors.redColor,
              );
            } else if (state is UpdateAttendaceSheetSuccess) {
              Navigator.pushReplacementNamed(
                  context, AllAttendancesScreen.routeName);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                confirmBtnText: "الذهاب الى الصفحه الرئيسيه",
                title: "تم التعديل بنجاح",
                titleColor: AppColors.lightBlueColor,
                /*   onConfirmBtnTap: () {}, */
              );
            } else if (state is UpdateAttendaceSheetError) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMessage,
                titleColor: AppColors.redColor,
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
