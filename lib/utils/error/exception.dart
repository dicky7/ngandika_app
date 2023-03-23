
//this class will be using in remote_data_source class and
// when then response error they will be throw ServerException
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
