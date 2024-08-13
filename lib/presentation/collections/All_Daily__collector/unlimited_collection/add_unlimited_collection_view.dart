import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/widgets/unlimited_collection_body.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnlimitedCollection extends StatelessWidget {
  UnlimitedCollection({super.key, required TradeCollectionEntity data});

  static const routeName = "UnlimitedCollection";
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
    fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
    fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
    postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
    paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<AddCollectionCubit, AddCollectionState>(
        bloc: addCollectionCubit,
        listener: (context, state) {
          if (state is AddCollectionSucces) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "تمت الإضافه بنجاح",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              backgroundColor: AppColors.greenColor,
              duration: Durations.extralong1,
            ));
            Navigator.pushReplacementNamed(
                context, UnlimitedCollection.routeName);
          } else if (state is AddCollectionError) {
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
          title: "إضافه حافظه غير مقيده",
          /* title: AppLocalizations.of(context)!.add_Collection_Title, */
          body: UnlimitedCollectionBody(),
        ),
      ),
    );
  }
}
