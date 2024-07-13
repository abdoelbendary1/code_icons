// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
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
            _buildTextField(
                AppLocalizations.of(context)!.phone_Number_label,
                AppLocalizations.of(context)!.phone_Number_hint,
                addCollectionControllers[0],
                Icons.phone_iphone,
                readOnly: true,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.address_label,
                AppLocalizations.of(context)!.address_hint,
                addCollectionControllers[1],
                Icons.home,
                readOnly: true,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.registration_Number_label,
                AppLocalizations.of(context)!.registration_Number_hint,
                addCollectionControllers[2],
                Icons.app_registration,
                readOnly: true,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.registration_Date_label,
                AppLocalizations.of(context)!.registration_Date_hint,
                addCollectionControllers[3],
                Icons.app_registration,
                readOnly: true,
                () async {}),
            _buildTextField(
                AppLocalizations.of(context)!.commercial_activities_label,
                AppLocalizations.of(context)!.commercial_activities_hint,
                addCollectionControllers[4],
                readOnly: true,
                Icons.local_activity,
                () {}),
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
            _buildTextField(
                AppLocalizations.of(context)!.payment_receipt_number_label,
                AppLocalizations.of(context)!.payment_receipt_number_hint,
                addCollectionControllers[5],
                Icons.receipt,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.division_label,
                AppLocalizations.of(context)!.division_hint,
                addCollectionControllers[6],
                readOnly: true,
                Icons.diversity_3_sharp,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.compensation_label,
                AppLocalizations.of(context)!.compensation_hint,
                addCollectionControllers[7],
                readOnly: true,
                Icons.attach_money,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.financial_arrears_label,
                AppLocalizations.of(context)!.financial_arrears_hint,
                addCollectionControllers[8],
                readOnly: true,
                Icons.attach_money,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.current_finance_label,
                AppLocalizations.of(context)!.current_hint,
                addCollectionControllers[9],
                readOnly: true,
                Icons.attach_money,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.finance_Diffrence_label,
                AppLocalizations.of(context)!.finance_Diffrence_hint,
                addCollectionControllers[10],
                onChanged: (value) {},
                readOnly: false,
                Icons.add_to_photos_sharp,
                () {}),
            _buildTextField(
                AppLocalizations.of(context)!.total_finance_label,
                AppLocalizations.of(context)!.enter_your_Total_finance_hint,
                addCollectionControllers[11],
                readOnly: true,
                Icons.money,
                () {}),
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
                      Navigator.pop(context);
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

                      /*    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "تمت الإضافه بنجاح",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: AppColors.greenColor,
                        duration: Durations.extralong1,
                      ));
                      Navigator.pop(context); */
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

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon,
    void Function()? onTap, {
    bool? readOnly = false,
    void Function(String)? onChanged,
  }) {
    return Column(
      children: [
        ReusableCustomTextField(
          labelText: label,
          hintText: hint,
          controller: controller,
          prefixIcon: icon,
          onTap: onTap,
          readOnly: readOnly,
          onChanged: onChanged,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  /* TextEditingController datePickerController = TextEditingController();

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  } */
}
