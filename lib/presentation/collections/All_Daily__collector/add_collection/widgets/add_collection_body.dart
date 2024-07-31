import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_DropDown_TextField.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/widgets/collection_details_form.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCollectionBody extends StatefulWidget {
  AddCollectionBody({super.key});

  @override
  State<AddCollectionBody> createState() => _AddCollectionBodyState();
}

class _AddCollectionBodyState extends State<AddCollectionBody> {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase());

  @override
  void initState() {
    super.initState();
    addCollectionCubit.fetchCustomerData();
    ControllerManager().clearControllers(
        controllers: ControllerManager().addCollectionControllers);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addCollectionCubit,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 16.0.h,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocConsumer<AddCollectionCubit, AddCollectionState>(
          listener: (context, state) {
            if (state is GetAllCustomerDataSuccess) {
              addCollectionCubit.customerData = state.customerData;
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AddCollectionCubit, AddCollectionState>(
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
                        label: "اسم التاجر",
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
                      label: "اسم التاجر",
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0.w),
                  child: Text(
                    AppLocalizations.of(context)!.collection_Details_title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer<AddCollectionCubit, AddCollectionState>(
                  bloc: addCollectionCubit,
                  listener: (context, state) {
                    // Add debug print
                    print("Listener State: $state");
                  },
                  builder: (context, state) {
                    print("Builder State: $state");
                    if (state is GetCustomerDataByIDInitial) {
                      return Center(
                          child: SizedBox(
                              height: 30, child: LoadingStateAnimation()));
                    } else if (state is GetCustomerDataByIDError) {
                      return Center(child: Text(state.errorMsg));
                    } else if (state is GetCustomerDataByIDSuccess) {
                      return CollectionDetailsForm();
                    } else {
                      return CollectionDetailsForm();
                    }
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
