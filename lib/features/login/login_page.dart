import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:user_registration/features/login/login_view_model.dart';
import 'package:user_registration/features/user_list/user_list_page.dart';
import 'package:user_registration/shared/connection/api_exception.dart';
import 'package:user_registration/shared/repositories/auth_repository.dart';
import 'package:user_registration/shared/widgets/async_button.dart';
import 'package:user_registration/shared/widgets/default_text_field.dart';
import 'package:user_registration/shared/widgets/error_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repository = AuthRepository(Client());
  late LoginViewModel _viewModel;
  bool _hidePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    _viewModel = LoginViewModel(_repository);
    super.initState();
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
                  onPressed: _onEnterLogin
                ),
              ],
            ),
          ),
        ),
      ),
    );   
  }

  void _onEnterLogin() async {
    _changeLoadingState(true);
    await _onLoginResult();
    _changeLoadingState(false);
  }

  Future<void> _onLoginResult() async {
    await _viewModel.login(
      username: _usernameController.text,
      password: _passwordController.text
    ).then((value) async {
      await _viewModel.saveToken(value);
      _goToUsersPage();
    }).catchError((error, stackTrace) {
      _showError(error);
    });
  }

  void _onShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _changeLoadingState(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _goToUsersPage() {
    final route = MaterialPageRoute(
      builder: (context) => const UserListPage(),
    );
    Navigator.push(context, route);
  }

  void _showError(AppException error) {
    showDialog(
      context: context, 
      builder: (_) {
        return ErrorDialog(message: error.toString());
      }
    );
  }

}