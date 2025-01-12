// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/presentation/home/cubit/home_screen_view_model_cubit.dart';
import 'package:code_icons/presentation/home/home_screen.dart';

import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/controller/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/controller/cubit/unlimited_collection_state.dart';
import 'package:code_icons/trade_chamber/view/collections_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

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
        injectFetchAllUnRegisteredCollectionsUseCase(),
    authManager: injectAuthManagerInterface(),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ControllerManager().clearControllers(
          controllers: ControllerManager().unRegestriedCollectionControllers);
      unlimitedCollectionCubit.paymentReceipt =
          unlimitedCollectionCubit.storedPaymentReceipt;
      ControllerManager().unlimitedPaymentReceitDateController.text =
          DateFormat('MMM d, y, h:mm:ss a').format(DateTime.now());
      ControllerManager().unlimitedCurrentFinanceController.text = "0";
    });
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
                keyboardType: TextInputType.number,
                controller: ControllerManager()
                    .getControllerByName('unlimitedPaymentReceiptController'),
                icon: Icons.phone_iphone,
                onTap: () {
                  ControllerManager()
                          .getControllerByName('unlimitedPaymentReceiptController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'unlimitedPaymentReceiptController')
                              .value
                              .text
                              .length);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال رقم الايصال";
                  } else if (int.parse(value) >
                          unlimitedCollectionCubit.selectedReceit.paperNum! +
                              unlimitedCollectionCubit
                                  .selectedReceit.totalPapers! &&
                      int.parse(value) >
                          unlimitedCollectionCubit.selectedReceit.paperNum!) {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        showConfirmBtn: false,
                        title: "يجب ادخال رقم الايصال داخل الدفتر الحالي",
                        titleColor: AppColors.redColor);
                    return "يجب ادخال رقم الايصال داخل الدفتر الحالي";
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
                  bloc: unlimitedCollectionCubit
                    ..initialize(
                        controller: 'unlimitedPaymentReceiptController',
                        context: context),
                  listener: (context, state) {
                    if (state is AddUnlimitedCollectionSuccess) {
                      /*   DialogUtils.showLoading(context: context, message: "");
                      DialogUtils.hideLoading(context); */
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
                        showConfirmBtn: false,
                        confirmBtnText: "الذهاب الى الصفحه الرئيسيه",
                        title: "تمت الإضافه بنجاح",
                        titleColor: AppColors.lightBlueColor,
                        /*   onConfirmBtnTap: () {}, */
                      );
                      /*  DialogUtils.showMessage(
                        context: context,
                        barrierDismissible: true,
                        message: "",
                        posActionName: "تأكيد",
                        posAction: () {
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        },
                        title: "تمت الإضافه بنجاح",
                      ); */
                      /*  SnackBarUtils.showSnackBar(
                        context: context,
                        label: "تمت الإضافه بنجاح",
                        backgroundColor: AppColors.greenColor,
                      ); */
                    } else if (state is AddUnlimitedCollectionError) {
                      if (state.errorMsg.contains("400") ||
                          state.errorMsg.contains("401") ||
                          state.errorMsg.contains("403")) {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: state.errorMsg,
                          titleColor: AppColors.redColor,
                        );
                        /*  DialogUtils.showMessage(
                            context: context,
                            message: "برجاء ادخال البيانات صحيحه"); */
                        /* SnackBarUtils.showSnackBar(
                          context: context,
                          label: "برجاء ادخال البيانات صحيحه",
                          backgroundColor: AppColors.redColor,
                        ); */

                        print(state.errorMsg);
                      } else if (state.errorMsg.contains("500")) {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: state.errorMsg,
                          titleColor: AppColors.redColor,
                        );
                        /*   DialogUtils.showMessage(
                            context: context, message: "حدث خطأ ما"); */
                        /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "حدث خطأ ما",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        )); */
                        print(state.errorMsg);
                      } else {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: state.errorMsg,
                          titleColor: AppColors.redColor,
                        );
                        /* DialogUtils.showMessage(
                            context: context,
                            message: "تأكد من اتصالك بالانترنت"); */
                        /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "تأكد من اتصالك بالانترنت",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        )); */
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
                        if (unlimitedCollectionCubit.formKey.currentState!
                            .validate()) {
                          DialogUtils.showLoading(
                              context: context, message: "");
                          unlimitedCollectionCubit
                              .addCustomer(context)
                              .whenComplete(
                                  () => DialogUtils.hideLoading(context));
                        }
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