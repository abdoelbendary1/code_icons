import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class BuildCollectionInfo extends StatelessWidget {
  BuildCollectionInfo({
    super.key,
    required this.controllerManager,
    required this.cubit,
  });
  ControllerManager controllerManager;
  AddCollectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            BuildTextField(
              label: AppLocalizations.of(context)!.registration_Number_label,
              hint: AppLocalizations.of(context)!.registration_Number_hint,
              controller: controllerManager.addCollectionRegisrtyNumController,
              icon: Icons.app_registration,
              readOnly: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال رقم السجل";
                }
                return null;
              },
              onTap: () {
                controllerManager.addCollectionRegisrtyNumController.selection =
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
                            .addCollectionAddressController.value.text.length);
              },
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.registration_Date_label,
              hint: AppLocalizations.of(context)!.registration_Date_hint,
              controller: controllerManager.addCollectionRegistryDateController,
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
                  dateStorageMap: cubit.dateStorageMap,
                  key: "addCollectionRegistryDateController",
                );
              },
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.commercial_activities_label,
              hint: AppLocalizations.of(context)!.commercial_activities_hint,
              controller: controllerManager.addCollectionActivityController,
              icon: Icons.local_activity,
              readOnly: true,
              validator: (value) {
                /*   if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال النشاط";
                } */
                return null;
              },
              onTap: () {
                controllerManager.addCollectionActivityController.selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .addCollectionActivityController.value.text.length);
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
            BuildTextField(
              label: AppLocalizations.of(context)!.phone_Number_label,
              hint: AppLocalizations.of(context)!.phone_Number_hint,
              controller: controllerManager.addCollectionPhoneNumController,
              icon: Icons.phone_iphone,
              keyboardType: TextInputType.number,
              onTap: () {
                controllerManager.addCollectionPhoneNumController.selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerManager
                            .addCollectionPhoneNumController.value.text.length);
              },
            ),
          ],
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
                    focusNode: cubit.divisionFocusNode,
                    controller:
                        controllerManager.addCollectionDivisionController,
                    icon: Icons.diversity_3_sharp,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الشعبه";
                      }
                      return null;
                    },
                    onTap: () {
                      controllerManager
                              .addCollectionDivisionController.selection =
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
                    label: AppLocalizations.of(context)!.compensation_label,
                    hint: AppLocalizations.of(context)!.compensation_hint,
                    controller:
                        controllerManager.addCollectionCompensationController,
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
                              .addCollectionCompensationController.selection =
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
                    label:
                        AppLocalizations.of(context)!.financial_arrears_label,
                    hint: AppLocalizations.of(context)!.financial_arrears_hint,
                    controller:
                        controllerManager.addCollectionLateFinanceController,
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
                              .addCollectionLateFinanceController.selection =
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
                    label: AppLocalizations.of(context)!.current_finance_label,
                    hint: AppLocalizations.of(context)!.current_hint,
                    controller:
                        controllerManager.addCollectionCurrentFinanceController,
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
                              .addCollectionCurrentFinanceController.selection =
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
                    hint: AppLocalizations.of(context)!.finance_Diffrence_hint,
                    controller: controllerManager.addCollectionAdvPayController,
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
                              .addCollectionLatePayController.selection =
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
                    controller:
                        controllerManager.addCollectionLatePayController,
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
                              .addCollectionLatePayController.selection =
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
                    label:
                        AppLocalizations.of(context)!.finance_Diffrence_label,
                    keyboardType: TextInputType.number,
                    hint: AppLocalizations.of(context)!.finance_Diffrence_hint,
                    focusNode: cubit.diffrentFocusNode,
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
                      controllerManager.addCollectionDiffrentFinanaceController
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
                    label: AppLocalizations.of(context)!.total_finance_label,
                    hint: AppLocalizations.of(context)!
                        .enter_your_Total_finance_hint,
                    controller:
                        controllerManager.addCollectionTotalFinanceController,
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
                              .addCollectionTotalFinanceController.selection =
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
    );
  }
}
