/* import 'package:code_icons/trade_chamber/core/services/alert_service/alert_service.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_loading_state.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/collection_details_form.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:code_icons/trade_chamber/features/select_trader/presentation/view/widgets/build_selecte_customer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCollectionBody extends StatefulWidget {
  const AddCollectionBody({super.key});

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
    addCollectionCubit.initialize(context: context);
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
            // Usage
            handleState(context, state, addCollectionCubit);
          },
          builder: (context, state) {
            if (state is GetAllCustomerDataLoading) {
              return const BuildLoadingState();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<AddCollectionCubit, AddCollectionState>(
                  listener: (context, state) {

                  },
                  bloc: addCollectionCubit,
                  builder: (context, state) {
                    if (state is GetCustomerDataByIDSuccess) {
                      return BuildCustomerState(
                        addCollectionCubit: addCollectionCubit,
                      );
                    } else if (state is GetCustomerDataByIDLoading) {
                      return const BuildLoadingState();
                    }
                    return BuildCustomerState(
                      addCollectionCubit: addCollectionCubit,
                    );
                  },
                ),
                BlocBuilder<AddCollectionCubit, AddCollectionState>(
                  bloc: addCollectionCubit,
                  builder: (context, state) {
                    if (state is GetCustomerDataByIDInitial) {
                      // Loading
                      return const BuildLoadingState();
                    } else if (state is GetCustomerDataByIDSuccess ||
                        state is YearsUpdatedState) {
                      // Success

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          //! dont put const here //!
                          CollectionDetailsForm(),
                        ],
                      );
                    } else {
                      return Container();
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

  void handleState(BuildContext context, dynamic state,
      AddCollectionCubit addCollectionCubit) {
    // Use a Set to collect unique error messages
    Set<String> errorMessages = {};

    if (state is GetAllCustomerDataSuccess) {
      handleSuccessState(state, addCollectionCubit);
    } else if (state is GetAllCustomerDataError) {
      addCollectionCubit.isLoading = false;
      addCollectionCubit.hasMoreData = false;
      errorMessages.add(state.errorMsg); // Add error to the Set
    } else if (state is GetCustomerDataByIDError) {
      errorMessages.add(state.errorMsg); // Add error to the Set
    }

    // Display unique errors in a single alert if there are any
    if (errorMessages.isNotEmpty) {
      AlertService.showError(
        context: context,
        errorMsg: errorMessages
            .join('\n'), // Combine unique errors into a single message
      );
    }
  }

  void handleSuccessState(
      GetAllCustomerDataSuccess state, AddCollectionCubit cubit) {
    cubit.customerData = state.customerData!;
    cubit.receipts = state.receipts ?? [];
    addCollectionCubit.skip += addCollectionCubit.take;
    addCollectionCubit.customerData = List.from(addCollectionCubit.customerData)
      ..addAll(state.customerData!);
    addCollectionCubit.hasMoreData =
        state.customerData!.length == addCollectionCubit.take;
    addCollectionCubit.isLoading = false;
  }

  void handleCustomerDataByIDError(
      BuildContext context, GetCustomerDataByIDError state) {
    AlertService.showError(context: context, errorMsg: state.errorMsg);
  }
}


 */

import 'package:code_icons/trade_chamber/features/show_all_reciepts/presentation/view/all_reciets.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/trade_chamber/core/services/alert_service/alert_service.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_loading_state.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/build_collection_form.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/build_customer_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

/// Main widget for the Add Collection feature
class AddCollectionBody extends StatefulWidget {
  const AddCollectionBody({super.key});

  @override
  State<AddCollectionBody> createState() => _AddCollectionBodyState();
}

class _AddCollectionBodyState extends State<AddCollectionBody> {
  late final AddCollectionCubit addCollectionCubit;

  @override
  void initState() {
    super.initState();
    addCollectionCubit = AddCollectionCubit.initializeCubit();
    addCollectionCubit.initialize(context: context);
    AddCollectionCubit.clearControllers();
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
            addCollectionCubit.handleErrorState(
                context, state, addCollectionCubit);
            addCollectionCubit.handleSuccessStates(
                context, state, addCollectionCubit);
           
          },
          builder: (context, state) {
            if (state is GetAllCustomerDataLoading ||
                state is AddCollectionLoading) {
              return const BuildLoadingState();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildCustomerSelection(cubit: addCollectionCubit),
                BuildForm(
                  cubit: addCollectionCubit,
                  controllerManager: ControllerManager(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    addCollectionCubit.close();
    super.dispose();
  }
}
