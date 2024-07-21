// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/station/station.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class FetchStationListUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  FetchStationListUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, List<StationEntity>>> invoke() async {
    return await getCustomerDataRepo.fetchStationData();
  }

  Future<Either<Failures, StationEntity>> fetchStationDataById(
      {required stationId}) {
    return getCustomerDataRepo.fetchStationDataById(stationId: stationId);
  }
}
