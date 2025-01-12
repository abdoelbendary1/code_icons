import 'package:code_icons/trade_chamber/core/widgets/build_loading_state.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/trade_chamber/features/select_trader/presentation/view/widgets/build_selecte_customer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCustomerSelection extends StatelessWidget {
  const BuildCustomerSelection({
    super.key,
    required this.cubit,
  });

  final AddCollectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCollectionCubit, AddCollectionState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GetCustomerDataByIDLoading) {
          return const BuildLoadingState();
        }
        return BuildCustomerState(addCollectionCubit: cubit);
      },
    );
  }
}
