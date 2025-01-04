import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(
    fetchEmployeeDataByIDUseCase: injectFetchEmployeeDataByIDUseCase(),
  );

  @override
  void initState() {
    super.initState();
    homeScreenViewModel.authManager.getUser();

    /*  ControllerManager()
        .clearControllers(controllers: ControllerManager().employeeControllers); */
    /*  homeScreenViewModel.fetchEmployeeDataByID(
        id: context.read<HomeScreenViewModel>().user!.id!); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 120.h, left: 36.w, right: 36.w, top: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "بيانات الموظف",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor.withOpacity(0.8),
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    const Text(
                      "تفاصيل بيانات الموظف",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<HomeScreenViewModel, HomeScreenViewModelState>(
                bloc: homeScreenViewModel..fetchEmployeeDataByID(),
                builder: (context, state) {
                  if (state is GetEmployeeDataLoading) {
                    return Align(
                        alignment: Alignment.center,
                        child: LoadingStateAnimation());
                  }
                  return Column(
                    children: [
                      BuildTextField(
                        label: "الاسم",
                        hint: "الاسم",
                        controller: ControllerManager().employeeNameController,
                        icon: Icons.app_registration,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الاسم";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager().employeeNameController.selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeNameController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "الكود",
                        hint: "الكود",
                        controller: ControllerManager().employeeCodeController,
                        icon: Icons.phone_iphone,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الكود";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager().employeeCodeController.selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeCodeController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "الرقم القومي",
                        hint: "الرقم القومي",
                        controller:
                            ControllerManager().employeeNationalIdController,
                        icon: Icons.home,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال العنوان";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .employeeNationalIdController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeNationalIdController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "رقم الهاتف",
                        hint: "رقم الهاتف",
                        controller:
                            ControllerManager().employeePhoneNumberController,
                        icon: Icons.attach_money,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الحالي";
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () {
                          ControllerManager()
                                  .employeePhoneNumberController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeePhoneNumberController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "العنوان",
                        hint: "العنوان",
                        controller:
                            ControllerManager().employeeAddressController,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الاجمالي";
                          }
                          return null;
                        },
                        icon: Icons.money,
                        onTap: () {
                          ControllerManager()
                                  .employeeAddressController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeAddressController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "الوظيفه",
                        hint: "الوظيفه",
                        controller:
                            ControllerManager().employeeJobTitleController,
                        icon: Icons.app_registration,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال تاريخ السجل";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .employeeJobTitleController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeJobTitleController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "القسم",
                        hint: "القسم",
                        controller:
                            ControllerManager().employeeDepartmentController,
                        icon: Icons.local_activity,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال النشاط";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .employeeDepartmentController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeDepartmentController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "المؤهل العلمي",
                        hint: "المؤهل العلمي",
                        controller:
                            ControllerManager().employeeEducationController,
                        icon: Icons.local_activity,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال النشاط";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .employeeEducationController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeEducationController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      BuildTextField(
                        label: "اسم المؤهل",
                        hint: "اسم المؤهل",
                        keyboardType: TextInputType.number,
                        controller:
                            ControllerManager().employeeEducationNameController,
                        icon: Icons.diversity_3_sharp,
                        /* readOnly: true, */
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الشعبه";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .employeeEducationNameController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeEducationNameController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BuildTextField(
                              label: "النوع",
                              hint: "النوع",
                              controller:
                                  ControllerManager().employeeGenderController,
                              icon: Icons.attach_money,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يجب ادخال التعويض";
                                }
                                return null;
                              },
                              onTap: () {
                                ControllerManager()
                                        .employeeGenderController
                                        .selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
                                            .employeeGenderController
                                            .value
                                            .text
                                            .length);
                              },
                            ),
                          ),
                          Expanded(
                            child: BuildTextField(
                              label: "الحاله الاجتماعيه",
                              hint: "الحاله الاجتماعيه",
                              controller: ControllerManager()
                                  .employeeSocialStatusController,
                              icon: Icons.attach_money,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يجب ادخال المتأخر";
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: () {
                                ControllerManager()
                                        .employeeSocialStatusController
                                        .selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
                                            .employeeSocialStatusController
                                            .value
                                            .text
                                            .length);
                              },
                            ),
                          ),
                        ],
                      ),
                      BuildTextField(
                        label: "ت.العمل",
                        keyboardType: TextInputType.number,
                        hint: "ت.العمل",
                        controller:
                            ControllerManager().employeeWorkStartDateController,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال المتنوع";
                          }
                          return null;
                        },
                        readOnly: false,
                        icon: Icons.add_to_photos_sharp,
                        onTap: () {
                          ControllerManager()
                                  .employeeWorkStartDateController
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .employeeWorkStartDateController
                                      .value
                                      .text
                                      .length);
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
