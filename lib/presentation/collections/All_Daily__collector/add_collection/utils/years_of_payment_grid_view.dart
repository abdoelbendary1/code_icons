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
            color: year['isChecked']
                ? Colors.white
                : Colors.black.withOpacity(0.8),
            fontSize: 18,
          ),
          checkmarkColor: Colors.white, // Replace AppColors.whiteColor
          backgroundColor: Colors.lightBlue[50],
          label: Text(
            year['year'],
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
          ),
          selected: year['isChecked'],
          onSelected: (bool value) {
            // Check if all previous years are checked
            bool allPreviousChecked = true;
            for (int i = 0; i < index; i++) {
              if (!context.read<AddCollectionCubit>().years[i]['isChecked']) {
                allPreviousChecked = false;
                break;
              }
            }

            if (allPreviousChecked) {
              setState(() {
                year['isChecked'] = value;

                // Set all subsequent years to false
                for (int i = index + 1;
                    i < context.read<AddCollectionCubit>().years.length;
                    i++) {
                  context.read<AddCollectionCubit>().years[i]['isChecked'] =
                      false;
                }
              });
            } else {
              //  show a message or feedback to the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 300),
                  backgroundColor: AppColors.redColor,
                  content: Text(
                    AppLocalizations.of(context)!
                        .snackBar_error_year_of_paymentt,
                    style: Theme.of(context).textTheme.titleLarge,
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
