//todo viewModel => Usecase
// usecas => repo
// repo => datasource
// data source => api

import 'dart:io';

import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/data/api/HR/Requests/attendence/IAttendance.dart';
import 'package:code_icons/data/api/HR/Requests/attendence/attendance_manager.dart';
import 'package:code_icons/data/api/HR/employee/Employee_interface.dart';
import 'package:code_icons/data/api/HR/employee/Employee_manager.dart';
import 'package:code_icons/data/api/Sales/Invoice/Invoice_interface.dart';
import 'package:code_icons/data/api/Sales/Invoice/invoice_manager.dart';
import 'package:code_icons/data/api/api_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/purchases/PR_Request/PR_manager.dart';
import 'package:code_icons/data/api/purchases/PR_Request/PR_request_interface.dart';
import 'package:code_icons/data/api/storage/IStorage.dart';
import 'package:code_icons/data/api/storage/StorageManager.dart';
import 'package:code_icons/data/api/sysSettings/ISysSetting.dart';
import 'package:code_icons/data/api/sysSettings/sysSetting_manager.dart';
import 'package:code_icons/data/api/tradeChamber/collections/trade_collection_interface.dart';
import 'package:code_icons/data/api/tradeChamber/collections/trade_collection_manager.dart';
import 'package:code_icons/data/api/tradeChamber/customers/customers_interface.dart';
import 'package:code_icons/data/api/tradeChamber/customers/customers_manager.dart';
import 'package:code_icons/data/interfaces/IHttpClient.dart';
import 'package:code_icons/data/repository/dataSource/HR/Employee/Employee_DataSource_Impl.dart';
import 'package:code_icons/data/repository/dataSource/auth/HttpClientImpl.dart';
import 'package:code_icons/data/repository/dataSource/auth/auth_remote_data_source_impl.dart';
import 'package:code_icons/data/repository/dataSource/fetchTradeCollectionsDataSource_Impl.dart';
import 'package:code_icons/data/repository/dataSource/get_customer_data_remote_impl.dart';
import 'package:code_icons/data/repository/dataSource/post_trade_collection_data_source_impl.dart';
import 'package:code_icons/data/repository/dataSource/purcase_request_remote_impl.dart';
import 'package:code_icons/data/repository/repository/HR/Employee/Employee_Repo_Impl.dart';
import 'package:code_icons/data/repository/repository/Purchase_requset_repo_impl.dart';
import 'package:code_icons/data/repository/repository/auth_repository_impl.dart';
import 'package:code_icons/data/repository/repository/fetchTradeCollectionsRepo_Impl.dart';
import 'package:code_icons/data/repository/repository/get_customer_data_repo_impl.dart';
import 'package:code_icons/data/repository/repository/post_trade_collection_repo_impl.dart';
import 'package:code_icons/domain/repository/data_source/Employee/Employee_Repo.dart';
import 'package:code_icons/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:code_icons/domain/repository/data_source/fetchTradeCollectionsDataSource.dart';
import 'package:code_icons/domain/repository/data_source/get_customer_data_remote.dart';
import 'package:code_icons/domain/repository/data_source/post_trade_collection_data_source.dart';
import 'package:code_icons/domain/repository/data_source/purchase_request_remote_data_source.dart';
import 'package:code_icons/domain/repository/repository/HR/Employee/Employee_Repo.dart';
import 'package:code_icons/domain/repository/repository/Purchase_request_dart.dart';
import 'package:code_icons/domain/repository/repository/auth_repository.dart';
import 'package:code_icons/domain/repository/repository/fetchTradeCollectionsRepo.dart';
import 'package:code_icons/domain/repository/repository/get_customer_data_repo.dart';
import 'package:code_icons/domain/repository/repository/post_trade_collection_repo.dart';
import 'package:code_icons/domain/use_cases/HR/Employee/fetchEmployeeDataByID.dart';
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
import 'package:code_icons/domain/use_cases/get_UnRegistered_trade_collection_use_case%20.dart';

import 'package:code_icons/domain/use_cases/login_useCase.dart';
import 'package:code_icons/domain/use_cases/post-payment_values_by_ID_usecase.dart';
import 'package:code_icons/domain/use_cases/post_UnRegistered_trade_collection_use_case%20.dart';
import 'package:code_icons/domain/use_cases/post_customer_data.dart';
import 'package:code_icons/domain/use_cases/post_trade_collection_use_case.dart';
import 'package:code_icons/domain/use_cases/purchase_request_usecase/purchase_request.useCase.dart';
import 'package:code_icons/domain/use_cases/storage/add_item_category.dart';
import 'package:code_icons/domain/use_cases/storage/add_item_company.dart';
import 'package:code_icons/domain/use_cases/storage/add_item_usecase.dart';
import 'package:code_icons/domain/use_cases/storage/fetchUOM_usecase.dart';

