import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/features/user_profile/view/user_profile_page.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/repositories/person_repository.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  late Future<List<PersonModel>> _request;
  final _repository = PersonRepository(Client());

  @override
  void initState() {
    super.initState();
    _request = getPersons();
  }

  Future<List<PersonModel>> getPersons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return _repository.getAll(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _goToProfilePage(PersonModel()),
      ),
      body: FutureBuilder<List<PersonModel>>(
        future: _request,
        builder: (_, snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            final List<PersonModel> persons = snapshot.data!;
            return ListView.separated(
              itemCount: persons.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (_, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: Icon(
                    Icons.person, 
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  title: Text(
                    "${persons[index].name}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTap: () => _goToProfilePage(persons[index]),
                );
              }
            );
          } else if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }
        }
      ),
    );   
  }

  _goToProfilePage(PersonModel? person) async {
    final route = MaterialPageRoute(
      builder: (context) => UserProfilePage(person: person),
    );
    final success = await Navigator.push(context, route);
    _showSuccessMessage(success);
  }

  _showSuccessMessage(bool success) {
    if(success) {
      final snackBar = SnackBar(
        content: const Text(
          'Person successfuly registered!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87.withOpacity(0.8),
        margin: const EdgeInsets.all(20),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}