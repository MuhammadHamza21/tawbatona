// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  final String message;
  ServerException({
    required this.message,
  });
}

class LocalException implements Exception {
  final String message;
  LocalException({
    required this.message,
  });
}
