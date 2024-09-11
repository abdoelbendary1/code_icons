import 'package:code_icons/core/enums/http_methods.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/interfaces/IHttpClient.dart';
import 'package:http/http.dart' as http;

class HttpRequestHelper {
  final IHttpClient httpClient;

  HttpRequestHelper({
    required this.httpClient,
  });

  Future<http.StreamedResponse> sendRequest({
    required HttpMethod method,
    required Uri url,
    Map<String, String>? headers,
    Map<String, String>? fields,
    String? body,
    String contentType = "application/json",
    String? token,
  }) async {
    // Retrieve the token from the AuthManager
    /* var user = await authManager.getUser();
    var token = user?.accessToken; */

    // Ensure headers exist and include the Authorization header
    headers = headers ?? {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (method == HttpMethod.POST || method == HttpMethod.PUT) {
      headers['Content-Type'] = contentType;
    }

    var request = http.Request(method.name, url);

    if (fields != null &&
        (method == HttpMethod.POST || method == HttpMethod.PUT)) {
      var multipartRequest = http.MultipartRequest(method.name, url);
      multipartRequest.fields.addAll(fields);
      multipartRequest.headers.addAll(headers);
      return await httpClient.sendRequest(multipartRequest: multipartRequest);
    }

    if (body != null &&
        (method == HttpMethod.POST || method == HttpMethod.PUT)) {
      request.body = body;
    }

    request.headers.addAll(headers);

    return await httpClient.sendRequest(request: request);
  }

  Future<String> getResponseBody(http.StreamedResponse response) async {
    var responseBody = await response.stream.bytesToString();
    return responseBody;
  }
}
