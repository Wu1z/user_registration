import 'dart:convert';

import 'package:http/http.dart';
import 'package:user_registration/shared/models/exception_model.dart';

class ApiException {
  final Response response;

  ApiException(this.response);

  AppException get exception {
    switch(response.statusCode) {
      case 400:
        final exception = ExceptionModel.fromJson(jsonDecode(response.body));
        return BadRequestException(exception.message);

      case 401:
        final exception = ExceptionModel.fromJson(jsonDecode(response.body));
        return UnauthorisedException(exception.message);

      case 403:
        final exception = ExceptionModel.fromJson(jsonDecode(response.body));
        return InvalidTokenException(exception.message);

      case 404:
        final exception = ExceptionModel.fromJson(jsonDecode(response.body));
        return NotFoundException(exception.message);

      case 422:
        final exception = ExceptionModel.fromJson(jsonDecode(response.body));
        return DuplicateException(exception.message);

      case 500:
        final exception = ExceptionModel.fromJson(jsonDecode(response.body));
        return ServerException(exception.message);

      default:
        return AppException(response.body, "Api Exception ${response.statusCode}: ",);
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    String result = '';
    if(prefix != null) result = "$prefix";
    if(message != null) result = "$result$message";
    return result;
  }
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidTokenException extends AppException {
  InvalidTokenException([message]) : super(message, "Invalid Token: ");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "Not Found: ");
}

class DuplicateException extends AppException {
  DuplicateException([message]) : super(message, "Duplicate Person: ");
}

class ServerException extends AppException {
  ServerException([message]) : super(message, "Internal Server Error: ");
}

