import 'package:flutter/material.dart';
import 'package:user_registration/features/user_profile/view/user_profile_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _goToProfilePage(),
      ),
      body: ListView.separated(
        itemCount: 10,
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
              "Nome $index",
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () => _goToProfilePage(),
          );
        }
      ),
    );   
  }

  _goToProfilePage() {
    final route = MaterialPageRoute(
      builder: (context) => const UserProfilePage(),
    );
    Navigator.push(context, route);
  }
}