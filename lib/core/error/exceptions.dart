class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class UnauthorizedException implements Exception {}

class CacheException implements Exception {
  CacheException();
}

class ConnectionException implements Exception {}
