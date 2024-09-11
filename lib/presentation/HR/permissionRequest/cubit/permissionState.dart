part of 'permissionCubit.dart';

sealed class PermissionRequestState extends Equatable {
  const PermissionRequestState();

  @override
  List<Object> get props => [];
}

final class PermissionRequestInitial extends PermissionRequestState {}

final class addPermissionRequestError extends PermissionRequestState {
  String errorMessage;
  addPermissionRequestError({required this.errorMessage});
}

final class addPermissionRequestSuccess extends PermissionRequestState {
  int? requestID;
  addPermissionRequestSuccess({this.requestID});
}
