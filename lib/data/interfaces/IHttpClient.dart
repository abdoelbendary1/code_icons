import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.StreamedResponse> sendRequest(
      {http.MultipartRequest multipartRequest, http.Request request});
}
