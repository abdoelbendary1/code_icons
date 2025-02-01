import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/core/widgets/custom_button.dart';
import 'package:code_icons/trade_chamber/core/services/alert_service/alert_service.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/build_collection_info.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/build_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionDetailsForm extends StatefulWidget {
  CollectionDetailsForm(
      {super.key, required this.cubit, required this.controllerManager});
  AddCollectionCubit cubit;
  ControllerManager controllerManager;
  @override
  State<CollectionDetailsForm> createState() => _CollectionDetailsFormState();
}

class _CollectionDetailsFormState extends State<CollectionDetailsForm> {
  final addCollectionControllers = ControllerManager().addCollectionControllers;
  @override
  void initState() {
    super.initState();

    if (mounted) {
      // context.read<AddCollectionCubit>() = AddCollectionCubit.initializeCubit();
      // Add focus listener to the division focus node
      context.read<AddCollectionCubit>().divisionFocusNode.addListener(() {
        if (!context.read<AddCollectionCubit>().divisionFocusNode.hasFocus) {
          // Call recalculateTotal when focus is lost
          context.read<AddCollectionCubit>().recalculateTotal(
              context.read<AddCollectionCubit>().paymentValuesEntity);
        }
      }); // Add focus listener to other focus nodes as needed
      context.read<AddCollectionCubit>().diffrentFocusNode.addListener(() {
        if (!context.read<AddCollectionCubit>().diffrentFocusNode.hasFocus) {
          // Call recalculateTotal when focus is lost
          context.read<AddCollectionCubit>().recalculateTotal(
              context.read<AddCollectionCubit>().paymentValuesEntity);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddCollectionCubit>().formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildCollectionInfo(
              controllerManager: widget.controllerManager,
              cubit: context.read<AddCollectionCubit>(),
            ),
            BuildPaymentSection(cubit: context.read<AddCollectionCubit>()),
            Row(
              children: [
                const Spacer(),
                CustomButton(
                  onPressed: () {
                    context.read<AddCollectionCubit>().addRegisteredCollection(
                          onSuccess: () {},
                          formKey: context.read<AddCollectionCubit>().formKey,
                          years: context.read<AddCollectionCubit>().paidYears,
                          initializeTradeRequest: () {
                            return context
                                .read<AddCollectionCubit>()
                                .initializeTradeRequest(
                                  selectedCustomer: context
                                      .read<AddCollectionCubit>()
                                      .selectedCustomer,
                                );
                          },
                          showError: (message) {
                            AlertService.showError(
                                context: context, errorMsg: message);
                          },
                        );
                  },
                  label: AppLocalizations.of(context)!.save,
                ),
              ],
            ),
            Sizes.size36.verticalSpace,
          ],
        ),
      ),
    );
  }
}
