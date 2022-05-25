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

      case 404:
        return NotFoundException("${response.statusCode}");

      case 500:
        return ServerException("${response.statusCode}");

      default:
        return AppException("Api Exception ${response.statusCode}: ${response.body}");
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "Not Found: ");
}

class ServerException extends AppException {
  ServerException([message]) : super(message, "Internal Server Error: ");
}

