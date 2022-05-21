import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/features/user_profile/view/user_profile_page.dart';
import 'package:user_registration/shared/connection/api_client.dart';
import 'package:user_registration/shared/models/person_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  late Future<List<PersonModel>> _request;

  @override
  void initState() {
    super.initState();
    _request = getPersons();
  }

  Future<List<PersonModel>> getPersons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return ApiClient().getAll(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _goToProfilePage(null),
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
    Navigator.push(context, route);
  }
}