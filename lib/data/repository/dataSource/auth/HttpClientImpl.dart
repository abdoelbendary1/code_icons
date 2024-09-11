import 'package:code_icons/data/interfaces/IHttpClient.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements IHttpClient {
  @override
  Future<http.StreamedResponse> sendRequest(
      {http.MultipartRequest? multipartRequest, http.Request? request}) {
    if (multipartRequest == null) {
      return request!.send();
    } else {
      return multipartRequest.send();
    }
  }
}
