import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/collections_screen.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/years_of_payment_grid_view.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CollectionDetailsForm extends StatefulWidget {
  const CollectionDetailsForm({super.key});

  @override
  State<CollectionDetailsForm> createState() => _CollectionDetailsFormState();
}

class _CollectionDetailsFormState extends State<CollectionDetailsForm> {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
    fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
    fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
    postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
    paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase(),
  );

  final addCollectionControllers = ControllerManager().addCollectionControllers;
  ControllerManager controllerManager = ControllerManager();
  @override
  void initState() {
    super.initState();

    // Add focus listener to the division focus node
    addCollectionCubit.divisionFocusNode.addListener(() {
      if (!addCollectionCubit.divisionFocusNode.hasFocus) {
        // Call recalculateTotal when focus is lost
        addCollectionCubit.recalculateTotal(
            context.read<AddCollectionCubit>().paymentValuesEntity);
      }
    });

    // Add focus listener to other focus nodes as needed
    addCollectionCubit.diffrentFocusNode.addListener(() {
      if (!addCollectionCubit.diffrentFocusNode.hasFocus) {
        // Call recalculateTotal when focus is lost
        addCollectionCubit.recalculateTotal(
            context.read<AddCollectionCubit>().paymentValuesEntity);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addCollectionCubit.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                BuildTextField(
                  label: AppLocalizations.of(context)!.phone_Number_label,
                  hint: AppLocalizations.of(context)!.phone_Number_hint,
                  controller: controllerManager.addCollectionPhoneNumController,
                  icon: Icons.phone_iphone,
                  keyboardType: TextInputType.number,
                  /*  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال رقم الموبايل";
                    }
                    return null;
                  }, */
                  onTap: () {
                    controllerManager
                            .addCollectionPhoneNumController.selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: controllerManager
                                .addCollectionPhoneNumController
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label:
                      AppLocalizations.of(context)!.registration_Number_label,
                  hint: AppLocalizations.of(context)!.registration_Number_hint,
                  controller:
                      controllerManager.addCollectionRegisrtyNumController,
                  icon: Icons.app_registration,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال رقم السجل";
                    }
                    return null;
                  },
                  onTap: () {
                    controllerManager
                            .addCollectionRegisrtyNumController.selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: controllerManager
                                .addCollectionRegisrtyNumController
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label: AppLocalizations.of(context)!.address_label,
                  hint: AppLocalizations.of(context)!.address_hint,
                  controller: controllerManager.addCollectionAddressController,
                  icon: Icons.home,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال العنوان";
                    }
                    return null;
                  },
                  onTap: () {
                    controllerManager.addCollectionAddressController.selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: controllerManager
                                .addCollectionAddressController
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label: AppLocalizations.of(context)!.registration_Date_label,
                  hint: AppLocalizations.of(context)!.registration_Date_hint,
                  controller:
                      controllerManager.addCollectionRegistryDateController,
                  icon: Icons.app_registration,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال تاريخ السجل";
                    }
                    return null;
                  },
                  onTap: () {
                    AppDatePicker.selectDate(
                      context: context,
                      controller:
                          controllerManager.addCollectionRegistryDateController,
                      dateStorageMap: addCollectionCubit.dateStorageMap,
                      key: "addCollectionRegistryDateController",
                    );
                  },
                ),
                BuildTextField(
                  label:
                      AppLocalizations.of(context)!.commercial_activities_label,
                  hint:
                      AppLocalizations.of(context)!.commercial_activities_hint,
                  controller: controllerManager.addCollectionActivityController,
                  icon: Icons.local_activity,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال النشاط";
                    }
                    return null;
                  },
                  onTap: () {
                    controllerManager
                            .addCollectionActivityController.selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: controllerManager
                                .addCollectionActivityController
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label: "رقم الايصال",
                  hint: "رقم الايصال",
                  controller:
                      controllerManager.addCollectionPaymentReceitController,
                  icon: Icons.local_activity,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال رقم الايصال";
                    } else if (int.parse(value) >
                            context
                                    .read<AddCollectionCubit>()
                                    .selectedReceit
                                    .paperNum! +
                                context
                                    .read<AddCollectionCubit>()
                                    .selectedReceit
                                    .totalPapers! &&
                        int.parse(value) >
                            context
                                .read<AddCollectionCubit>()
                                .selectedReceit
                                .paperNum!) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: "يجب ادخال رقم الايصال داخل الدفتر الحالي",
                          titleColor: AppColors.redColor);
                      return "يجب ادخال رقم الايصال داخل الدفتر الحالي";
                    }
                    return null;
                  },
                  onTap: () {
                    controllerManager
                            .addCollectionPaymentReceitController.selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: controllerManager
                                .addCollectionPaymentReceitController
                                .value
                                .text
                                .length);
                  },
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: AppLocalizations.of(context)!.division_label,
                            hint: AppLocalizations.of(context)!.division_hint,
                            keyboardType: TextInputType.number,
                            focusNode: addCollectionCubit.divisionFocusNode,
                            controller: controllerManager
                                .addCollectionDivisionController,
                            icon: Icons.diversity_3_sharp,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الشعبه";
                              }
                              return null;
                            },
                            onTap: () {
                              controllerManager.addCollectionDivisionController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionDivisionController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: AppLocalizations.of(context)!
                                .compensation_label,
                            hint:
                                AppLocalizations.of(context)!.compensation_hint,
                            controller: controllerManager
                                .addCollectionCompensationController,
                            icon: Icons.attach_money,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال التعويض";
                              }
                              return null;
                            },
                            onTap: () {
                              controllerManager
                                      .addCollectionCompensationController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionCompensationController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: AppLocalizations.of(context)!
                                .financial_arrears_label,
                            hint: AppLocalizations.of(context)!
                                .financial_arrears_hint,
                            controller: controllerManager
                                .addCollectionLateFinanceController,
                            icon: Icons.attach_money,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال المتأخر";
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () {
                              controllerManager
                                      .addCollectionLateFinanceController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionLateFinanceController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: AppLocalizations.of(context)!
                                .current_finance_label,
                            hint: AppLocalizations.of(context)!.current_hint,
                            controller: controllerManager
                                .addCollectionCurrentFinanceController,
                            icon: Icons.attach_money,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الحالي";
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () {
                              controllerManager
                                      .addCollectionCurrentFinanceController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionCurrentFinanceController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: "سداد مقدم",
                            keyboardType: TextInputType.number,
                            hint: AppLocalizations.of(context)!
                                .finance_Diffrence_hint,
                            controller:
                                controllerManager.addCollectionAdvPayController,
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
                              controllerManager.addCollectionLatePayController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionAdvPayController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: "مديونية",
                            hint: AppLocalizations.of(context)!
                                .enter_your_Total_finance_hint,
                            controller: controllerManager
                                .addCollectionLatePayController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الاجمالي";
                              }
                              return null;
                            },
                            icon: Icons.money,
                            onTap: () {
                              controllerManager.addCollectionLatePayController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionLatePayController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            label: AppLocalizations.of(context)!
                                .finance_Diffrence_label,
                            keyboardType: TextInputType.number,
                            hint: AppLocalizations.of(context)!
                                .finance_Diffrence_hint,
                            focusNode: addCollectionCubit.diffrentFocusNode,
                            controller: controllerManager
                                .addCollectionDiffrentFinanaceController,
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
                              controllerManager
                                      .addCollectionDiffrentFinanaceController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionDiffrentFinanaceController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                        Expanded(
                          child: BuildTextField(
                            label: AppLocalizations.of(context)!
                                .total_finance_label,
                            hint: AppLocalizations.of(context)!
                                .enter_your_Total_finance_hint,
                            controller: controllerManager
                                .addCollectionTotalFinanceController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الاجمالي";
                              }
                              return null;
                            },
                            icon: Icons.money,
                            onTap: () {
                              controllerManager
                                      .addCollectionTotalFinanceController
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controllerManager
                                          .addCollectionTotalFinanceController
                                          .value
                                          .text
                                          .length);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppLocalizations.of(context)!.years_of_Payment,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<AddCollectionCubit, AddCollectionState>(
                  bloc: addCollectionCubit,
                  builder: (context, state) {
                    if (state is YearsUpdatedState) {
                      return YearsOfPaymentGridView(
                        addCollectionCubit: addCollectionCubit,
                      );
                    }
                    return YearsOfPaymentGridView(
                      addCollectionCubit: addCollectionCubit,
                    );
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                BlocListener<AddCollectionCubit, AddCollectionState>(
                  bloc: addCollectionCubit,
                  listener: (context, state) {
                    if (state is AddCollectionSucces) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                      Navigator.pushNamed(
                        context,
                        CollectionsScreen.routeName,
                        arguments: context
                            .read<HomeScreenViewModel>()
                            .menus['collections']
                            ?.items,
                      );
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        /* showConfirmBtn: false,
                        confirmBtnText: "الذهاب الى الصفحه الرئيسيه", */
                        title: "تمت الإضافه بنجاح",
                        titleColor: AppColors.lightBlueColor,
                        /*   onConfirmBtnTap: () {}, */
                      );
                    } else if (state is AddCollectionError) {
                      if (context
                          .read<AddCollectionCubit>()
                          .yearsOfRepaymentBL
                          .isEmpty) {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: "يجب اضافه سنوات السداد",
                          titleColor: AppColors.redColor,
                        );
                      } else {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: state.errorMsg,
                          titleColor: AppColors.redColor,
                        );
                      }
                    }
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                        foregroundColor: AppColors.whiteColor,
                        backgroundColor: AppColors.blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    /*  onPressed: () async {
                      if (addCollectionCubit.formKey.currentState!.validate()) {
                        if (mounted) {
                          CustomerDataEntity selectedCustomer = context
                              .read<AddCollectionCubit>()
                              .selectedCustomer;
                          var tradeCollectionRequest = context
                              .read<AddCollectionCubit>()
                              .intializeTradeRequest(
                                  selectedCustomer: selectedCustomer,
                                  context: context);
                          await addCollectionCubit.postTradeCollection(
                              token: "token",
                              tradeCollectionRequest: tradeCollectionRequest,
                              context: context);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "برجاء ادخال جميع البيانات",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        ));
                      }
                    }, */
                    onPressed: context
                            .read<AddCollectionCubit>()
                            .isButtonEnabled
                        ? () async {
                            // Immediately disable the button
                            var cubit = context.read<AddCollectionCubit>();
                            if (!cubit.isButtonEnabled)
                              return; // Prevent double execution
                            cubit.isButtonEnabled = false;

                            if (addCollectionCubit.formKey.currentState!
                                .validate()) {
                              try {
                                if (mounted) {
                                  CustomerDataEntity selectedCustomer =
                                      cubit.selectedCustomer;
                                  var tradeCollectionRequest =
                                      cubit.intializeTradeRequest(
                                    selectedCustomer: selectedCustomer,
                                    context: context,
                                  );

                                  await addCollectionCubit.postTradeCollection(
                                    token: "token",
                                    tradeCollectionRequest:
                                        tradeCollectionRequest,
                                    context: context,
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "An error occurred: $e",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    backgroundColor: AppColors.redColor,
                                    duration: Durations.extralong1,
                                  ));
                                }
                              } finally {
                                if (mounted) {
                                  cubit.isButtonEnabled =
                                      true; // Re-enable the button
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "برجاء ادخال جميع البيانات",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                backgroundColor: AppColors.redColor,
                                duration: Durations.extralong1,
                              ));
                              cubit.isButtonEnabled =
                                  true; // Re-enable if validation fails
                            }
                          }
                        : null,
// Disable the button if isButtonEnabled is false
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
