import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/Unlimited_collection/widgets/Unlimited_collection_details_form.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_state.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
                        child: Container(child: Text(state.errorMsg)),
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
