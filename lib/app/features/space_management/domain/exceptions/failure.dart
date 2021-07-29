abstract class Failure implements Exception {}

class GenericFailure extends Failure {}

class ServerFailure extends Failure {
  final String code;
  final String message;

  ServerFailure({this.code, this.message});
}

class InvalidSpaceFailure extends Failure {}

class TicketProcessedFailure extends Failure {}

class InvalidAmountFailure extends Failure {}

class InvalidTicketFailure extends Failure {}

class InvalidPlaceFailure extends Failure {}

class NoConnectionFailure extends Failure {}

class ResourceNotFoundFailure extends Failure {}
