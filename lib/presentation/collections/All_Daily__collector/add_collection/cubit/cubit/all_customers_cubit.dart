import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_customers_state.dart';

class AllCustomersCubit extends Cubit<AllCustomersState> {
  AllCustomersCubit() : super(AllCustomersInitial());
}
