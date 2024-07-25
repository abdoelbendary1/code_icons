import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/Unlimited_collection/widgets/Unlimited_collection_details_form.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_state.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnlimitedCollectionBody extends StatefulWidget {
  UnlimitedCollectionBody({super.key});

  @override
  State<UnlimitedCollectionBody> createState() =>
      _UnlimitedCollectionBodyState();
}

class _UnlimitedCollectionBodyState extends State<UnlimitedCollectionBody> {
  /* AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase()); */
  UnlimitedCollectionCubit unlimitedCollectionCubit = UnlimitedCollectionCubit(
      postUnRegisteredTradeCollectionUseCase:
          injectPostUnRegisteredTradeCollectionUseCase(),
      getUnRegisteredTradeCollectionUseCase:
          injectGetUnRegisteredTradeCollectionUseCase());

  @override
  void initState() {
    super.initState();
    /* addCollectionCubit.fetchCustomerData();
    ControllerManager().clearControllers(
        controllers: ControllerManager().addCollectionControllers); */
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => unlimitedCollectionCubit,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 16.0.h,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocConsumer<UnlimitedCollectionCubit, UnlimitedCollectionState>(
          listener: (context, state) {
            /*   if (state is GetAllCustomerDataSuccess) {
              addCollectionCubit.customerData = state.customerData;
            } */
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*   BlocBuilder<AddCollectionCubit, AddCollectionState>(
                  buildWhen: (previous, current) {
                    if (previous is GetCustomerDataByIDSuccess) {
                      return false;
                    }
                    if (current is YearsUpdatedState) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                  builder: (context, state) {
                    if (state is GetCustomerDataByIDSuccess) {
                      return ReusableSelectTrader(
                        itemList: addCollectionCubit.customerData,
                        selectedCustomer: addCollectionCubit.selectedCustomer,
                        onChanged: (value) {
                          context.read<AddCollectionCubit>().selectedCustomer =
                              value!;
                          context
                              .read<AddCollectionCubit>()
                              .fetchCustomerDataByID(
                                  customerId: value.idBl.toString());
                        }, //! bug
                      );
                    }
                    return ReusableSelectTrader(
                      itemList: addCollectionCubit.customerData,
                      onChanged: (value) {
                        context.read<AddCollectionCubit>().selectedCustomer =
                            value!;
                        context
                            .read<AddCollectionCubit>()
                            .fetchCustomerDataByID(
                                customerId: value.idBl.toString());
                      },
                      selectedCustomer: null,
                    );
                  },
                ), */
                /*   SizedBox(
                  height: 20.h,
                ), */
                /*   Padding(
                  padding: EdgeInsets.only(left: 10.0.w),
                  child: Text(
                    "إضافه حافظه غير مقيده",
                    /* AppLocalizations.of(context)!.collection_Details_title, */
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ), */
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer<UnlimitedCollectionCubit,
                    UnlimitedCollectionState>(
                  bloc: unlimitedCollectionCubit,
                  listener: (context, state) {
                    // Add debug print
                    print("Listener State: $state");
                  },
                  builder: (context, state) {
                    print("Builder State: $state");
                    if (state is UnlimitedCollectionInitial) {
                      return UnlimitedCollectionDetailsForm();
                    } else if (state is AddUnlimitedCollectionError) {
                      return Center(child: Text(state.errorMsg));
                    } else if (state is AddUnlimitedCollectionSuccess) {}
                    return Container();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
