import 'package:code_icons/presentation/HR/HR_Screen.dart';
import 'package:code_icons/presentation/HR/VacationRequest/cubit/vaction_order_cubit.dart';
import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectStatusType.dart';
import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectVacationType.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class VacationOrderScreen extends StatefulWidget {
  VacationOrderScreen({super.key});

  static const routeName = "VacationOrder";

  @override
  State<VacationOrderScreen> createState() => _VacationOrderScreenState();
}

class _VacationOrderScreenState extends State<VacationOrderScreen> {
  /*  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );
 */
  @override
  void initState() {
    super.initState();
    ControllerManager().clearControllers(
        controllers: ControllerManager().vacationRequestControllers);
    vactionOrderCubit.selectedStatusBl = 1;
  }

  VactionOrderCubit vactionOrderCubit = VactionOrderCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "طلب اجازه"),
      extendBody: true,
      body: BlocBuilder<VactionOrderCubit, VactionOrderState>(
        bloc: vactionOrderCubit..initialize(),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
                horizontal: 36.w,
              ),
              child: Form(
                key: vactionOrderCubit.formKey,
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
                    SelectVacationType(
                      title: "نوع الاجازة",
                      itemList: vactionOrderCubit.vacationTypeEntityList,
                      onChanged: (value) {
                        vactionOrderCubit.selectedVacationType = value;
                      },
                      hintText: " اختيار",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildTextField(
                      label: "بداية الاجازه",
                      hint: "بداية الاجازه",
                      controller:
                          ControllerManager().vacationStartDateController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال بداية الاجازه";
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
                              ControllerManager().vacationStartDateController,
                          dateStorageMap: vactionOrderCubit.dateStorageMap,
                          key: "unlimitedPaymentReceitDateController",
                        ).whenComplete(() =>
                            vactionOrderCubit.updateVacationDaysController(
                              startDate: ControllerManager()
                                  .vacationStartDateController
                                  .text,
                              returnDate: ControllerManager()
                                  .vacationReturnDateController
                                  .text,
                            ));

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
                      label: "تاريخ العوده الى العمل",
                      hint: "تاريخ العوده الى العمل",
                      controller:
                          ControllerManager().vacationReturnDateController,
                      icon: Icons.app_registration,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال تاريخ العوده";
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
                              ControllerManager().vacationReturnDateController,
                          dateStorageMap: vactionOrderCubit.dateStorageMap,
                          lastDate: DateTime(2050),
                          key: "unlimitedPaymentReceitDateController",
                        ).whenComplete(() =>
                            vactionOrderCubit.updateVacationDaysController(
                              startDate: ControllerManager()
                                  .vacationStartDateController
                                  .text,
                              returnDate: ControllerManager()
                                  .vacationReturnDateController
                                  .text,
                            ));

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
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "رصيد الاجازه",
                            hint: "رصيد الاجازه",
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
                            label: "عدد الايام",
                            keyboardType: TextInputType.number,
                            hint: "عدد الايام",
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
                    SizedBox(
                      height: 20.h,
                    ),
                    SelectStatusType(
                      enabled: false,
                      initialItem: vactionOrderCubit.statusNames.first,
                      title: "الحاله",
                      itemList: vactionOrderCubit.statusNames,
                      onChanged: (value) {
                        vactionOrderCubit.getIdBySubject(value);
                      },
                      hintText: " اختيار",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildTextField(
                      label: "ملاحظات",
                      /*   hint: "ملاحظات", */
                      maxLines: 10,
                      minLines: 3,
                      controller: ControllerManager().vacationNotesController,
                      /*      icon: Icons.local_activity, */
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال ملاحظات";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager().vacationNotesController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .vacationNotesController
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
                        vactionOrderCubit.addVacationRequest();
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
        BlocListener<VactionOrderCubit, VactionOrderState>(
          bloc: vactionOrderCubit,
          listener: (context, state) {
            if (state is addVacationRequestSuccess) {
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
            } else if (state is addVacationRequestError) {
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
