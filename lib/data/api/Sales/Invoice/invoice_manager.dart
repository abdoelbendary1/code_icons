// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:code_icons/data/api/Sales/permissions/sl_permissions_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/Pr_invoice_DM.dart';
import 'package:code_icons/data/model/response/purchases/returns/PrReturnDM.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_report_dm.dart';
import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/response/invoice/customersDM.dart';
import 'package:code_icons/data/model/response/invoice/drawer_dm.dart';
import 'package:code_icons/data/model/response/invoice/invoice_tax_dm.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/Sales/Invoice/Invoice_interface.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/model/response/collections/currency/currency.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/CostCenter/cost_center_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/get_all_purchases_request/get_all_purchases_requests.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/store/store_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:http/http.dart' as http;

class InvoiceManager implements InvoiceInterface {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;
  InvoiceManager({
    required this.httpRequestHelper,
    required this.handleResponseHelper,
    required this.authManager,
  });
  @override
  Future<Either<Failures, String>> getImageFromAPI(
      {required String id, required BuildContext context}) async {
    try {
      // Check for network connectivity
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Create the URL for the image request

      var url = Uri.https(
          ApiConstants.chamberApi, "/api/PrintReport/receiptSalesInvoice/$id");
      // Get the token from the authManager
      var user = await authManager.getUser();
      var token = user?.accessToken;
      final http.Response response =
          await apiCall(id: id, url: url, token: token!);

      // Create an HTTP request with authorization headers
      /*   var request = http.Request('GET', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      }); */

      // Send the request and receive a streamed response
      /*   var streamedResponse = await request.send(); */

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        // Step 2: Save PDF file locally
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final File? file = await saveFile(response.bodyBytes, '.pdf', context);

        /*  saveFileToDownloadFolder(
            content: response.bodyBytes, fileName: fileName);
        MediaStore mediaStore = MediaStore();
         String? path =
            await mediaStore.getFilePathFromUri(uriString: file!.uri.path);
        await readFileFromDownloadFolder(fileName); */
        if (file != null) {
          // Step 3: Open the PDF file
          await openFile(file.path);
          return right("Saved Correctly");
        } else {
          print("Failed to save file");

          return left(Failures(errorMessege: "Failed to save file"));
        }
      } else {
        print("Failed to fetch PDF from API. Status: ${response.statusCode}");

        return left(Failures(
            errorMessege:
                "Failed to fetch PDF from API. Status: ${response.statusCode}"));
      }
    } catch (e) {
      // Handle any errors and return them as Failures
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<SalesItemDm>>> fetchPurchaseItemData() async {
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

      return await handleResponseHelper.handleResponse<List<SalesItemDm>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => SalesItemDm.fromJson(item)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, SalesItemDm>> fetchPurchaseItemDataByID(
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

      return await handleResponseHelper.handleResponse<SalesItemDm>(
        response: response,
        fromJson: (json) => SalesItemDm.fromJson(json),
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
  Future<Either<Failures, List<InvoiceCustomerDm>>> fetchCustomerData({
    required int skip,
    required int take,
    String? filter, // Optional filter parameter
  }) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Define query parameters for pagination and filtering
      var queryParams = {
        'skip': skip.toString(),
        'take': take.toString(),
        'requireTotalCount': 'true',
        if (filter != null) 'filter': filter, // Only add filter if provided
      };

      var url = Uri.https(
        ApiConstants.chamberApi,
        ApiConstants.invoiceCustomerDataEndPoint,
        queryParams, // Include the pagination and filter params
      );

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<InvoiceCustomerDm>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => InvoiceCustomerDm.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetAllPurchasesRequests>> deleteSalesInvoiceById(
      {required int id}) {
    // TODO: implement deleteSalesInvoiceById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, int>> postCustomerRequest(
      InvoiceCustomerDm invoiceCustomerDm) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for posting the customer request
      var url = Uri.https(
        ApiConstants.chamberApi,
        ApiConstants.invoiceCustomerDataEndPoint,
        // Include the pagination and filter params
      );
      var user = await authManager.getUser();
      var token = user?.accessToken;
      var requestBody = jsonEncode(invoiceCustomerDm.toJson());
      print("Request Body: $requestBody"); // Print the payload for debugging

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: requestBody, // Convert the customer data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json as int, // Assuming the response is an int
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<InvoiceReportDm>>>
      fetchAllSalesInvoiceData() async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Prepare the API URL for fetching all sales invoices
      var url = Uri.https('${ApiConstants.chamberApi}', '/api/SalesInvoice');

      // Get the user access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Prepare headers
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // Add this line if required for your API
      };

      // Send the GET request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        headers: headers,
      );

      // Handle the response and map it to a list of InvoiceReportDm model
      return await handleResponseHelper.handleResponse<List<InvoiceReportDm>>(
        response: response,
        fromJson: (json) {
          var data = json as List;
          return data.map((item) => InvoiceReportDm.fromJson(item)).toList();
        },
      );
    } catch (e) {
      // Handle errors and return failure
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
  Future<Either<Failures, InvoiceReportDm>> fetchSalesInvoiceDataByID(
      {required int id}) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Prepare the API URL
      var url =
          Uri.https('${ApiConstants.chamberApi}', '/api/SalesInvoice/$id');

      // Get the user access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Prepare headers
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // Add this line if required for your API
      };

      // Send the GET request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        headers: headers,
      );

