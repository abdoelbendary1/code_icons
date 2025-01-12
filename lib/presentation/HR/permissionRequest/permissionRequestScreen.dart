import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectStatusType.dart';
import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectVacationType.dart';
import 'package:code_icons/presentation/HR/permissionRequest/cubit/permissionCubit.dart';
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

class PermissionRequestScreen extends StatefulWidget {
  PermissionRequestScreen({super.key});

  static const routeName = "PermissionRequestScreen";

  @override
  State<PermissionRequestScreen> createState() =>
      _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  /*  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );
 */
  @override
  void initState() {
    super.initState();

    /* ControllerManager().clearControllers(
        controllers: ControllerManager().PermissionRequestControllers); */
  }

  PermissionRequestCubit permissionRequestCubit = PermissionRequestCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "طلب اذن"),
      extendBody: true,
      body: BlocBuilder<PermissionRequestCubit, PermissionRequestState>(
        bloc: permissionRequestCubit..initialize(),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
                horizontal: 36.w,
              ),
              child: Form(
                key: permissionRequestCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "تفاصيل بيانات الطلب",
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
                      itemList: permissionRequestCubit.statusNames,
                      onChanged: (value) {
                        permissionRequestCubit.selectedStatusBl =
                            permissionRequestCubit.getIdBySubject(value);
                      },
                      hintText: " اختيار",
                    ),
                    /* SelectVacationType(
                      title: "نوع الغياب",
                      itemList: PermissionRequestCubit.statusNames,
                      onChanged: (value) {
                        PermissionRequestCubit.selectedStatusBl =
                            PermissionRequestCubit.getIdBySubject(value);
                      },
                      hintText: " اختيار",
                    ), */
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildTextField(
                      label: "من",
                      /*  hint: "من", */
                      controller:
                          ControllerManager().permissionDateFromController,
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
                              ControllerManager().permissionDateFromController,
                          dateStorageMap: permissionRequestCubit.dateStorageMap,
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
                      controller:
                          ControllerManager().permissionDateToController,
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
                              ControllerManager().permissionDateToController,
                          dateStorageMap: permissionRequestCubit.dateStorageMap,
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
                    BuildTextField(
                      label: "ملاحظات",
                      /*   hint: "ملاحظات", */
                      maxLines: 10,
                      minLines: 3,
                      controller: ControllerManager().permissionNotesController,
                      /*      icon: Icons.local_activity, */
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال ملاحظات";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .permissionNotesController
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .permissionNotesController
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
                        permissionRequestCubit.addVacationRequest();
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
        BlocListener<PermissionRequestCubit, PermissionRequestState>(
          bloc: permissionRequestCubit,
          listener: (context, state) {
            if (state is addPermissionRequestSuccess) {
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
            } else if (state is addPermissionRequestError) {
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
