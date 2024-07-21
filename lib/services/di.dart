//todo viewModel => Usecase
// usecas => repo
// repo => datasource
// data source => api

import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/repository/dataSource/auth_remote_data_source_impl.dart';
import 'package:code_icons/data/repository/dataSource/fetchTradeCollectionsDataSource_Impl.dart';
import 'package:code_icons/data/repository/dataSource/get_customer_data_remote_impl.dart';
import 'package:code_icons/data/repository/dataSource/post_trade_collection_data_source_impl.dart';
import 'package:code_icons/data/repository/repository/auth_repository_impl.dart';
import 'package:code_icons/data/repository/repository/fetchTradeCollectionsRepo_Impl.dart';
import 'package:code_icons/data/repository/repository/get_customer_data_repo_impl.dart';
import 'package:code_icons/data/repository/repository/post_trade_collection_repo_impl.dart';
import 'package:code_icons/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:code_icons/domain/repository/data_source/fetchTradeCollectionsDataSource.dart';
import 'package:code_icons/domain/repository/data_source/get_customer_data_remote.dart';
import 'package:code_icons/domain/repository/data_source/post_trade_collection_data_source.dart';
import 'package:code_icons/domain/repository/repository/auth_repository.dart';
import 'package:code_icons/domain/repository/repository/fetchTradeCollectionsRepo.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:code_icons/domain/repository/repository/post_trade_collection_repo.dart';
import 'package:code_icons/domain/use_cases/fetch_Station_usecase.dart';
import 'package:code_icons/domain/use_cases/fetch_activity_useCase.dart';

import 'package:code_icons/domain/use_cases/fetch_currency_byID_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_currency_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data.dart';
import 'package:code_icons/domain/use_cases/fetch_customer_data_by_ID.dart';
import 'package:code_icons/domain/use_cases/fetch_general_central_useCase.dart';
import 'package:code_icons/domain/use_cases/fetch_paymnetValues.dart';
import 'package:code_icons/domain/use_cases/fetch_trade_collections_usecase.dart';
import 'package:code_icons/domain/use_cases/fetch_trade_office_useCase.dart';

import 'package:code_icons/domain/use_cases/login_useCase.dart';
import 'package:code_icons/domain/use_cases/post-payment_values_by_ID_usecase.dart';
import 'package:code_icons/domain/use_cases/post_customer_data.dart';
import 'package:code_icons/domain/use_cases/post_trade_collection_use_case.dart';

LoginUseCase injectLoginUseCase() {
  return LoginUseCase(authRepository: injectAuthRepository());
}

AuthRepository injectAuthRepository() {
  return AuthRepositoryImpl(authRemoteDataSource: injectAuthDataSource());
}

AuthRemoteDataSource injectAuthDataSource() {
  return AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

PostCustomerDataUseCase injectPostCustomerDataUseCase() {
  return PostCustomerDataUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchCurrencyByIDUseCase injectFetchCurrencyDataByIDUseCase() {
  return FetchCurrencyByIDUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchCurrencyUseCase iinjectFetchCurrencyUseCase() {
  return FetchCurrencyUseCase(getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchCustomerDataUseCase injectFetchCustomerDataUseCase() {
  return FetchCustomerDataUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchCustomerDataByIDUseCase injectFetchCustomerByIdDataUseCase() {
  return FetchCustomerDataByIDUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchPaymentValuesUseCase injectFetchPaymentValuesUseCase() {
  return FetchPaymentValuesUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchTradeCollectionDataUseCase injectFetchTradeCollectionDataUseCase() {
  return FetchTradeCollectionDataUseCase(
      fetchTradeCollectionsRepo: injectFetchTradeCollectionsRepo());
}

FetchTradeCollectionsRepo injectFetchTradeCollectionsRepo() {
  return FetchTradeCollectionsRepoImpl(
      fetchTradeCollectionsDataSource:
          injdectFetchTradeCollectionsDataSource());
}

FetchTradeCollectionsDataSource injdectFetchTradeCollectionsDataSource() {
  return FetchTradeCollectionsDataSourceImpl(
      apiManager: ApiManager.getInstance());
}

PostPaymentValuesByIdUseCase injectPostPaymentValuesByIdUseCase() {
  return PostPaymentValuesByIdUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

GetCustomerDataRepo injectGetCustomerDataRepo() {
  return GetCustomerDataRepoImpl(
      getCustomerDataRemoteDataSource: injectGetCustomerDataRemoteDataSource());
}

GetCustomerDataRemoteDataSource injectGetCustomerDataRemoteDataSource() {
  return GetCustomerDataRemoteDataSourceImpl(
      apiManager: ApiManager.getInstance());
}

PostTradeCollectionUseCase injectPostTradeCollectionUseCase() {
  return PostTradeCollectionUseCase(
      postTradeCollectionRepo: injectPostTradeCollectionRepo());
}

PostTradeCollectionRepo injectPostTradeCollectionRepo() {
  return PostTradeCollectionRepoImpl(
      postTradeCollectionDataSource: injectPostTradeCollectionDataSource());
}

PostTradeCollectionDataSource injectPostTradeCollectionDataSource() {
  return PostTradeCollectionDataSourceImpl(
      apiManager: ApiManager.getInstance());
}

FetchTradeOfficeListUseCase injectFetchTradeOfficeListUseCase() {
  return FetchTradeOfficeListUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchGeneralCentralListUseCase injectFetchGeneralCentralListUseCase() {
  return FetchGeneralCentralListUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchActivityListUseCase injectFetchActivityListUseCase() {
  return FetchActivityListUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}

FetchTradeCollectionsDataSource injectFetchTradeCollectionsDataSource() {
  return FetchTradeCollectionsDataSourceImpl(
      apiManager: ApiManager.getInstance());
}

FetchStationListUseCase injectFetchStationListUseCase() {
  return FetchStationListUseCase(
      getCustomerDataRepo: injectGetCustomerDataRepo());
}
