// ignore_for_file: constant_identifier_names

enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

extension HttpMethodExtension on HttpMethod {
  String get name {
    switch (this) {
      case HttpMethod.GET:
        return 'GET';
      case HttpMethod.POST:
        return 'POST';
      case HttpMethod.PUT:
        return 'PUT';
      case HttpMethod.DELETE:
        return 'DELETE';
      case HttpMethod.PATCH:
        return 'PATCH';
    }
  }
}
