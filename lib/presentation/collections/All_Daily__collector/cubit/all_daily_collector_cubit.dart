import 'package:bloc/bloc.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';
import 'package:code_icons/domain/entities/grid_table_entiiy/grid_table_entity.dart';
import 'package:code_icons/domain/repository/repository/fetchTradeCollectionsRepo.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/fetch_trade_collections_usecase.dart';
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

  void fetchAllCollections() async {
    var either =
        await fetchTradeCollectionDataUseCase.fetchTradeCollectionData();
    either.fold((l) => emit(GetAllCollectionsError(errorMsg: l.errorMessege)),
        (r) {
      if (r.isNotEmpty) {
        emit(GetAllCollectionsSuccess(dataList: r));
      }
    });
  }

  Future<void> fetchCustomerData() async {
    var either = await fetchCustomerDataUseCase.invoke();
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
    fetchAllCollections(); // This is to reset the state to the initial list
  }
}
