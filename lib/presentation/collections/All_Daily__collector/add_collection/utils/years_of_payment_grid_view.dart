import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YearsOfPaymentGridView extends StatefulWidget {
  AddCollectionCubit addCollectionCubit;
  /* List<Map> yearsOfPayment; */
  YearsOfPaymentGridView({
    super.key,
    required this.addCollectionCubit,
  });

  @override
  State<YearsOfPaymentGridView> createState() => _YearsOfPaymentGridViewState();
}

class _YearsOfPaymentGridViewState extends State<YearsOfPaymentGridView> {
  bool isPaid = false;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // This is important to make GridView wrap its content
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2, // Adjust the aspect ratio as needed
        crossAxisSpacing: 2,
        mainAxisSpacing: 5,
      ),
      itemCount: context.read<AddCollectionCubit>().years.length,
      itemBuilder: (context, index) {
        var year = context.read<AddCollectionCubit>().years[index];
        return FilterChip(
          visualDensity: VisualDensity.comfortable,
          selectedColor: Colors.blue, // Replace AppColors.blueColor
          labelStyle: TextStyle(
            color:
                year['isPaid'] ? Colors.white : Colors.black.withOpacity(0.8),
            fontSize: 18,
          ),
          checkmarkColor: Colors.white, // Replace AppColors.whiteColor
          backgroundColor: Colors.lightBlue[50],
          label: Text(
            year['year'],
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
          ),
          selected: year['isPaid'],
          onSelected: (bool value) {
            final addCollectionCubit = context.read<AddCollectionCubit>();
            addCollectionCubit.toggleYearSelection(index, value);

            if (!addCollectionCubit.allPreviousYearsChecked(index)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    label: AppLocalizations.of(context)!
                        .snackBar_label_year_of_payment_action,
                    textColor: AppColors.whiteColor,
                    backgroundColor: AppColors.greenColor,
                    onPressed: () {
                      addCollectionCubit.markAllYearsAsPaid(index);
                    },
                  ),
                  duration: Duration(milliseconds: 2000),
                  backgroundColor: AppColors.blueColor,
                  content: Text(
                    AppLocalizations.of(context)!
                        .snackBar_error_year_of_payment,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
