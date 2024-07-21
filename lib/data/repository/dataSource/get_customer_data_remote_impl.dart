// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/General_central/general_central_entity.dart';
import 'package:code_icons/domain/entities/activity/activity_entity.dart';
import 'package:code_icons/domain/entities/station/station.dart';
import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/repository/data_source/get_customer_data_remote.dart';

class GetCustomerDataRemoteDataSourceImpl
    implements GetCustomerDataRemoteDataSource {
  ApiManager apiManager;
  GetCustomerDataRemoteDataSourceImpl({
    required this.apiManager,
  });
  @override
  Future<Either<Failures, List<CustomerDataEntity>>> fetchCustomerData() async {
    var either = await apiManager.fetchCustomerData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, CustomerDataEntity>> fetchCustomerDataByID(
      {required String customerId}) async {
    var either = await apiManager.fetchCustomerDataByID(customerId: customerId);
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValuesByID(
      {String? customerId}) async {
    var either =
        await apiManager.fetchPaymentValuesByID(customerId: customerId);
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, PaymentValuesEntity>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears}) async {
    var either = await apiManager.postPaymenValuesByID(
        customerId: customerId, paidYears: paidYears);
    return either.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failures, String>> postCustomerData(
      CustomerDataModel customerData) async {
    var either = await apiManager.postCustomerData(customerData);
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<CurrencyEntity>>> fetchCurrency() async {
    var either = await apiManager.fetchCurrencyData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, CurrencyEntity>> fetchCurrencyDataById(
      {required int currencyId}) async {
    var either = await apiManager.fetchCurrencyDataById(currencyId: currencyId);
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<ActivityEntity>>> fetchActivityeData() async {
    var either = await apiManager.fetchActivityeData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<GeneralCentralEntity>>>
      fetchGeneralCenterseData() async {
    var either = await apiManager.fetchGeneralCenterseData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<TradeOfficeEntity>>>
      fetchTradeOfficeData() async {
    var either = await apiManager.fetchTradeOfficeData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<StationEntity>>> fetchStationData() async {
    var either = await apiManager.fetchStationData();
    return either.fold(
        (failure) => Left(failure), (response) => Right(response));
  }
}
