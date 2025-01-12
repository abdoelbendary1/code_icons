import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntityName.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntityRegistryNum.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSelectedCustomerEmpty extends StatelessWidget {
  const BuildSelectedCustomerEmpty(
      {super.key, required this.addCollectionCubit});
  final AddCollectionCubit addCollectionCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectCustomerEntityName(
          initialItem: context.read<AddCollectionCubit>().selectedCustomer,
          itemList: context.read<AddCollectionCubit>().customerData,
          title: "اسم التاجر",
          hintText: "اسم التاجر",
          onChanged: (value) {
            context.read<AddCollectionCubit>().selectedCustomer = value;
            context.read<AddCollectionCubit>().fetchCustomerDataByID(
                customerId: context
                    .read<AddCollectionCubit>()
                    .selectedCustomer
                    .idBl
                    .toString());
          },
        ),
        SizedBox(height: 50.h),
        SelectCustomerEntityRegistryNum(
          overlayController: addCollectionCubit.overlayPortalRegistryController,
          initialItem: context.read<AddCollectionCubit>().selectedCustomer,
          itemList: context.read<AddCollectionCubit>().customerData,
          title: "رقم السجل",
          hintText: "رقم السجل",
          onChanged: (value) {
            if (value != null) {
              context.read<AddCollectionCubit>().selectedCustomer = value;
              context.read<AddCollectionCubit>().fetchCustomerDataByID(
                  customerId: context
                      .read<AddCollectionCubit>()
                      .selectedCustomer
                      .idBl
                      .toString());
            }
          },
        ),
      ],
    );
  }
}
