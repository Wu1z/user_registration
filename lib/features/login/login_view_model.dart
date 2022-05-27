import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/shared/models/login_request_model.dart';
import 'package:user_registration/shared/models/login_response_model.dart';
import 'package:user_registration/shared/repositories/interfaces/iauth_repository.dart';

class LoginViewModel {

  final IAuthRepository repository;

  LoginViewModel(this.repository);

  Future<LoginResponseModel> login({required String username, required String password}) async {
    final user = LoginRequestModel(
      username: username,
      password: password,
    );
    return repository.login(user);
  }

  Future<void> saveToken(LoginResponseModel? value) async {
    if(value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", value.token!);
    }
  }
}