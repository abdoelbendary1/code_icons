import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_loading_state.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/add_collection_body.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/collection_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildForm extends StatelessWidget {
  BuildForm({
    super.key,
    required this.cubit,
    required this.controllerManager,
  });

  final AddCollectionCubit cubit;
  ControllerManager controllerManager;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCollectionCubit, AddCollectionState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GetCustomerDataByIDInitial) {
          return const BuildLoadingState();
        } else if (state is GetCustomerDataByIDSuccess ||
            state is YearsUpdatedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sizes.size16.verticalSpace,
              CollectionDetailsForm(
                cubit: cubit,
                controllerManager: controllerManager,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
