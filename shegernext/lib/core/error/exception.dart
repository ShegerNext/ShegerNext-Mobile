class ServerException implements Exception {
  final String message;
  final int? statusCode; // Optional: status code of the response

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'ServerException(message: $message, statusCode: ${statusCode ?? 'unknown'})';
  }
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});

  @override
  String toString() {
    return 'CacheException(message: $message)';
  }
}
