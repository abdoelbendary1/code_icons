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
    widget.cubit = AddCollectionCubit.initializeCubit();
    // Add focus listener to the division focus node
    widget.cubit.divisionFocusNode.addListener(() {
      if (!widget.cubit.divisionFocusNode.hasFocus) {
        // Call recalculateTotal when focus is lost
        widget.cubit.recalculateTotal(
            context.read<AddCollectionCubit>().paymentValuesEntity);
      }
    });

    // Add focus listener to other focus nodes as needed
    widget.cubit.diffrentFocusNode.addListener(() {
      if (!widget.cubit.diffrentFocusNode.hasFocus) {
        // Call recalculateTotal when focus is lost
        widget.cubit.recalculateTotal(
            context.read<AddCollectionCubit>().paymentValuesEntity);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildCollectionInfo(
              controllerManager: widget.controllerManager,
              cubit: widget.cubit,
            ),
            BuildPaymentSection(cubit: widget.cubit),
            Row(
              children: [
                const Spacer(),
                CustomButton(
                  onPressed: () {
                    widget.cubit.addRegisteredCollection(
                      formKey: widget.cubit.formKey,
                      initializeTradeRequest: () {
                        return widget.cubit.initializeTradeRequest(
                          selectedCustomer: widget.cubit.selectedCustomer,
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
