part of 'all_customers_cubit.dart';

sealed class AllCustomersState extends Equatable {
  const AllCustomersState();

  @override
  List<Object> get props => [];
}

final class AllCustomersInitial extends AllCustomersState {}
