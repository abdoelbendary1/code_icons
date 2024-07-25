// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/all_daily_collector_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_Custom_TextField.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/years_of_payment_grid_view.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionDetailsForm extends StatelessWidget {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
    fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
    fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
    postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
    paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase(),
  );

  final addCollectionControllers = ControllerManager().addCollectionControllers;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildTextField(
              label: AppLocalizations.of(context)!.phone_Number_label,
              hint: AppLocalizations.of(context)!.phone_Number_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionPhoneNumController'),
              icon: Icons.phone_iphone,
              readOnly: true,
             onTap: () { ControllerManager()
                      .getControllerByName('addCollectionPhoneNumController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionPhoneNumController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.address_label,
              hint: AppLocalizations.of(context)!.address_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionAddressController'),
              icon: Icons.home,
              readOnly: true,
              onTap: () { ControllerManager()
                      .getControllerByName('addCollectionAddressController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionAddressController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.registration_Number_label,
              hint: AppLocalizations.of(context)!.registration_Number_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionRegisrtyNumController'),
              icon: Icons.app_registration,
              readOnly: true,
             onTap: () { ControllerManager()
                      .getControllerByName('addCollectionRegisrtyNumController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionRegisrtyNumController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.registration_Date_label,
              hint: AppLocalizations.of(context)!.registration_Date_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionRegistryDateController'),
              icon: Icons.app_registration,
              readOnly: true,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionRegistryDateController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionRegistryDateController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.commercial_activities_label,
              hint: AppLocalizations.of(context)!.commercial_activities_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionActivityController'),
              icon: Icons.local_activity,
              readOnly: true,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionActivityController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionActivityController')
                          .value
                          .text
                          .length);},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                AppLocalizations.of(context)!.years_of_Payment,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor, fontWeight: FontWeight.w600),
              ),
            ),
            YearsOfPaymentGridView(
              addCollectionCubit: addCollectionCubit,
            ),
            SizedBox(height: 25.h),
            BuildTextField(
              label: AppLocalizations.of(context)!.payment_receipt_number_label,
              hint: AppLocalizations.of(context)!.payment_receipt_number_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionPaymentReceitController'),
              icon: Icons.receipt,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionPaymentReceitController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionPaymentReceitController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.division_label,
              hint: AppLocalizations.of(context)!.division_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionDivisionController'),
              icon: Icons.diversity_3_sharp,
              readOnly: true,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionDivisionController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionDivisionController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.compensation_label,
              hint: AppLocalizations.of(context)!.compensation_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionCompensationController'),
              icon: Icons.attach_money,
              readOnly: true,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionCompensationController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionCompensationController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.financial_arrears_label,
              hint: AppLocalizations.of(context)!.financial_arrears_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionLateFinanceController'),
              icon: Icons.attach_money,
              readOnly: true,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionLateFinanceController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionLateFinanceController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.current_finance_label,
              hint: AppLocalizations.of(context)!.current_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionCurrentFinanceController'),
              icon: Icons.attach_money,
              readOnly: true,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionCurrentFinanceController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionCurrentFinanceController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.finance_Diffrence_label,
              hint: AppLocalizations.of(context)!.finance_Diffrence_hint,
              controller: ControllerManager().getControllerByName(
                  'addCollectionDiffrentFinanaceController'),
              onChanged: (value) {},
              readOnly: false,
              icon: Icons.add_to_photos_sharp,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionDiffrentFinanaceController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionDiffrentFinanaceController')
                          .value
                          .text
                          .length);},
            ),
            BuildTextField(
              label: AppLocalizations.of(context)!.total_finance_label,
              hint: AppLocalizations.of(context)!.enter_your_Total_finance_hint,
              controller: ControllerManager()
                  .getControllerByName('addCollectionTotalFinanceController'),
              readOnly: true,
              icon: Icons.money,
               onTap: () { ControllerManager()
                      .getControllerByName('addCollectionTotalFinanceController')
                      .selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: ControllerManager()
                          .getControllerByName('addCollectionTotalFinanceController')
                          .value
                          .text
                          .length);},
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Spacer(),
                BlocListener<AddCollectionCubit, AddCollectionState>(
                  bloc: addCollectionCubit,
                  listener: (context, state) {
                    if (state is AddCollectionSucces) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "تمت الإضافه بنجاح",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: AppColors.greenColor,
                        duration: Durations.extralong1,
                      ));
                      Navigator.pushReplacementNamed(
                          context, AllDailyCollectorScreen.routeName);
                    } else if (state is AddCollectionError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "حدث خطأ ما",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: AppColors.redColor,
                        duration: Durations.extralong1,
                      ));
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
                      CustomerDataEntity selectedCustomer =
                          context.read<AddCollectionCubit>().selectedCustomer;
                      var tradeCollectionRequest =
                          addCollectionCubit.intializeTradeRequest(
                              selectedCustomer: selectedCustomer,
                              context: context);
                      await addCollectionCubit.postTradeCollection(
                        token: "token",
                        tradeCollectionRequest: tradeCollectionRequest,
                      );
                      print(
                          "selected customer ater post ${selectedCustomer.idBl}");
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
