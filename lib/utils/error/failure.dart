import 'package:equatable/equatable.dart';


/// These concrete classes provide specific implementations of the "Failure" class for different
/// types of failures that may occur in a program. By extending the "Failure" class, they inherit
/// the "message" field and "get props" method, and can be used to represent specific error
/// scenarios in a program.

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(String message) : super(message);
}

class CommonFailure extends Failure {
  CommonFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message);
}