LoginUseCase injectLoginUseCase() {
  return LoginUseCase(authRepository: injectAuthRepository());
}

AuthManager injectAuthManagerInterface() {
  return AuthManager(
    httpClient: injectHttpClient(),
    httpRequestHelper: injectHttpRequestHelper(),
    handleResponseHelper: injectHandleResponseHelper(),
  );
}

IAttendance injectIAttendance() {
  return AttendanceManager(
      authManager: injectAuthManagerInterface(),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());
}

FetchEmployeeDataByIDUseCase injectFetchEmployeeDataByIDUseCase() {
  return FetchEmployeeDataByIDUseCase(employeeRepo: injectEmployeeRepo());
}

EmployeeRepo injectEmployeeRepo() {
  return EmployeeRepoImpl(employeeDataSource: injectEmployeeDataSource());
}

EmployeeDataSource injectEmployeeDataSource() {
  return EmployeeDataSourceImpl(employeeInterface: injectEmployeeInterface());
}

EmployeeInterface injectEmployeeInterface() {
  return EmployeeManager(
      authManager: injectAuthManagerInterface(),
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper());
}

TradeCollectionsInterface injectTradeCollectionsInterface() {
  return TradeCollectionManager(
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper(),
      authManager: injectAuthManagerInterface());
}

CustomersDataInterface injectCustomersDataInterface() {
  return CustomersManager(
      httpRequestHelper: injectHttpRequestHelper(),
      authManager: injectAuthManagerInterface(),
      handleResponseHelper: injectHandleResponseHelper());
}

HandleResponseHelper injectHandleResponseHelper() {
  return HandleResponseHelper(httpRequestHelper: injectHttpRequestHelper());
}

IHttpClient injectHttpClient() {
  return HttpClientImpl();
}

HttpRequestHelper injectHttpRequestHelper() {
  return HttpRequestHelper(
    httpClient: injectHttpClient(),
  );
}

AuthRepository injectAuthRepository() {
  return AuthRepositoryImpl(authRemoteDataSource: injectAuthDataSource());
}

AuthRemoteDataSource injectAuthDataSource() {
  return AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

PurchaseRequestsUseCases injectPurchaseRequestsUseCases() {
  return PurchaseRequestsUseCases(
      purchaseRequestRepo: injectPurchaseRequestRepo());
}

PurchaseRequestRepo injectPurchaseRequestRepo() {
  return PurchaseRequestRepoImpl(
      purchaseRequestRemoteDataSource: injectPurchaseRequestRemoteDataSource());
}

InvoiceInterface injectInvoiceInterface() {
  return InvoiceManager(
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper(),
      authManager: injectAuthManagerInterface());
}

ISysSettings injectISysSettings() {
  return SysSettingManager(
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper(),
      authManager: injectAuthManagerInterface());
}

PurchaseRequestRemoteDataSource injectPurchaseRequestRemoteDataSource() {
  return PurchaseRequestRemoteDataSourceImpl(
    apiManager: ApiManager.getInstance(),
    prRequestManager: injectPrRequestInterface(),
  );
}

PrRequestInterface injectPrRequestInterface() {
  return PrRequestManager(
      httpRequestHelper: injectHttpRequestHelper(),
      handleResponseHelper: injectHandleResponseHelper(),
      authManager: injectAuthManagerInterface());
}

IStorage injectIStorage() {
  return StorageManager(
      authManager: injectAuthManagerInterface(),
      handleResponseHelper: injectHandleResponseHelper(),
      httpRequestHelper: injectHttpRequestHelper());
}

FetchUOMUsecase injectFetchUOMUseCase() {
  return FetchUOMUsecase(iStorage: injectIStorage());
}

AddItemUseCase injcetAddItemUseCase() {
  return AddItemUseCase(iStorage: injectIStorage());
}

AddItemCategoryUseCase injectAddItemCategoryUseCase() {
  return AddItemCategoryUseCase(iStorage: injectIStorage());
}

AddItemCompanyUseCase injcetAddItemCompanyUseCase() {
  return AddItemCompanyUseCase(iStorage: injectIStorage());
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

PostUnRegisteredTradeCollectionUseCase
    injectPostUnRegisteredTradeCollectionUseCase() {
  return PostUnRegisteredTradeCollectionUseCase(
      postTradeCollectionRepo: injectPostTradeCollectionRepo());
}

GetUnRegisteredTradeCollectionUseCase
    injectGetUnRegisteredTradeCollectionUseCase() {
  return GetUnRegisteredTradeCollectionUseCase(
      postTradeCollectionRepo: injectPostTradeCollectionRepo());
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
