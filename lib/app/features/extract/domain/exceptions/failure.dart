abstract class Failure implements Exception {}

class GenericFailure extends Failure {}

class ServerFailure extends Failure {
  final String code;
  final String message;

  ServerFailure({this.code, this.message});
}

class NoConnectionFailure extends Failure {}

class ResourceNotFoundFailure extends Failure {}
