import 'package:flutter/material.dart';

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
      body: ListView.separated(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(thickness: 1),
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
            trailing: const Icon(
              Icons.arrow_forward_rounded,
            ),
            onTap: () => _goToProfilePage(),
          );
        }
      ),
    );   
  }

  _goToProfilePage() {
    debugPrint('');
  }
}