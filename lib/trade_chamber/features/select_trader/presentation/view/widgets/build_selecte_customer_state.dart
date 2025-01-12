import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntityName.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntityRegistryNum.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';

class BuildCustomerState extends StatelessWidget {
  final AddCollectionCubit addCollectionCubit;

  const BuildCustomerState({
    super.key,
    required this.addCollectionCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectCustomerEntityName(
          initialItem: addCollectionCubit.selectedCustomer,
          itemList: addCollectionCubit.customerData,
          title: "اسم التاجر",
          hintText: "اسم التاجر",
          onChanged: (value) {
            addCollectionCubit.selectedCustomer = value;
            addCollectionCubit.fetchCustomerDataByID(
              customerId: addCollectionCubit.selectedCustomer.idBl.toString(),
            );
          },
        ),
        SizedBox(height: 50.h),
        SelectCustomerEntityRegistryNum(
          overlayController: addCollectionCubit.overlayPortalRegistryController,
          initialItem: addCollectionCubit.selectedCustomer,
          itemList: addCollectionCubit
              .customerData, // Show appropriate list based on state
          title: "رقم السجل",
          hintText: "رقم السجل",
          onChanged: (value) {
            if (value != null) {
              addCollectionCubit.selectedCustomer = value;
              addCollectionCubit.fetchCustomerDataByID(
                customerId: addCollectionCubit.selectedCustomer.idBl.toString(),
              );
            }
          },
        ),
      ],
    );
  }
}
