import 'package:user_registration/shared/models/person_model.dart';

abstract class IPersonRepository {
  Future<dynamic> getAll();
  Future<dynamic> get(int id);
  Future<dynamic> update(int id);
  Future<dynamic> delete(int id);
  Future<dynamic> post(PersonModel person);
}