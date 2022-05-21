import 'package:user_registration/shared/models/login_request_model.dart';
import 'package:user_registration/shared/models/login_response_model.dart';

abstract class IAuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel user);
}