import 'package:code_icons/services/di.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/controller/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/controller/cubit/unlimited_collection_state.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/view/widgets/unlimited_collection_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnlimitedCollectionBody extends StatefulWidget {
  const UnlimitedCollectionBody({super.key});

  @override
  State<UnlimitedCollectionBody> createState() =>
      _UnlimitedCollectionBodyState();
}

class _UnlimitedCollectionBodyState extends State<UnlimitedCollectionBody> {
  UnlimitedCollectionCubit unlimitedCollectionCubit = UnlimitedCollectionCubit(
      postUnRegisteredTradeCollectionUseCase:
          injectPostUnRegisteredTradeCollectionUseCase(),
      getUnRegisteredTradeCollectionUseCase:
          injectFetchAllUnRegisteredCollectionsUseCase(),
      authManager: injectAuthManagerInterface());

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
                      return Align(
                        alignment: Alignment.center,
                        child: Text(state.errorMsg),
                      );
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
