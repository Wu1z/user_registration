import 'package:flutter/material.dart';
import 'package:user_registration/features/user_list/view/user_list_page.dart';
import 'package:user_registration/shared/widgets/default_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                DefaultTextField(
                  label: "User", 
                  controller: _usernameController,
                  maxLength: 20,
                  inputType: TextInputType.emailAddress,
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                DefaultTextField(
                  label: "Password", 
                  controller: _passwordController,
                  isPassword: _hidePassword,
                  maxLength: 10,
                  icon: const Icon(Icons.key_rounded),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye_rounded),
                    color: _hidePassword 
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                    onPressed: () => _onShowPassword()
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    height: 60,
                    onPressed: () => _goToUsersPage(),
                    child: Text(
                      "ENTER",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary, 
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );   
  }

  _onShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  _goToUsersPage() {
    final route = MaterialPageRoute(
      builder: (context) => const UserListPage(),
    );
    Navigator.push(context, route);
  }

}