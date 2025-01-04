import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/data_model/filter_searchDM.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/grid_table_entiiy/grid_table_entity.dart';
import 'package:code_icons/domain/repository/repository/fetchTradeCollectionsRepo.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/fetch_trade_collections_usecase.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'all_daily_collector_state.dart';

class AllDailyCollectorCubit extends Cubit<AllDailyCollectorState> {
  AllDailyCollectorCubit({
    required this.fetchTradeCollectionDataUseCase,
    required this.fetchCustomerDataUseCase,
  }) : super(AllDailyCollectorInitial());

  final FetchTradeCollectionDataUseCase fetchTradeCollectionDataUseCase;
  final FetchCustomerDataUseCase fetchCustomerDataUseCase;
  List<CustomerDataEntity> customerData = [];
  CustomerDataEntity customer = CustomerDataEntity();
  Map<String, dynamic> customers = {};
  FilterSearchDM? selectedFilter = FilterSearchDM(
    id: 2,
    name: "رقم السجل",
  );
  TextEditingController searchController = TextEditingController();
  void changeFilter(FilterSearchDM filter) {
    selectedFilter = filter;
    emit(ChangeFilter());
  }

  void fetchAllCollections({
    required int skip,
    required int take,
    String? filter,
    FilterSearchDM? filteSearchDm,
  }) async {
    filteSearchDm = selectedFilter;
    filter = searchController.text;
    if (filter.isNotEmpty) {
      var filterConditions = [];
      if (filteSearchDm?.id == 2) {
        filterConditions = [
          ["tradeRegistryBL", "contains", "${filter}"],
        ];
      } else if (filteSearchDm?.id == 1) {
        filterConditions = [
          ["brandNameBL", "contains", "${filter}"],
        ];
      } else {
        filterConditions = [
          ["tradeRegistryBL", "contains", ""],
        ];
      }

      // If `filter` is not provided, use `filterConditions`
      String? filters = jsonEncode(filterConditions);

      // Encode `filter` to make it query-safe
      var encodedFilter = Uri.encodeComponent(filters);
      print(encodedFilter);
      var either =
          await fetchTradeCollectionDataUseCase.fetchTradeCollectionData(
        skip: skip,
        take: take,
        filter: encodedFilter,
      );

      either.fold((l) => emit(GetAllCollectionsError(errorMsg: l.errorMessege)),
          (r) {
        {
          emit(GetAllCollectionsSuccess(dataList: r));
        }
      });
    } else {
      var filterConditions = [
        ["tradeRegistryBL", "contains", null],
      ];
      String? filters = jsonEncode(filterConditions);

      // Encode `filter` to make it query-safe
      var encodedFilter = Uri.encodeComponent(filters);
      print(encodedFilter);
      var either =
          await fetchTradeCollectionDataUseCase.fetchTradeCollectionData(
        skip: skip,
        take: take,
        filter: encodedFilter,
      );

      either.fold((l) => emit(GetAllCollectionsError(errorMsg: l.errorMessege)),
          (r) {
        {
          emit(GetAllCollectionsSuccess(dataList: r));
        }
      });
    }
  }

  Future<void> fetchCustomerData({
    required int skip,
    required int take,
  }) async {
    var either = await fetchCustomerDataUseCase.fetchCustomerData(
        skip: skip, take: take);
    either.fold((failure) {
      print(failure.errorMessege);
      emit(GetAllCustomerDataError(errorMsg: failure.errorMessege));
    }, (response) {
      customerData = response;
      emit(GetAllCustomerDataSuccessDaily(customerData: customerData));
    });
  }

  CustomerDataEntity getCustomerById(int customerId) {
    if (customerData.isNotEmpty) {
      for (var customer in customerData) {
        /* print(customer.idBl) */;
        if (customer.idBl == customerId /* && customer.idBl != null */) {
          /* print(customer.idBl); */
          return customer;
        }
      }
    }

    return CustomerDataEntity(); // Return 'Unknown' if the customer ID is not found
  }

  void selectRow(TradeCollectionEntity selectedRow) {
    emit(RowSelectedState(selectedRow: selectedRow));
  }

  void deselectRow() {
    /*  fetchAllCollections(); */ // This is to reset the state to the initial list
  }
}
