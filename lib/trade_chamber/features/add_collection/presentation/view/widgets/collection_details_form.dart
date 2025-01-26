import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/core/widgets/custom_button.dart';
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
    if (mounted) {
      // Add focus listener to the division focus node
      context.read<AddCollectionCubit>().divisionFocusNode.addListener(() {
        if (!context.read<AddCollectionCubit>().divisionFocusNode.hasFocus) {
          // Call recalculateTotal when focus is lost
          context.read<AddCollectionCubit>().recalculateTotal(
              context.read<AddCollectionCubit>().paymentValuesEntity);
        }
      }); // Add focus listener to other focus nodes as needed
      widget.cubit.diffrentFocusNode.addListener(() {
        if (!widget.cubit.diffrentFocusNode.hasFocus) {
          // Call recalculateTotal when focus is lost
          widget.cubit.recalculateTotal(
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
                        context: context,
                        cubit: widget.cubit,
                        formKey: widget.cubit.formKey);
                  },

                  /*  context.read<AddCollectionCubit>().isButtonEnabled
                      ? () async {
                          // Immediately disable the button
                          var cubit = context.read<AddCollectionCubit>();
                          if (!cubit.isButtonEnabled)
                            return; // Prevent double execution
                          cubit.isButtonEnabled = false;

                          if (context
                              .read<AddCollectionCubit>()
                              .yearsOfRepaymentBL
                              .isEmpty) {
                            AlertService.showError(
                                context: context,
                                errorMsg: "يجب اضافه سنوات السداد");
                            return;
                          }
                          if (widget.cubit.formKey.currentState!.validate()) {
                            try {
                              if (mounted) {
                                CustomerDataEntity selectedCustomer =
                                    cubit.selectedCustomer;
                                var tradeCollectionRequest =
                                    cubit.intializeTradeRequest(
                                  selectedCustomer: selectedCustomer,
                                  context: context,
                                );

                                await widget.cubit.postTradeCollection(
                                  token: "token",
                                  tradeCollectionRequest:
                                      tradeCollectionRequest,
                                  context: context,
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "An error occurred: $e",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  backgroundColor: AppColors.redColor,
                                  duration: Durations.extralong1,
                                ));
                              }
                            } finally {
                              if (mounted) {
                                cubit.isButtonEnabled =
                                    true; // Re-enable the button
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "برجاء ادخال جميع البيانات",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: AppColors.redColor,
                              duration: Durations.extralong1,
                            ));
                            cubit.isButtonEnabled =
                                true; // Re-enable if validation fails
                          }
                        }
                      : null,
                  // Disable the button if isButtonEnabled is false
 */
                  label: AppLocalizations.of(context)!.save,
                ),
                /*    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      foregroundColor: AppColors.whiteColor,
                      backgroundColor: AppColors.blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),

                  onPressed: context.read<AddCollectionCubit>().isButtonEnabled
                      ? () async {
                          // Immediately disable the button
                          var cubit = context.read<AddCollectionCubit>();
                          /*  if (!cubit.isButtonEnabled)
                            return; // Prevent double execution
                          cubit.isButtonEnabled = false;
                 */
                          if (context
                              .read<AddCollectionCubit>()
                              .yearsOfRepaymentBL
                              .isEmpty) {
                            AlertService.showError(
                                context: context,
                                errorMsg: "يجب اضافه سنوات السداد");
                            return;
                          }
                          if (widget.cubit.formKey.currentState!.validate()) {
                            try {
                              if (mounted) {
                                CustomerDataEntity selectedCustomer =
                                    cubit.selectedCustomer;
                                var tradeCollectionRequest =
                                    cubit.intializeTradeRequest(
                                  selectedCustomer: selectedCustomer,
                                  context: context,
                                );

                                await widget.cubit.postTradeCollection(
                                  token: "token",
                                  tradeCollectionRequest:
                                      tradeCollectionRequest,
                                  context: context,
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "An error occurred: $e",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  backgroundColor: AppColors.redColor,
                                  duration: Durations.extralong1,
                                ));
                              }
                            } finally {
                              if (mounted) {
                                cubit.isButtonEnabled =
                                    true; // Re-enable the button
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "برجاء ادخال جميع البيانات",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: AppColors.redColor,
                              duration: Durations.extralong1,
                            ));
                            cubit.isButtonEnabled =
                                true; // Re-enable if validation fails
                          }
                        }
                      : null,
                  // Disable the button if isButtonEnabled is false
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              */
              ],
            ),
            Sizes.size36.verticalSpace,
          ],
        ),
      ),
    );
  }
}
