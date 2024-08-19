class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class ClientException implements Exception {
  final String? message;
  const ClientException({this.message = "Something went wrong"});
}
