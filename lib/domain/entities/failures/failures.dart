// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failures {
  String errorMessege;
  Failures({
    required this.errorMessege,
  });
}

class ServerError extends Failures {
  ServerError({required super.errorMessege});
}

class NetworkError extends Failures {
  NetworkError({required super.errorMessege});
}
