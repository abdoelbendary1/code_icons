import 'package:code_icons/presentation/HR/LoanRequest/cubit/Loan_order_cubit.dart';
import 'package:code_icons/presentation/HR/VacationRequest/widgets/SelectStatusType.dart';
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

class LoanRequestScreen extends StatefulWidget {
  LoanRequestScreen({super.key});

  static const routeName = "LoanRequestScreen";

  @override
  State<LoanRequestScreen> createState() => _LoanRequestScreenState();
}

class _LoanRequestScreenState extends State<LoanRequestScreen> {
  /*  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );
 */
  @override
  void initState() {
    super.initState();
    ControllerManager().clearControllers(
        controllers: ControllerManager().loanRequestControllers);
    loanRequestCubit.selectedStatusBl = 1;
  }

  LoanRequestCubit loanRequestCubit = LoanRequestCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "طلب سلفة"),
      extendBody: true,
      body: BlocBuilder<LoanRequestCubit, LoanRequestState>(
        bloc: loanRequestCubit..initialize(),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
                horizontal: 36.w,
              ),
              child: Form(
                key: loanRequestCubit.formKey,
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
                    /*   SizedBox(
                      height: 40.h,
                    ), */
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildTextField(
                      label: "تاريخ بدايه الاقساط",
                      hint: "بداية الاقساط",
                      controller: ControllerManager().loanStartDateController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال بداية الاقساط";
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
                              ControllerManager().loanStartDateController,
                          dateStorageMap: loanRequestCubit.dateStorageMap,
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
                      label: "تاريخ الطلب",
                      hint: "تاريخ الطلب",
                      controller: ControllerManager().loanRequestDateController,
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
                              ControllerManager().loanRequestDateController,
                          dateStorageMap: loanRequestCubit.dateStorageMap,
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
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "عدد الاقساط",
                            hint: "عدد الاقساط",
                            keyboardType: TextInputType.number,
                            controller:
                                ControllerManager().numOfLoanAdvanceController,
                            icon: Icons.attach_money,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الرصيد";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                      .numOfLoanAdvanceController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .numOfLoanAdvanceController
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
                            controller: ControllerManager().loanValueController,
                            icon: Icons.local_activity,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الايام";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                      .loanValueController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .loanValueController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                      ],
                    ),
                    BuildTextField(
                      label: " مدة الاقساط بالايام",
                      keyboardType: TextInputType.number,
                      hint: "المدة  ",
                      controller: ControllerManager().loanDaysController,
                      icon: Icons.local_activity,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال الايام";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager().loanDaysController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .loanDaysController
                                    .value
                                    .text
                                    .length);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SelectStatusType(
                      enabled: false,
                      initialItem: loanRequestCubit.statusNames.first,
                      title: "الحاله",
                      itemList: loanRequestCubit.statusNames,
                      onChanged: (value) {
                        loanRequestCubit.getIdBySubject(value);
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
                      controller: ControllerManager().loanNotesController,
                      /*      icon: Icons.local_activity, */
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال ملاحظات";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager().loanNotesController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .loanNotesController
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
                        loanRequestCubit.addVacationRequest();
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
        BlocListener<LoanRequestCubit, LoanRequestState>(
          bloc: loanRequestCubit,
          listener: (context, state) {
            if (state is addLoanRequestSuccess) {
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
            } else if (state is addLoanRequestError) {
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
