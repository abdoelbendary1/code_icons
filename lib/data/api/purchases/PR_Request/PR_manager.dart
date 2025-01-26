import 'dart:convert';
import 'dart:developer';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/purchases/PR_Request/PR_request_interface.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/pr_invoice_request/pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/update_pr_invoice_request/update_pr_invoice_request.dart';
import 'package:code_icons/data/model/request/add_purchase_request/purchase_request.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/purchases/invoice/pr_invoice_dm.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/purchase_item/purchase_item.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:code_icons/data/model/response/vendors/vendors_dm.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/domain/entities/vendors/vendors_entity.dart';
import 'package:dartz/dartz.dart';

class PrRequestManager implements PrRequestInterface {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;

  PrRequestManager({
    required this.httpRequestHelper,
    required this.handleResponseHelper,
    required this.authManager,
  });

  @override
  Future<Either<Failures, List<StoreDataModel>>> fetchStoreData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.storeEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<StoreDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => StoreDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<PurchaseItemDataModel>>>
      fetchPurchaseItemData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.itemEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<PurchaseItemDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => PurchaseItemDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PurchaseItemDataModel>> fetchPurchaseItemDataByID(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/Item/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<PurchaseItemDataModel>(
        response: response,
        fromJson: (json) => PurchaseItemDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequests>> deletePurchaseRequestById(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/PurchaseRequest/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.DELETE,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<GetAllPurchasesRequests>(
        response: response,
        fromJson: (json) => GetAllPurchasesRequests.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequests>> fetchPurchaseRequestById(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/PurchaseRequest/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<GetAllPurchasesRequests>(
        response: response,
        fromJson: (json) => GetAllPurchasesRequests.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchAllPurchaseRequests() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.getPREndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<GetAllPurchasesRequests>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => GetAllPurchasesRequests.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<UomDataModel>>> fetchUOMData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.uoms);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<UomDataModel>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => UomDataModel.fromJson(item)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<CostCenterDataModel>>>
      fetchCostCenterData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.costCenterAllEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<CostCenterDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => CostCenterDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, CurrencyDataModel>> fetchCurrencyDataById(
      {required int currencyId}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/Currency/$currencyId');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<CurrencyDataModel>(
        response: response,
        fromJson: (json) => CurrencyDataModel.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<CurrencyDataModel>>> fetchCurrencyData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.currencyEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<CurrencyDataModel>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => CurrencyDataModel.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<PrInvoiceDm>>> fetchPrInvoicesData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.postPrInvoiceEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<PrInvoiceDm>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => PrInvoiceDm.fromJson(item)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> postPurchaseRequest(
      InvoiceReportDm purchaseRequestDataModel) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.postPREndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(purchaseRequestDataModel.toJson()),
      );

      return await handleResponseHelper.handleResponse<String>(
        response: response,
        fromJson: (json) => json as String,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, int>> postPurchaseInvoice(
      PrInvoiceRequest purchaseRequestDataModel) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.postPrInvoiceEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;
      print("request : ${purchaseRequestDataModel.toJson()}");
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(purchaseRequestDataModel.toJson()),
      );

      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json as int,
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PrInvoiceReportDm>> updateInvoiceRequest(
      {required UpdatePrInvoiceRequest purchaseRequestDataModel,
      required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(
          ApiConstants.chamberApi, "${ApiConstants.postPrInvoiceEndPoint}/$id");

      var user = await authManager.getUser();
      var token = user?.accessToken;
      log("request : ${purchaseRequestDataModel.toJson()}");
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.PUT,
        url: url,
        token: token,
        body: jsonEncode(purchaseRequestDataModel.toJson()),
      );

      return await handleResponseHelper.handleResponse<PrInvoiceReportDm>(
        response: response,
        fromJson: (json) => PrInvoiceReportDm.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<GetAllPurchasesRequests>>>
      fetchPurchaseRequests() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.purchaseRequestEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<GetAllPurchasesRequests>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => GetAllPurchasesRequests.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, VendorsEntity>> fetchVendorByID(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/Vendor/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<VendorsEntity>(
        response: response,
        fromJson: (json) => VendorsDM.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<VendorsEntity>>> fetchVendors() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.vendorEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<VendorsEntity>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => VendorsDM.fromJson(item)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PrInvoiceDm>> fetchPrInvoicesDataById(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, '${ApiConstants.postPrInvoiceEndPoint}/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<PrInvoiceDm>(
        response: response,
        fromJson: (json) => PrInvoiceDm.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<PrReturnDM>>> fetchPrReturnsData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.purchaseReturnEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      // Handle 204 No Content response
      if (response.statusCode == 204) {
        // Return an empty list if there is no content
        return right([]);
      }

      // Handle the response and map it to a list of PrReturnDM model
      return await handleResponseHelper.handleResponse<List<PrReturnDM>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => PrReturnDM.fromJson(item)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PrReturnDM>> fetchPrReturnsDataByID(
      {required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi,
          '${ApiConstants.purchaseReturnEndPoint}/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<PrReturnDM>(
        response: response,
        fromJson: (json) => PrReturnDM.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
