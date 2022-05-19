import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_registration/shared/connection/api_route.dart';
import 'package:user_registration/shared/models/login_request_model.dart';
import 'package:user_registration/shared/models/login_response_model.dart';
import 'package:user_registration/shared/models/person_model.dart';

class ApiClient {
  final timeout = const Duration(seconds: 60);

  Future<LoginResponseModel> login(LoginRequestModel user) async {
    final response = await http.post(
      Uri.parse(ApiRoute.authRoute),
      body: json.encode(user),
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(timeout);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LoginResponseModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      throw Exception("Erro: $json");
    }
  }

  Future<bool> post(PersonModel person, String token) async {
    final response = await http.post(
      Uri.parse("${ApiRoute.personRoute}/}"),
      body: json.encode(person),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro: ${response.statusCode}");
    }
  }

  Future<List<PersonModel>> getAll(String token) async {
    final response = await http.get(
      Uri.parse(ApiRoute.personRoute),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      final list = <PersonModel>[];
      final json = jsonDecode(response.body);
      json.forEach((v) {
        list.add(PersonModel.fromJson(v));
      });
      return list;
    } else {
      throw Exception("Erro: ${response.statusCode}");
    }
  }

  Future<PersonModel> get(int id, String token) async {
    final response = await http.get(
      Uri.parse("${ApiRoute.personRoute}/$id}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return PersonModel.fromJson(json);
    } else {
      throw Exception("Erro: ${response.statusCode}");
    }
  }

  Future<bool> put(int id, String token) async {
    final response = await http.put(
      Uri.parse("${ApiRoute.personRoute}/$id}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro: ${response.statusCode}");
    }
  }
    
  Future<bool> delete(int id, String token) async {
    final response = await http.delete(
      Uri.parse("${ApiRoute.personRoute}/$id}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro: ${response.statusCode}");
    }
  }
}