import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/service_locator.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_loading_state.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/build_collection_form.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/build_customer_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Main widget for the Add Collection feature
class AddCollectionBody extends StatefulWidget {
  const AddCollectionBody({super.key});

  @override
  State<AddCollectionBody> createState() => _AddCollectionBodyState();
}

class _AddCollectionBodyState extends State<AddCollectionBody> {
  late final AddCollectionCubit addCollectionCubit;
  ControllerManager controllerManager = getIt<ControllerManager>();

  @override
  void initState() {
    super.initState();
    addCollectionCubit = AddCollectionCubit.initializeCubit();
    addCollectionCubit.initialize(context: context);
    controllerManager.clearControllers(
      controllers: controllerManager.addCollectionControllers,
    );
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
                  controllerManager: controllerManager,
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
