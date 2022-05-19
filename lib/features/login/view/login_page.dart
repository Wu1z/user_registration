import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/features/user_list/view/user_list_page.dart';
import 'package:user_registration/shared/connection/api_client.dart';
import 'package:user_registration/shared/models/login_request_model.dart';
import 'package:user_registration/shared/models/login_response_model.dart';
import 'package:user_registration/shared/utils/my_preferences.dart';
import 'package:user_registration/shared/widgets/async_button.dart';
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
  bool _isLoading = false;

  Future<LoginResponseModel> login() async {
    final user = LoginRequestModel(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    return ApiClient().login(user);
  }

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
                AsyncButton(
                  text: "ENTER",
                  isLoading: _isLoading,
                  onPressed: _startLoading
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

  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });
    await login().then((value) async {
      if(value.token != null) {
        await _saveToken(value);
        _goToUsersPage();
      }
    }).catchError((error, stackTrace) {
      _showError();
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveToken(LoginResponseModel value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", value.token!);
  }

  void _showError() {
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          content: const Text("Error no login"),
          actions: [
            ElevatedButton(
              child: const Text("CONFIRM"),
              onPressed: () {
                Navigator.pop(context);
              }, 
            ),
          ],
        );
      }
    );
  }

}