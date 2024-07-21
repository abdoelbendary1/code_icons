// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:dartz/dartz.dart';

class FetchTradeOfficeListUseCase {
  GetCustomerDataRepo getCustomerDataRepo;
  FetchTradeOfficeListUseCase({
    required this.getCustomerDataRepo,
  });

  Future<Either<Failures, List<TradeOfficeEntity>>> invoke() async {
    return await getCustomerDataRepo.fetchTradeOfficeData();
  }

  Future<Either<Failures, TradeOfficeEntity>> fetchTradeOfficeDataById(
      {required int tradeOfficeId}) {
    return getCustomerDataRepo.fetchTradeOfficeDataById(
        tradeOfficeId: tradeOfficeId);
  }
}
