part of 'add_ship_report_cubit.dart';

sealed class AddShipReportState extends Equatable {
  const AddShipReportState();

  @override
  List<Object> get props => [];
}

final class AddShipReportInitial extends AddShipReportState {}

final class GetAllShipsLoading extends AddShipReportState {}

final class SelectShip extends AddShipReportState {
  Vessels ship;
  SelectShip({required this.ship});
}

final class GetAllShipsError extends AddShipReportState {
  var errorMsg;
  GetAllShipsError({required this.errorMsg});
}

final class GetAllShipsSuccess extends AddShipReportState {
  List<VesselDm> ships;
  GetAllShipsSuccess({required this.ships});
}

final class AddReportLoading extends AddShipReportState {}

final class AddReportError extends AddShipReportState {
  var errorMsg;
  AddReportError({required this.errorMsg});
}

final class AddReportSuccess extends AddShipReportState {}
