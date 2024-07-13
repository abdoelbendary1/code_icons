import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/widgets/add_collection_body.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCollectionView extends StatelessWidget {
  AddCollectionView({super.key});

  static const routeName = "AddCollectionView";
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
            Navigator.pop(context);
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
          title: AppLocalizations.of(context)!.add_Collection_Title,
          /* actions: [
            TextButton(
              onPressed: () async {
                CustomerDataEntity selectedCustomer =
                    context.read<AddCollectionCubit>().selectedCustomer;
                var tradeCollectionRequest =
                    addCollectionCubit.intializeTradeRequest(selectedCustomer);
                await addCollectionCubit.postTradeCollection(
                  token: "token",
                  tradeCollectionRequest: tradeCollectionRequest,
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ], */
          body: AddCollectionBody(),
        ),
      ),
    );
  }
}
