// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/all_daily_collector_screen.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_state.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/unRegistered_collections.dart';

import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnlimitedCollectionDetailsForm extends StatefulWidget {
  UnlimitedCollectionDetailsForm({super.key});

  @override
  State<UnlimitedCollectionDetailsForm> createState() =>
      _UnlimitedCollectionDetailsFormState();
}

class _UnlimitedCollectionDetailsFormState
    extends State<UnlimitedCollectionDetailsForm> {
  UnlimitedCollectionCubit unlimitedCollectionCubit = UnlimitedCollectionCubit(
    postUnRegisteredTradeCollectionUseCase:
        injectPostUnRegisteredTradeCollectionUseCase(),
    getUnRegisteredTradeCollectionUseCase:
        injectGetUnRegisteredTradeCollectionUseCase(),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ControllerManager().clearControllers(
        controllers: ControllerManager().unRegestriedCollectionControllers);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: unlimitedCollectionCubit.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildTextField(
              label: "الاسم التجارى",
              hint: "الاسم التجارى",
              controller: ControllerManager()
                  .getControllerByName('unlimitedNameController'),
              icon: Icons.phone_iphone,
              onTap: () {
                ControllerManager()
                        .getControllerByName('unlimitedNameController')
                        .selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .getControllerByName('unlimitedNameController')
                            .value
                            .text
                            .length);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال الاسم التجارى";
                }
                return null;
              },
            ),
            BuildTextField(
              label: "النشاط ",
              hint: "النشاط",
              controller: ControllerManager()
                  .getControllerByName('unlimitedActivityController'),
              icon: Icons.phone_iphone,
              onTap: () {
                ControllerManager()
                        .getControllerByName('unlimitedActivityController')
                        .selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .getControllerByName('unlimitedActivityController')
                            .value
                            .text
                            .length);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال النشاط";
                }
                return null;
              },
            ),
            BuildTextField(
                label: AppLocalizations.of(context)!.address_label,
                hint: AppLocalizations.of(context)!.address_hint,
                controller: ControllerManager()
                    .getControllerByName('unlimitedAddressController'),
                icon: Icons.phone_iphone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال العنوان";
                  }
                  return null;
                },
                onTap: () {
                  ControllerManager()
                          .getControllerByName('unlimitedAddressController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName('unlimitedAddressController')
                              .value
                              .text
                              .length);
                }),
            BuildTextField(
                label: "رقم الايصال ",
                hint: "رقم الايصال ",
                controller: ControllerManager()
                    .getControllerByName('unlimitedPaymentReceitController'),
                icon: Icons.phone_iphone,
                onTap: () {
                  ControllerManager()
                          .getControllerByName('unlimitedPaymentReceitController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'unlimitedPaymentReceitController')
                              .value
                              .text
                              .length);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال رقم الايصال";
                  }
                  return null;
                }),
            BuildTextField(
              label: "تاريخ الايصال",
              hint: "تاريخ الايصال",
              controller: ControllerManager()
                  .getControllerByName('unlimitedPaymentReceitDateController'),
              readOnly: true,
              icon: Icons.phone_iphone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال تاريخ الايصال";
                }
                return null;
              },
              onTap: () {
                AppDatePicker.selectDate(
                  context: context,
                  controller: ControllerManager().getControllerByName(
                      'unlimitedPaymentReceitDateController'),
                  dateStorageMap: unlimitedCollectionCubit.dateStorageMap,
                  key: "unlimitedPaymentReceitDateController",
                );
                /*   _selectDate(
                  context: context,
                  controller: ControllerManager()
                      .getControllerByName('unlimitedPaymentReceiptDate'),
                  dateStorageMap: unlimitedCollectionCubit.dateStorageMap,
                  key: "licenseDateBL",
                ); */
              },
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextField(
                      label: "الشعبه ",
                      hint: "الشعبه ",
                      controller: ControllerManager()
                          .getControllerByName('unlimitedDivisionController'),
                      icon: Icons.phone_iphone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال سنه الشعبه";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .getControllerByName('unlimitedDivisionController')
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .getControllerByName(
                                        'unlimitedDivisionController')
                                    .value
                                    .text
                                    .length);
                      }),
                ),
                Expanded(
                  child: BuildTextField(
                      label: "حالي ",
                      hint: "حالي ",
                      controller: ControllerManager().getControllerByName(
                          'unlimitedCurrentFinanceController'),
                      icon: Icons.phone_iphone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال الحالي";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .getControllerByName(
                                    'unlimitedCurrentFinanceController')
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .getControllerByName(
                                        'unlimitedCurrentFinanceController')
                                    .value
                                    .text
                                    .length);
                      }),
                ),
              ],
            ),
            BuildTextField(
                readOnly: true,
                label: "الاجمالي",
                hint: "الاجمالي",
                controller: ControllerManager()
                    .getControllerByName('unlimitedTotalFinanceController'),
                icon: Icons.phone_iphone,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال الاجمالي";
                  }
                  return null;
                },
                onTap: () {
                  /*  ControllerManager()
                          .getControllerByName('unlimitedTotalFinanceController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'unlimitedTotalFinanceController')
                              .value
                              .text
                              .length); */
                }),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Spacer(),
                BlocListener<UnlimitedCollectionCubit,
                    UnlimitedCollectionState>(
                  bloc: unlimitedCollectionCubit,
                  listener: (context, state) {
                    if (state is AddUnlimitedCollectionSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "تمت الإضافه بنجاح",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: AppColors.greenColor,
                        duration: Durations.extralong1,
                      ));
                      Navigator.pushReplacementNamed(
                          context, UnRegisteredCollectionsScreen.routeName);
                    } else if (state is AddUnlimitedCollectionError) {
                      if (state.errorMsg.contains("400")) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "برجاء ادخال البيانات صحيحه",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        ));
                        print(state.errorMsg);
                      } else if (state.errorMsg.contains("500")) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "حدث خطأ ما",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        ));
                        print(state.errorMsg);
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
                      onPressed: () async {
                        unlimitedCollectionCubit.addCustomer(context);
                      },
                      child: Text(AppLocalizations.of(context)!.save),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
