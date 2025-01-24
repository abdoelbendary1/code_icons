// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:code_icons/data/model/request/add_purchase_request/invoice/salesItem.dart';
import 'package:code_icons/data/model/request/storage/salesItem_request.dart';
import 'package:code_icons/data/model/response/storage/itemCategory/item_category_dm.dart';
import 'package:code_icons/data/model/response/storage/itemCompany/item_company_dm.dart';
import 'package:code_icons/domain/entities/storage/itemCategory/item_category_entity.dart';
import 'package:code_icons/domain/entities/storage/itemCompany/item_company_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/api_constants.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/storage/IStorage.dart';
import 'package:code_icons/data/model/response/purchases/purchase_request/Uom/uom_data_model.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';

class StorageManager implements IStorage {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;
  StorageManager({
    required this.httpRequestHelper,
    required this.handleResponseHelper,
    required this.authManager,
  });

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
  Future<Either<Failures, SalesItemDm>> addItemData(
      {required ItemRequest item}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }
      var url = Uri.https(ApiConstants.chamberApi, ApiConstants.itemEndPoint);

      var user = await authManager.getUser();
      var token = user?.accessToken;
      var requestBody = jsonEncode(item.toJson());

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: requestBody,
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
  Future<Either<Failures, List<ItemCategoryEntity>>>
      fetchItemCategories() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.itemCategoryEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper
          .handleResponse<List<ItemCategoryEntity>>(
        response: response,
        fromJson: (json) => (json as List)
            .map((item) => ItemCategoryDm.fromJson(item))
            .toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ItemCompanyEntity>>> fetchItemCompanies() async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.itemCompanyEndPoint);
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.GET,
        url: url,
        token: token,
      );

      return await handleResponseHelper.handleResponse<List<ItemCompanyEntity>>(
        response: response,
        fromJson: (json) =>
            (json as List).map((item) => ItemCompanyDm.fromJson(item)).toList(),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, int>> postItemCategory(
      {required ItemCategoryDm itemCategoryEntity}) async {
    try {
      // Check for network connection
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // API URL
      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.itemCategoryEndPoint);
      // Get user token (if needed)
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Request body
      var requestBody = jsonEncode(itemCategoryEntity.toJson());

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token, // Assuming Authorization is required, include the token
        body: requestBody,
      );

      // Handle the response
      return await handleResponseHelper.handleResponse<int>(
        response: response,
        fromJson: (json) => json,
      );
    } catch (e) {
      // Return error if something goes wrong
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, ItemCompanyEntity>> postItemCompany(
      {required ItemCompanyDm itemCompanyEntity}) async {
    try {
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // API URL
      var url =
          Uri.https(ApiConstants.chamberApi, ApiConstants.itemCompanyEndPoint);

      // Get user token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Request body
      var requestBody = jsonEncode(itemCompanyEntity.toJson());

      // Send the POST request
      var response = await httpRequestHelper.sendRequest(
        method: HttpMethod.POST,
        url: url,
        token: token,
        body: requestBody,
      );

      // Handle the response
      return await handleResponseHelper.handleResponse<ItemCompanyEntity>(
        response: response,
        fromJson: (json) => ItemCompanyDm.fromJson(json),
      );
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
