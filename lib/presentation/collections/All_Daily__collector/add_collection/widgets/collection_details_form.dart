// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/all_daily_collector_screen.dart';
import 'package:code_icons/presentation/collections/collections_screen.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_Custom_TextField.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/years_of_payment_grid_view.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CollectionDetailsForm extends StatefulWidget {
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

  /*  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  } */

  /*  @override
  void didUpdateWidget(covariant CollectionDetailsForm oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
 */
  @override
  void dispose() {
    // Perform any cleanup before navigating
    /*  Future.delayed(Duration.zero, () {
      if (mounted) {
        Navigator.pushReplacementNamed(
            context, AllDailyCollectorScreen.routeName);
      }
    }); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addCollectionCubit.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        /* padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h), */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  BlocBuilder<AddCollectionCubit, AddCollectionState>(
              bloc: addCollectionCubit,
              builder: (context, state) {
                return Accordion(
                  paddingBetweenClosedSections: 20,
                  disableScrolling: true,
                  scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                  contentBorderWidth: 0,
                  contentBackgroundColor: Colors.transparent,
                  headerBackgroundColorOpened: AppColors.greenColor,
                  maxOpenSections: 1,
                  headerBackgroundColor: AppColors.blueColor,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  children: [
                    AccordionSection(
                        header: Text(
                          "بيانات الحافظه",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20.sp),
                        ),
                        content: Container())
                  ],
                );
              },
            ), */
            Column(
              children: [
                BuildTextField(
                  label: AppLocalizations.of(context)!.phone_Number_label,
                  hint: AppLocalizations.of(context)!.phone_Number_hint,
                  controller: ControllerManager()
                      .getControllerByName('addCollectionPhoneNumController'),
                  icon: Icons.phone_iphone,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال رقم الموبايل";
                    }
                    return null;
                  },
                  onTap: () {
                    ControllerManager()
                            .getControllerByName('addCollectionPhoneNumController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName(
                                    'addCollectionPhoneNumController')
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label:
                      AppLocalizations.of(context)!.registration_Number_label,
                  hint: AppLocalizations.of(context)!.registration_Number_hint,
                  controller: ControllerManager().getControllerByName(
                      'addCollectionRegisrtyNumController'),
                  icon: Icons.app_registration,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال رقم السجل";
                    }
                    return null;
                  },
                  onTap: () {
                    ControllerManager()
                            .getControllerByName(
                                'addCollectionRegisrtyNumController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName(
                                    'addCollectionRegisrtyNumController')
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label: AppLocalizations.of(context)!.address_label,
                  hint: AppLocalizations.of(context)!.address_hint,
                  controller: ControllerManager()
                      .getControllerByName('addCollectionAddressController'),
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
                            .getControllerByName('addCollectionAddressController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName(
                                    'addCollectionAddressController')
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label: AppLocalizations.of(context)!.registration_Date_label,
                  hint: AppLocalizations.of(context)!.registration_Date_hint,
                  controller: ControllerManager().getControllerByName(
                      'addCollectionRegistryDateController'),
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
                            .getControllerByName(
                                'addCollectionRegistryDateController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName(
                                    'addCollectionRegistryDateController')
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label:
                      AppLocalizations.of(context)!.commercial_activities_label,
                  hint:
                      AppLocalizations.of(context)!.commercial_activities_hint,
                  controller: ControllerManager()
                      .getControllerByName('addCollectionActivityController'),
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
                            .getControllerByName('addCollectionActivityController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName(
                                    'addCollectionActivityController')
                                .value
                                .text
                                .length);
                  },
                ),
                BuildTextField(
                  label: "رقم الايصال",
                  hint: "رقم الايصال",
                  controller: ControllerManager().getControllerByName(
                      'addCollectionPaymentReceitController'),
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
                            .getControllerByName(
                                'addCollectionPaymentReceitController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName(
                                    'addCollectionPaymentReceitController')
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
                            controller: ControllerManager().getControllerByName(
                                'addCollectionDivisionController'),
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
                                      .getControllerByName(
                                          'addCollectionDivisionController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'addCollectionDivisionController')
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
                            controller: ControllerManager().getControllerByName(
                                'addCollectionCompensationController'),
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
                                      .getControllerByName(
                                          'addCollectionCompensationController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'addCollectionCompensationController')
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
                            controller: ControllerManager().getControllerByName(
                                'addCollectionLateFinanceController'),
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
                                      .getControllerByName(
                                          'addCollectionLateFinanceController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'addCollectionLateFinanceController')
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
                            controller: ControllerManager().getControllerByName(
                                'addCollectionCurrentFinanceController'),
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
                                      .getControllerByName(
                                          'addCollectionCurrentFinanceController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'addCollectionCurrentFinanceController')
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
                            controller: ControllerManager().getControllerByName(
                                'addCollectionDiffrentFinanaceController'),
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
                                      .getControllerByName(
                                          'addCollectionDiffrentFinanaceController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'addCollectionDiffrentFinanaceController')
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
                            controller: ControllerManager().getControllerByName(
                                'addCollectionTotalFinanceController'),
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
                                      .getControllerByName(
                                          'addCollectionTotalFinanceController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'addCollectionTotalFinanceController')
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
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
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
                      /*  DialogUtils.showMessage(
                          context: context, message: "تمت الإضافه بنجاح");
                      /*   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "تمت الإضافه بنجاح",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: AppColors.greenColor,
                        duration: Durations.extralong1,
                      )); */
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName); */
                      /* Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                       */
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
                        /*   DialogUtils.showMessage(
                            context: context,
                            message: "يجب اضافه سنوات السداد"); */
                        /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "يجب اضافه سنوات السداد",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        )); */
                      } else {
                        QuickAlert.show(
                          animType: QuickAlertAnimType.slideInUp,
                          context: context,
                          type: QuickAlertType.error,
                          showConfirmBtn: false,
                          title: "حدث خطأ ما",
                          titleColor: AppColors.redColor,
                        );
                        /*  DialogUtils.showMessage(
                            context: context, message: "حدث خطأ ما"); */
                        /*    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "حدث خطأ ما",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        )); */
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
                    onPressed: () async {
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
                          /*  .whenComplete(() =>
                                  Navigator.pushReplacementNamed(context,
                                      AllDailyCollectorScreen.routeName)); */
                        }
                      }
                    },
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
