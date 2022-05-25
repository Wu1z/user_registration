import 'dart:convert';

import 'package:http/http.dart';
import 'package:user_registration/shared/connection/api_exception.dart';
import 'package:user_registration/shared/connection/api_route.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/repositories/interfaces/iperson_repository.dart';

class PersonRepository implements IPersonRepository {
  final Client client;
  final timeout = const Duration(seconds: 60);

  PersonRepository(this.client);

  @override
  Future<bool> delete(String? id, String? token) async {
    final response = await client.delete(
      Uri.parse("${ApiRoute.personRoute}/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw ApiException(response).exception;
    }
  }

  @override
  Future<PersonModel> get(String? id, String? token) async {
    final response = await client.get(
      Uri.parse("${ApiRoute.personRoute}/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return PersonModel.fromJson(json);
    } else {
      throw ApiException(response).exception;
    }
  }

  @override
  Future<List<PersonModel>> getAll(String? token) async {
    final response = await client.get(
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
      throw ApiException(response).exception;
    }
  }

  @override
  Future<bool> post(PersonModel person, String? token) async {
    final response = await client.post(
      Uri.parse("${ApiRoute.personRoute}/"),
      body: json.encode(person),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw ApiException(response).exception;
    }
  }

  @override
  Future<bool> put(PersonModel person, String? token) async {
    final response = await client.put(
      Uri.parse("${ApiRoute.personRoute}/${person.id}"),
      body: jsonEncode(person),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ).timeout(timeout);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw ApiException(response).exception;
    }
  }
}