abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure({String? message})
      : super(message ?? "Something went wrong");
}

class ClientFailure extends Failure {
  const ClientFailure({required String message}) : super(message);
}
