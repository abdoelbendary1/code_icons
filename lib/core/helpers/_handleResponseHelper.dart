import 'dart:convert';
import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class HandleResponseHelper {
  final HttpRequestHelper httpRequestHelper;

  HandleResponseHelper({
    required this.httpRequestHelper,
  });

  Future<Either<Failures, T>> handleResponse<T>({
    required http.StreamedResponse response,
    required T Function(dynamic json) fromJson,
    Map<int, String>? customErrorMessages,
    String defaultErrorMessage = "حدث خطأ ما",
    T? defaultResponseForNoContent, // Add this to specify what to return for 204
  }) async {
    try {
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        // Handle 204 No Content
        if (response.statusCode == 204) {
          // Return an optional default value for the "No Content" response
          if (defaultResponseForNoContent != null) {
            return right(defaultResponseForNoContent);
          } else {
            // If no default is provided, return a value suitable for T.
            // You might want to define a null value or a default object based on the context.
            return right(fromJson({})); // Assuming an empty object can be used.
          }
        }

        // Normal handling for 2xx responses with body
        String responseBody = await httpRequestHelper.getResponseBody(response);
        dynamic responseBodyJson = jsonDecode(responseBody);
        print(fromJson(responseBodyJson));
        return right(fromJson(responseBodyJson));
      } else {
        // Handle non-success status codes
        print(response.statusCode);
        return left(await handleError(
            response, customErrorMessages, defaultErrorMessage));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }

  Future<Failures> handleError(
    http.StreamedResponse response,
    Map<int, String>? customErrorMessages,
    String defaultErrorMessage,
  ) async {
    String errorMessage =
        customErrorMessages?[response.statusCode] ?? defaultErrorMessage;

    // If the error code is 410, try to extract the error message from the response body
    if (response.statusCode == 410) {
      String responseBody = await httpRequestHelper.getResponseBody(response);
      try {
        var json = jsonDecode(responseBody);
        if (json is Map<String, dynamic> && json.containsKey('message')) {
          return ServerError(errorMessege: json['message']);
        }
      } catch (e) {
        // Handle any parsing errors, fallback to default error message
      }
    }

    switch (response.statusCode) {
      case 400:
        return ServerError(errorMessege: "Bad Request");
      case 401:
        return ServerError(errorMessege: "Unauthorized ");
      case 403:
        return ServerError(errorMessege: "Access is denied ");
      case 404:
        return ServerError(errorMessege: "Not Found ");
      case 500:
        return ServerError(
            errorMessege: "Internal Server Error - $errorMessage");
      default:
        print(response.statusCode);
        return ServerError(errorMessege: errorMessage);
    }
  }
}
