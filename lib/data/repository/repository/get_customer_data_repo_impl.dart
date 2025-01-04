// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/General_central/general_central_entity.dart';
import 'package:code_icons/domain/entities/activity/activity_entity.dart';
import 'package:code_icons/domain/entities/station/station.dart';
import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/get_customer_data_remote.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';

class GetCustomerDataRepoImpl implements GetCustomerDataRepo {
  GetCustomerDataRemoteDataSource getCustomerDataRemoteDataSource;
  GetCustomerDataRepoImpl({
    required this.getCustomerDataRemoteDataSource,
  });
  @override
  Future<Either<Failures, List<CustomerDataModel>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  }) {
    return getCustomerDataRemoteDataSource.fetchCustomerData(
        skip: skip, take: take, filter: filter);
  }

  @override
  Future<Either<Failures, CustomerDataEntity>> fetchCustomerDataByID(
      {required String customerId}) {
    return getCustomerDataRemoteDataSource.fetchCustomerDataByID(
        customerId: customerId);
  }

  @override
  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValuesByID(
      {String? customerId}) {
    return getCustomerDataRemoteDataSource.fetchPaymentValuesByID(
        customerId: customerId);
  }

  @override
  Future<Either<Failures, PaymentValuesEntity>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears}) {
    return getCustomerDataRemoteDataSource.postPaymenValuesByID(
        customerId: customerId, paidYears: paidYears);
  }

  @override
  Future<Either<Failures, String>> postCustomerData(
      CustomerDataModel customerData) {
    return getCustomerDataRemoteDataSource.postCustomerData(customerData);
  }

  @override
  Future<Either<Failures, List<CurrencyEntity>>> fetchCurrency() {
    return getCustomerDataRemoteDataSource.fetchCurrency();
  }

  @override
  Future<Either<Failures, CurrencyEntity>> fetchCurrencyDataById(
      {required int currencyId}) {
    return getCustomerDataRemoteDataSource.fetchCurrencyDataById(
        currencyId: currencyId);
  }

  @override
  Future<Either<Failures, List<ActivityEntity>>> fetchActivityeData() {
    return getCustomerDataRemoteDataSource.fetchActivityeData();
  }

  @override
  Future<Either<Failures, List<GeneralCentralEntity>>>
      fetchGeneralCenterseData() {
    return getCustomerDataRemoteDataSource.fetchGeneralCenterseData();
  }

  @override
  Future<Either<Failures, List<TradeOfficeEntity>>> fetchTradeOfficeData() {
    return getCustomerDataRemoteDataSource.fetchTradeOfficeData();
  }

  @override
  Future<Either<Failures, List<StationEntity>>> fetchStationData() {
    return getCustomerDataRemoteDataSource.fetchStationData();
  }

  @override
  Future<Either<Failures, ActivityEntity>> fetchActivityeDataById(
      {required int activityId}) {
    return getCustomerDataRemoteDataSource.fetchActivityeDataById(
        activityId: activityId);
  }

  @override
  Future<Either<Failures, GeneralCentralEntity>> fetchGeneralCenterseDataById(
      {required int generalCentralId}) {
    return getCustomerDataRemoteDataSource.fetchGeneralCenterseDataById(
        generalCentralId: generalCentralId);
  }

  @override
  Future<Either<Failures, StationEntity>> fetchStationDataById(
      {required stationId}) {
    return getCustomerDataRemoteDataSource.fetchStationDataById(
        stationId: stationId);
  }

  @override
  Future<Either<Failures, TradeOfficeEntity>> fetchTradeOfficeDataById(
      {required int tradeOfficeId}) {
    return getCustomerDataRemoteDataSource.fetchTradeOfficeDataById(
        tradeOfficeId: tradeOfficeId);
  }
}
