// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/data/model/data_model/trader_DM.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReusableSelectTrader extends StatefulWidget {
  ReusableSelectTrader({
    super.key,
    required this.itemList,
    required this.selectedCustomer,
  });
  CustomerDataEntity? selectedCustomer;
  List<CustomerDataEntity>? itemList;
  @override
  State<ReusableSelectTrader> createState() => _ReusableSelectTraderState();
}

class _ReusableSelectTraderState extends State<ReusableSelectTrader> {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
    fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
    fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
    postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.customer_Name_DropDown_title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.blackColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.0.h),
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton<CustomerDataEntity?>(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              dropdownColor: AppColors.blueColor,
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              hint: Text(
                AppLocalizations.of(context)!.select_Customer_hint_text,
              ),
              value: widget.selectedCustomer,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.blue,
              ),
              iconSize: 24,
              elevation: 16,
              style: Theme.of(context).textTheme.titleSmall,
              underline: Container(),
              onChanged: (value) {
                /* setState(() {
                  widget.selectedCustomer = value;
                  addCollectionCubit.fetchCustomerDataByID(
                      customerId: value!.idBl.toString());
                }); */
                context.read<AddCollectionCubit>().selectedCustomer = value!;
                context.read<AddCollectionCubit>().fetchCustomerDataByID(
                    customerId: value?.idBl.toString() ?? "7");
              },
              selectedItemBuilder: (context) => widget.itemList!
                  .map<DropdownMenuItem<CustomerDataEntity>>(
                      (CustomerDataEntity? value) {
                return DropdownMenuItem<CustomerDataEntity>(
                  value: value,
                  child: Text(
                    value?.brandNameBl ?? "Empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.primaryColor, fontSize: 24),
                  ),
                );
              }).toList(),
              items: widget.itemList?.map<DropdownMenuItem<CustomerDataEntity>>(
                  (CustomerDataEntity value) {
                /* widget.selectedCustomer = value; */

                return DropdownMenuItem<CustomerDataEntity>(
                  onTap: () {
                    /*     context
                        .read<AddCollectionCubit>()
                        .changeTraderCardInfo(newTrader: value);
                    addCollectionCubit.trader = value;
                    print(addCollectionCubit.trader.name); */
                    /*  addCollectionCubit.fetchCustomerDataByID(
                        customerId: value.idBl.toString());
                    print("selected ID : ${widget.selectedCustomer!.idBl} ");
                    print(widget.selectedCustomer!.idBl); */
                  },
                  value: value,
                  child: Text(
                    value.brandNameBl ?? "empty",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
