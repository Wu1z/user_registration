import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/features/user_profile/view/user_profile_page.dart';
import 'package:user_registration/shared/widgets/default_text_field.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  final _searchController = TextEditingController();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DefaultTextField(
              label: "Search", 
              controller: _searchController,
              inputType: TextInputType.number,
              inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
              ],
              icon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
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
          ),
        ],
      ),
    );   
  }

  _goToProfilePage() async {
    // final route = MaterialPageRoute(
    //   builder: (context) => const UserProfilePage(),
    // );
    // Navigator.push(context, route);
  }
}