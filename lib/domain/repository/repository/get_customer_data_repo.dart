import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/domain/entities/Currency/currency.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/domain/entities/Customer%20Data/payment_values_entity.dart';
import 'package:code_icons/domain/entities/General_central/general_central_entity.dart';
import 'package:code_icons/domain/entities/activity/activity_entity.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/station/station.dart';
import 'package:code_icons/domain/entities/trade_office/trade_office_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetCustomerDataRepo {
  Future<Either<Failures, List<CustomerDataEntity>>> fetchCustomerData();
  Future<Either<Failures, CustomerDataEntity>> fetchCustomerDataByID(
      {required String customerId});
  Future<Either<Failures, PaymentValuesEntity>> fetchPaymentValuesByID(
      {String? customerId});
  Future<Either<Failures, PaymentValuesEntity>> postPaymenValuesByID(
      {int? customerId, List<int>? paidYears});
  Future<Either<Failures, String>> postCustomerData(
      CustomerDataModel customerData);
  Future<Either<Failures, List<CurrencyEntity>>> fetchCurrency();
  Future<Either<Failures, CurrencyEntity>> fetchCurrencyDataById(
      {required int currencyId});
  Future<Either<Failures, List<TradeOfficeEntity>>> fetchTradeOfficeData();
  Future<Either<Failures, List<GeneralCentralEntity>>>
      fetchGeneralCenterseData();
  Future<Either<Failures, List<ActivityEntity>>> fetchActivityeData();
  Future<Either<Failures, List<StationEntity>>> fetchStationData();
  Future<Either<Failures, TradeOfficeEntity>> fetchTradeOfficeDataById(
      {required int tradeOfficeId});
  Future<Either<Failures, GeneralCentralEntity>> fetchGeneralCenterseDataById(
      {required int generalCentralId});
  Future<Either<Failures, ActivityEntity>> fetchActivityeDataById(
      {required int activityId});
  Future<Either<Failures, StationEntity>> fetchStationDataById(
      {required stationId});
}
