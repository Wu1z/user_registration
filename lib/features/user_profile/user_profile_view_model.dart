import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_registration/shared/models/person_model.dart';
import 'package:user_registration/shared/repositories/interfaces/iperson_repository.dart';
import 'package:user_registration/shared/utils/regex_utils.dart';

class UserProfileViewModel {

  final IPersonRepository repository;

  UserProfileViewModel(this.repository);

  Future<bool> post(PersonModel person, String? token) async {
    return repository.post(person, token);
  }

  Future<bool> put(PersonModel person, String? token) async {
    return repository.put(person, token);
  }
  
  Future<bool> delete(PersonModel? person, String? token) async {
    return repository.delete(person?.id, token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return token;
  }
  
  ValueNotifier<String?> emailErrorText = ValueNotifier(null);
  void validateMail(String value) {
    if(value.isNotEmpty) {
      if(RegexUtils.validateEmail(value)) {
        emailErrorText.value = null;
      } else {
        emailErrorText.value = "Invalid Email"; 
      }
    }
  }

  ValueNotifier<String?> cpfErrorText = ValueNotifier(null);
  void validateCpf(String value) {
    if(value.isNotEmpty) {
      if(RegexUtils.cpfValidator(value)) {
        cpfErrorText.value = null;
      } else {
        cpfErrorText.value = "Invalid CPF"; 
      }
    }
  }
}