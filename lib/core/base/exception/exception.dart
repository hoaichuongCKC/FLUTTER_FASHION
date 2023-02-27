// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  static const String message =
      'The server encountered an error or the user had a problem making the request';

  @override
  String toString() {
    return message;
  }
}

class InternetException implements Exception {
  static const String message = 'Internet error!';

  @override
  String toString() {
    return message;
  }
}

class UnknownException implements Exception {
  static const String message = 'Something wrong!';

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {}

class FirebaseException implements Exception {}

class ParamRequestException implements Exception {
  static const String message = 'Param check, please!';

  @override
  String toString() {
    return message;
  }
}

class ConnectTimeoutHttpException implements Exception {
  static const String message = 'Connect-timeout';

  @override
  String toString() {
    return message;
  }
}

class AuthenticatedException implements Exception {
  static const String message = 'Unauthenticated!!';

  @override
  String toString() {
    return message;
  }
}
