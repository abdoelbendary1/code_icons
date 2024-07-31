// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reciet_collction_cubit.dart';

sealed class RecietCollctionState extends Equatable {
  const RecietCollctionState();

  @override
  List<Object> get props => [];
}

final class RecietCollctionInitial extends RecietCollctionState {}

class AddRecietCollctionSuccess extends RecietCollctionState {}

class GetRecietCollctionSuccess extends RecietCollctionState {
  List<RecietCollectionDataModel> reciets;
  GetRecietCollctionSuccess({
    required this.reciets,
  });
}

class GetRecietCollctionError extends RecietCollctionState {
  String errorMsg;
  GetRecietCollctionError({
    required this.errorMsg,
  });
}

class GetRecietCollctionLoading extends RecietCollctionState {}

class AddRecietCollctionError extends RecietCollctionState {
  String errorMsg;
  AddRecietCollctionError({
    required this.errorMsg,
  });
}

class GetLastRecietCollctionSuccess extends RecietCollctionState {
  RecietCollectionDataModel reciet;
  GetLastRecietCollctionSuccess({
    required this.reciet,
  });
}

class RemoveRecietLoading extends RecietCollctionState {}

class RemoveRecietSuccess extends RecietCollctionState {}

class RemoveRecietError extends RecietCollctionState {
  final String errorMsg;
  RemoveRecietError({required this.errorMsg});
}

class RemoveAllRecietsLoading extends RecietCollctionState {}

class RemoveAllRecietsSuccess extends RecietCollctionState {}

class RemoveAllRecietsError extends RecietCollctionState {
  final String errorMsg;
  RemoveAllRecietsError({required this.errorMsg});
}
