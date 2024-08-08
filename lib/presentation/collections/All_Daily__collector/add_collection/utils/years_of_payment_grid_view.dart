// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';

// ignore: must_be_immutable
class YearsOfPaymentGridView extends StatefulWidget {
  AddCollectionCubit addCollectionCubit;

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
      padding: EdgeInsets.all(4),
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
          showCheckmark: false,
          visualDensity: VisualDensity.comfortable,
          selectedColor: Colors.blue, // Replace AppColors.blueColor
          labelStyle: TextStyle(
            color:
                year['isPaid'] ? Colors.white : Colors.black.withOpacity(0.8),
            fontSize: 18,
          ),
          /* checkmarkColor: Colors.white, */ // Replace AppColors.whiteColor
          backgroundColor: AppColors.whiteColor,
          label: Text(
            year['year'],
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
          ),
          selected: year['isPaid'],
          onSelected: (bool value) {
            final addCollectionCubit = context.read<AddCollectionCubit>();
            addCollectionCubit.handleYearSelection(context, index, value);
          },
        );
      },
    );
  }
}