      // Handle the response and map it to the InvoiceReportDm model
      return await handleResponseHelper.handleResponse<InvoiceReportDm>(
        response: response,
        fromJson: (json) => InvoiceReportDm.fromJson(json),
      );
    } catch (e) {
      // Handle errors and return failure
      return left(Failures(errorMessege: e.toString()));
    }
  }

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
  Future<Either<Failures, int>> postInvoiceRequest(
      InvoiceReportDm invoiceReportDm) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for posting the sales report

      var url = Uri.https(ApiConstants.chamberApi, "/api/SalesInvoice");
      var user = await authManager.getUser();
      var token = user?.accessToken;
      var requestBody = jsonEncode(invoiceReportDm.toJson());
      log("Request Body: $requestBody"); // Print the payload

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(
            invoiceReportDm.toJson()), // Convert the sales report data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json as int, // Assuming response is a string
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<DrawerDm>>> fetchDrawerData() async {
    try {
      // Check if connected to the internet
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(ApiConstants.chamberApi, "/api/Drawer");

      // Construct the URL
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Send the HTTP GET request with Authorization header
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<List<DrawerDm>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) =>
                DrawerDm.fromJson(item)) // Map each JSON item to DrawerDm model
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, DrawerDm>> fetchDrawerDataById(
      {required int drawerId}) async {
    try {
      // Check if connected to the internet
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(ApiConstants.chamberApi, "/api/Drawer/$drawerId");

      // Construct the URL with the drawerId parameter

      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Send the HTTP GET request with Authorization header
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<DrawerDm>(
          response: response, fromJson: (json) => DrawerDm.fromJson(json));
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, InvoiceTaxDm>> fetchTaxByID({required int id}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/Tax/$id');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<InvoiceTaxDm>(
        response: response,
        fromJson: (json) => InvoiceTaxDm.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<InvoiceTaxDm>>> fetchAllTaxes() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url = Uri.https(ApiConstants.chamberApi, '/api/Tax');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<InvoiceTaxDm>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((i) => InvoiceTaxDm.fromJson(i)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<http.Response> apiCall(
      {required String id, required Uri url, required String token}) async {
    // Replace with your token logic.

    final headers = {
      "Authorization": "Bearer $token",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    // Make the API call
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<File?> saveFile(
      Uint8List bytes, String extension, BuildContext context) async {
    // Request storage permission (for Android 6.0 and above)
    bool hasPermission = await checkStoragePermission(context);
    if (hasPermission) {
      final Directory? appDir = Directory('/storage/emulated/0/Documents');

      if (appDir == null) return null;

      String tempPath = appDir.path;
      final String fileName =
          DateTime.now().microsecondsSinceEpoch.toString() + extension;

      // Create a new file and write the bytes
      File file = File('$tempPath/$fileName');
      await file.create();
      await file.writeAsBytes(bytes);
      return file;
    } else if (await Permission.storage.request().isGranted) {
      // Get the appropriate storage directory for Android 10 and above
      final Directory? appDir =
          await Directory('/storage/emulated/0/Documents');
      final Directory? dir = await Directory('/storage/emulated/0/Documents');

      if (appDir == null) return null;

      String tempPath = appDir!.path;
      final String fileName =
          DateTime.now().microsecondsSinceEpoch.toString() + extension;

      // Create a new file and write the bytes
      File file = File('$tempPath/$fileName');
      await file.create();
      await file.writeAsBytes(bytes);
      return file;
    } else {
      // Handle the case when the permission is not granted
      print('Storage permission not granted');
      return null;
    }
  }

  Future<void> openFile(String filePath) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    final storageStatus = android.version.sdkInt! < 33
        ? await Permission.storage.request()
        : await Permission.manageExternalStorage.request();
    if (storageStatus == PermissionStatus.granted) {
      print(storageStatus);
      print("granted");
      final per = await Permission.manageExternalStorage.request();
      final result = await OpenFilex.open(filePath);
      print(result.type);
    } else if (storageStatus == PermissionStatus.denied) {
      print("denied");

      /*  openAppSettings(); */
    } else if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestPermissions() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    final storageStatus = android.version.sdkInt! < 33
        ? await Permission.storage.request()
        : await Permission.manageExternalStorage.request();
    if (storageStatus == PermissionStatus.granted) {
      print("granted");
    }
    if (storageStatus == PermissionStatus.denied) {
      print("denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<bool> checkStoragePermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt ?? 0) >= 33) {
        // No permission needed for Android 13 (API 33) and above
        return true;
      }
    }
    // For Android versions below 13, you can manage permissions if needed

    // Returning true for simplicity, but you can handle permissions differently for older versions
    return false;
  }

  // Check if Android version is 13 or above
  Future<bool> _isAndroid13OrAbove() async {
    return Platform.isAndroid && (await _getAndroidVersion() >= 33);
  }

  // Request media-specific permissions for Android 13+
  Future<bool> _requestMediaPermissions() async {
    PermissionStatus photosPermission = await Permission.photos.request();
    PermissionStatus videosPermission = await Permission.videos.request();
    PermissionStatus audioPermission = await Permission.audio.request();
    PermissionStatus filesPermission =
        await Permission.manageExternalStorage.request();

    return filesPermission.isGranted;
  }

  // Helper function to get the Android version
  Future<int> _getAndroidVersion() async {
    return Platform.version.contains('Android')
        ? int.parse(Platform.operatingSystemVersion.split(' ')[1].split('.')[0])
        : -1; // Return -1 for non-Android platforms
  }

  @override
  Future<Either<Failures, InvoiceReportDm>> updateInvoiceRequest(
      {required InvoiceReportDm invoiceReportDm, required int id}) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for posting the sales report
      var url = Uri.https(ApiConstants.chamberApi, "/api/SalesInvoice/$id");

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var requestBody = jsonEncode(invoiceReportDm.toJson());
      log("Request Body: $requestBody"); // Print the payload

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.PUT,
        url: url,
        token: token,
        body: jsonEncode(
            invoiceReportDm.toJson()), // Convert the sales report data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<InvoiceReportDm>(
        response: response,
        fromJson: (json) =>
            InvoiceReportDm.fromJson(json), // Assuming response is a string
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<InvoiceReportDm>>>
      fetchAllSalesReturnseData() async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Prepare the API URL for fetching all sales invoices
      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.salesReturn);

      // Get the user access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Prepare headers
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // Add this line if required for your API
      };

      // Send the GET request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        headers: headers,
      );

      // Handle 204 No Content response
      if (response.statusCode == 204) {
        // Return an empty list if there is no content
        return right([]);
      }

      // Handle other responses and map them to a list of InvoiceReportDm model
      return await handleResponseHelper.handleResponse<List<InvoiceReportDm>>(
        response: response,
        fromJson: (json) {
          var data = json as List;
          return data.map((item) => InvoiceReportDm.fromJson(item)).toList();
        },
      );
    } catch (e) {
      // Handle errors and return failure
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, InvoiceReportDm>> fetchSalesReturnDataByID(
      {required int id}) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Prepare the API URL
      var url =
          Uri.https(ApiConstants.chamberApi, '${ApiConstants.salesReturn}/$id');

      // Get the user access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Prepare headers
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // Add this line if required for your API
      };

      // Send the GET request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        headers: headers,
      );

      // Handle the response and map it to the InvoiceReportDm model
      return await handleResponseHelper.handleResponse<InvoiceReportDm>(
        response: response,
        fromJson: (json) => InvoiceReportDm.fromJson(json),
      );
    } catch (e) {
      // Handle errors and return failure
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, int>> postSlReturnRequest(
      InvoiceReportDm invoiceReportDm) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url =
          Uri.https(ApiConstants.chamberApi, "${ApiConstants.salesReturn}");

      // Construct the URL for posting the sales report

      var user = await authManager.getUser();
      var token = user?.accessToken;
      var requestBody = jsonEncode(invoiceReportDm.toJson());
      print("Request Body: $requestBody"); // Print the payload

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(
            invoiceReportDm.toJson()), // Convert the sales report data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json as int, // Assuming response is a string
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, InvoiceReportDm>> updateReturnRequest(
      {required InvoiceReportDm invoiceReportDm, required int id}) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for posting the sales report
      var url = Uri.https(
          ApiConstants.chamberApi, "${ApiConstants.salesReturn}/$id}");

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var requestBody = jsonEncode(invoiceReportDm.toJson());
      print("Request Body: $requestBody"); // Print the payload

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.PUT,
        url: url,
        token: token,
        body: jsonEncode(
            invoiceReportDm.toJson()), // Convert the sales report data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<InvoiceReportDm>(
        response: response,
        fromJson: (json) =>
            InvoiceReportDm.fromJson(json), // Assuming response is a string
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, int>> postPrReturnRequest(
      PrInvoiceReportDm invoiceReportDm) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(
          ApiConstants.chamberApi, ApiConstants.purchaseReturnEndPoint);
      // Construct the URL for posting the sales report

      var user = await authManager.getUser();
      var token = user?.accessToken;
      var requestBody = jsonEncode(invoiceReportDm.toJson());
      print("Request Body: $requestBody"); // Print the payload

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: jsonEncode(
            invoiceReportDm.toJson()), // Convert the sales report data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json as int, // Assuming response is a string
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, PrReturnDM>> updatePrReturnRequest(
      {required PrReturnDM invoiceReportDm, required int id}) async {
    try {
      // Check internet connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Construct the URL for posting the sales report
      var url = Uri.https(ApiConstants.chamberApi,
          "/${ApiConstants.purchaseReturnEndPoint}/$id");

      var user = await authManager.getUser();
      var token = user?.accessToken;

      var requestBody = jsonEncode(invoiceReportDm.toJson());
      print("Request Body: $requestBody"); // Print the payload

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.PUT,
        url: url,
        token: token,
        body: jsonEncode(
            invoiceReportDm.toJson()), // Convert the sales report data to JSON
      );

      // Handle and parse the response
      return await handleResponseHelper.handleResponse<PrReturnDM>(
        response: response,
        fromJson: (json) =>
            PrReturnDM.fromJson(json), // Assuming response is a string
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, SlPermissionsDm>> fetchSLPermissionsData() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var user = await authManager.getUser();
      var token = user?.accessToken;
      int? id = user?.id ?? 0;
      var url =
          Uri.https(ApiConstants.chamberApi, '/api/Users/SLPermission/$id');

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<SlPermissionsDm>(
        response: response,
        fromJson: (json) => SlPermissionsDm.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
