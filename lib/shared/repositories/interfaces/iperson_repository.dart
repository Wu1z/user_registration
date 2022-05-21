import 'package:user_registration/shared/models/person_model.dart';

abstract class IPersonRepository {
  Future<List<PersonModel>> getAll(String? token);
  Future<PersonModel> get(String id, String? token);
  Future<bool> put(PersonModel id, String? token);
  Future<bool> delete(String? id, String? token);
  Future<bool> post(PersonModel person, String? token);
}