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
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomSliverAppBar(
        title: AppLocalizations.of(context)!.add_Collection_Title,
        actions: [
          TextButton(
            onPressed: () {
              CustomerDataEntity selectedCustomer =
                  context.read<AddCollectionCubit>().selectedCustomer;
              var tradeCollectionRequest =
                  addCollectionCubit.intializeTradeRequest(selectedCustomer);
              context.read<AddCollectionCubit>().postTradeCollection(
                  token: "token",
                  tradeCollectionRequest: tradeCollectionRequest);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.save,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
        body: AddCollectionBody(),
      ),
    );
  }
}










/* import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_appBar_app.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/widgets/add_collection_body.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddCollectionView extends StatelessWidget {
  AddCollectionView({super.key});

  static const routeName = "AddCollectionView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBarApp(
            appBarTitle: "Add Collection",
            actionBtntxt: "save",
            actionBtnFunc: () {},
            leadingIconFunc: () {
              Navigator.pop(context);
            }),
        body: AddCollectionBody());
  }
}
 */