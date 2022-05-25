import 'dart:convert';

import 'package:http/http.dart';
import 'package:user_registration/shared/connection/api_exception.dart';
import 'package:user_registration/shared/connection/api_route.dart';
import 'package:user_registration/shared/models/login_response_model.dart';
import 'package:user_registration/shared/models/login_request_model.dart';
import 'package:user_registration/shared/repositories/interfaces/iauth_repository.dart';

class AuthRepository implements IAuthRepository {

  final Client client;
  final timeout = const Duration(seconds: 60);

  AuthRepository(this.client);

  @override
  Future<LoginResponseModel> login(LoginRequestModel user) async {
    final response = await client.post(
      Uri.parse(ApiRoute.authRoute),
      body: jsonEncode(user),
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(timeout);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LoginResponseModel.fromJson(json);
    } else {
      throw ApiException(response).exception;
    }
  }
}