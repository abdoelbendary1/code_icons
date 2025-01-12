import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectStatusType.dart';
import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectVacationType.dart';
import 'package:code_icons/presentation/HR/absenceRequest/cubit/absenceCubit.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AbsenceRequestScreen extends StatefulWidget {
  AbsenceRequestScreen({super.key});

  static const routeName = "absenceRequestScreen";

  @override
  State<AbsenceRequestScreen> createState() => _AbsenceRequestScreenState();
}

class _AbsenceRequestScreenState extends State<AbsenceRequestScreen> {
  /*  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );
 */
  @override
  void initState() {
    super.initState();
    super.initState();
    ControllerManager().clearControllers(
        controllers: ControllerManager().absenceRequestControllers);
  }

  AbsenceRequestCubit absenceRequestCubit = AbsenceRequestCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "تسجيل غياب "),
      extendBody: true,
      body: BlocBuilder<AbsenceRequestCubit, absenceRequestState>(
        bloc: absenceRequestCubit..initialize(),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
                horizontal: 36.w,
              ),
              child: Form(
                key: absenceRequestCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "تفاصيل بيانات التسجيل",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor.withOpacity(0.8),
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        /*   const Text(
                          "تفاصيل بيانات الطلب",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColors.greyColor,
                            fontSize: 18,
                          ),
                        ), */
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    SelectStatusType(
                      title: "نوع الغياب",
                      itemList: absenceRequestCubit.statusNames,
                      onChanged: (value) {
                        absenceRequestCubit.selectedStatusBl =
                            absenceRequestCubit.getIdBySubject(value);
                      },
                      hintText: " اختيار",
                    ),
                    /* SelectVacationType(
                      title: "نوع الغياب",
                      itemList: absenceRequestCubit.statusNames,
                      onChanged: (value) {
                        absenceRequestCubit.selectedStatusBl =
                            absenceRequestCubit.getIdBySubject(value);
                      },
                      hintText: " اختيار",
                    ), */
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildTextField(
                      label: "من",
                      /*  hint: "من", */
                      controller: ControllerManager().absenceDateFromController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال التاريخ";
                        }
                        return null;
                      },
                      icon: Icons.money,
                      readOnly: true,
                      onTap: () {
                        AppDatePicker.selectDate(
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          context: context,
                          controller:
                              ControllerManager().absenceDateFromController,
                          dateStorageMap: absenceRequestCubit.dateStorageMap,
                          key: "unlimitedPaymentReceitDateController",
                        );

                        /*     ControllerManager().employeeAddressController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .employeeAddressController
                                    .value
                                    .text
                                    .length); */
                      },
                    ),
                    BuildTextField(
                      label: "الى",
                      /*   hint: "تاريخ الطلب", */
                      controller: ControllerManager().absenceDateToController,
                      icon: Icons.app_registration,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال تاريخ ";
                        }
                        return null;
                      },
                      readOnly: true,
                      onTapOutside: (p0) {},
                      onTap: () {
                        AppDatePicker.selectDate(
                          firstDate: DateTime.now(),
                          context: context,
                          controller:
                              ControllerManager().absenceDateToController,
                          dateStorageMap: absenceRequestCubit.dateStorageMap,
                          lastDate: DateTime(2050),
                          key: "unlimitedPaymentReceitDateController",
                        );

                        /*     ControllerManager().employeeAddressController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .employeeAddressController
                                    .value
                                    .text
                                    .length); */
                      },
                    ),
                    /*        Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "عدد الاقساط",
                            hint: "عدد الاقساط",
                            keyboardType: TextInputType.number,
                            controller: ControllerManager()
                                .remainingVacationsController,
                            icon: Icons.attach_money,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الرصيد";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                      .remainingVacationsController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .remainingVacationsController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: "المبلغ ",
                            keyboardType: TextInputType.number,
                            hint: "المبلغ",
                            controller:
                                ControllerManager().vacationDaysController,
                            icon: Icons.local_activity,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الايام";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                      .vacationDaysController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .vacationDaysController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                      ],
                    ),
                    */
                    BuildTextField(
                      label: " عدد الايام",
                      keyboardType: TextInputType.number,
                      hint: "المدة  ",
                      controller: ControllerManager().absenceDaysController,
                      icon: Icons.local_activity,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال الايام";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager().absenceDaysController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .absenceDaysController
                                    .value
                                    .text
                                    .length);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    /*   SelectStatusType(
                      enabled: false,
                      initialItem: absenceRequestCubit.statusNames.first,
                      title: "الحاله",
                      itemList: absenceRequestCubit.statusNames,
                      onChanged: (value) {
                        absenceRequestCubit.getIdBySubject(value);
                      },
                      hintText: " اختيار",
                    ),
                    SizedBox(
                      height: 20.h,
                    ), */
                    BuildTextField(
                      label: "ملاحظات",
                      /*   hint: "ملاحظات", */
                      maxLines: 10,
                      minLines: 3,
                      controller: ControllerManager().abssenceNotesController,
                      /*      icon: Icons.local_activity, */
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال ملاحظات";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager().abssenceNotesController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .abssenceNotesController
                                    .value
                                    .text
                                    .length);
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    buildSaveButton(
                      context: context,
                      onPressed: () async {
                        absenceRequestCubit.addVacationRequest();
                      },
                    ),
                    /*   SizedBox(
                      height: 30.h,
                    ), */
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSaveButton(
      {required BuildContext context, required void Function()? onPressed}) {
    return Row(
      children: [
        const Spacer(),
        BlocListener<AbsenceRequestCubit, absenceRequestState>(
          bloc: absenceRequestCubit,
          listener: (context, state) {
            if (state is addabsenceRequestSuccess) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                confirmBtnText: "الذهاب الى الصفحه الرئيسيه",
                title: "تمت الإضافه بنجاح",
                titleColor: AppColors.lightBlueColor,
                /*   onConfirmBtnTap: () {}, */
              );
            } else if (state is addabsenceRequestError) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMessage,
                titleColor: AppColors.redColor,
              );
              if (state.errorMessage.contains("400")) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMessage,
                  titleColor: AppColors.redColor,
                );
              } else if (state.errorMessage.contains("500")) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMessage,
                  titleColor: AppColors.redColor,
                );
              }
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
              child: Text(AppLocalizations.of(context)!.save),
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
