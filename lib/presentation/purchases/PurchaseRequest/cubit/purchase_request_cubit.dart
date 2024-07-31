import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'purchase_request_state.dart';

class PurchaseRequestCubit extends Cubit<PurchaseRequestState> {
  PurchaseRequestCubit() : super(PurchaseRequestInitial());
}
