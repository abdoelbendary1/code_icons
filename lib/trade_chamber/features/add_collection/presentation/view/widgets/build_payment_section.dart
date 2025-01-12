import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/trade_chamber/core/widgets/years_of_payment_grid_view.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildPaymentSection extends StatelessWidget {
  BuildPaymentSection({
    super.key,
    required this.cubit,
  });
  AddCollectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Sizes.size10.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppLocalizations.of(context)!.years_of_Payment,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        YearsOfPaymentGridView(
          addCollectionCubit: cubit,
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }
}
