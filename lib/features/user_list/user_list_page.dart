import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:user_registration/features/user_list/user_list_view_model.dart';
import 'package:user_registration/features/user_profile/user_profile_page.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/models/register_action_enum.dart';
import 'package:user_registration/shared/repositories/person_repository.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  late Future<List<PersonModel>> _request;
  late UserListViewModel _viewModel;
  final _repository = PersonRepository(Client());

  @override
  void initState() {
    _viewModel = UserListViewModel(_repository);
    _request = _viewModel.getPersons();
    super.initState();
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

  void _goToProfilePage(PersonModel? person) async {
    final route = MaterialPageRoute(
      builder: (context) => UserProfilePage(person: person),
    );
    final success = await Navigator.push(context, route);
    _onReturn(success);
  }

  void _onReturn(RegisterAction? action) {
    if(action != null) {
      _refresh();
      _showSnackBar('Person succesfuly ${action.value}!');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
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

  void _refresh() {
    setState(() {
      _request = _viewModel.getPersons();
    });
  }
}