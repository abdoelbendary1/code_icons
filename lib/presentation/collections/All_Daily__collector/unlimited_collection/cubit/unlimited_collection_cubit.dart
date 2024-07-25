import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/unlimited_Data_model.dart';
import 'package:code_icons/data/model/response/UnRegisteredCollections/un_registered_collections_response.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';
import 'package:code_icons/domain/use_cases/get_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/domain/use_cases/post_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:code_icons/presentation/utils/theme/app_colors.dart';

import 'unlimited_collection_state.dart';

class UnlimitedCollectionCubit extends Cubit<UnlimitedCollectionState>
    with EquatableMixin {
  UnlimitedCollectionCubit({
    required this.postUnRegisteredTradeCollectionUseCase,
    required this.getUnRegisteredTradeCollectionUseCase,
  }) : super(UnlimitedCollectionInitial());
  PostUnRegisteredTradeCollectionUseCase postUnRegisteredTradeCollectionUseCase;
  GetUnRegisteredTradeCollectionUseCase getUnRegisteredTradeCollectionUseCase;

  final formKey = GlobalKey<FormState>();
  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
  @override
  List<Object?> get props => [identityHashCode(this)];

  UnRegisteredCollectionsResponse createCollectionDataModel() {
    UnRegisteredCollectionsResponse collectionRequest =
        UnRegisteredCollectionsResponse(
      brandNameBl: ControllerManager()
          .getControllerByName("unlimitedNameController")
          .text,
      activityBl: ControllerManager()
          .getControllerByName("unlimitedActivityController")
          .text,
      addressBl: ControllerManager()
          .getControllerByName("unlimitedAddressController")
          .text,
      currentBl: double.parse(ControllerManager()
          .getControllerByName("unlimitedCurrentFinanceController")
          .text),
      divisionBl: double.parse(ControllerManager()
          .getControllerByName("unlimitedDivisionController")
          .text),
      receiptBl: ControllerManager()
          .getControllerByName("unlimitedPaymentReceitController")
          .text,
      receiptDateBl: convertStringToDate(
          inputString: ControllerManager()
              .getControllerByName("unlimitedPaymentReceitDateController")
              .text),
      totalBl: double.parse(ControllerManager()
          .getControllerByName("unlimitedTotalFinanceController")
          .text),
    );
    return collectionRequest;
  }

  String convertStringToDate({required String inputString}) {
    if (inputString.isNotEmpty) {
      DateFormat inputFormat = DateFormat('yyyy/MM/dd');
      // Parse the input string into a DateTime object
      DateTime dateTime = inputFormat.parse(inputString);

      // Define the output format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      // Format the DateTime object into the desired output format
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    }
    return "";
  }

  List<UnRegisteredCollectionEntity> collections = [];

  Future<void> getAllCollctions() async {
    emit(GetCollectionsLoading());
    var either = await getUnRegisteredTradeCollectionUseCase.invoke();
    either.fold(
      (l) => emit(
        GetUnlimitedCollectionsError(errorMsg: l.errorMessege),
      ),
      (r) => emit(
        GetUnlimitedCollectionsSuccess(collectiion: r),
      ),
    );

    /* either.fold(
        (l) => emit(GetUnlimitedCollectionsError(errorMsg: l.errorMessege)),
        (r) {
      
      GetUnlimitedCollectionsSuccess(collectiion: r);
    }); */
  }

  void addCustomer(
      /* CustomerDataModel customerData, */ BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var either = await postUnRegisteredTradeCollectionUseCase.invoke(
          unRegisteredCollectionEntity: createCollectionDataModel());
      either.fold(
          (l) => emit(AddUnlimitedCollectionError(errorMsg: l.errorMessege)),
          (r) => emit(AddUnlimitedCollectionSuccess(collectionID: r)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "برجاء ادخال جميع البيانات",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.redColor,
        duration: Durations.extralong1,
      ));
    }
  }

  void selectRow(UnRegisteredCollectionEntity selectedRow) {
/*     emit(RowSelectedState(selectedRow: selectedRow));
 */
  }

  void deselectRow() {
    getAllCollctions(); // This is to reset the state to the initial list
  }
}
