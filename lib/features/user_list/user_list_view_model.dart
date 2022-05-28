import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/repositories/interfaces/iperson_repository.dart';

class UserListViewModel {
  final IPersonRepository repository;

  UserListViewModel(this.repository);

  Future<List<PersonModel>> getPersons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return repository.getAll(token);
  }
}