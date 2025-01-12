import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/trade_chamber/features/add_collection/data/model/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/controller/cubit/add_collection_cubit.dart';
import 'package:code_icons/trade_chamber/core/widgets/custom_sliver_appbar.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/widgets/add_collection_body.dart';
import 'package:code_icons/presentation/ships/AddReport/addReport.dart';
import 'package:code_icons/presentation/ships/AddReport/cubit/add_ship_report_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddReportView extends StatelessWidget {
  AddReportView({
    super.key,
  });

  static const routeName = "AddReportView";
  AddShipReportCubit addShipReportCubit = AddShipReportCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<AddShipReportCubit, AddShipReportState>(
        bloc: addShipReportCubit,
        listener: (context, state) {
          if (state is AddReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "تمت الإضافه بنجاح",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              backgroundColor: AppColors.greenColor,
              duration: Durations.extralong1,
            ));
            Navigator.pop(context);
          } else if (state is AddReportError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "حدث خطأ ما",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              backgroundColor: AppColors.redColor,
              duration: Durations.extralong1,
            ));
          }
        },
        child: CustomSliverAppBar(
          title: "إضافة تقرير",
          body: AddShipReport(),
        ),
      ),
    );
  }
}
