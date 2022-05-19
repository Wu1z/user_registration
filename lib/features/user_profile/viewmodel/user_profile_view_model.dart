import 'package:flutter/cupertino.dart';
import 'package:user_registration/shared/utils/regex_utils.dart';

class UserProfileViewModel {
  ValueNotifier<String?> emailErrorText = ValueNotifier(null);
  ValueNotifier<String?> cpfErrorText = ValueNotifier(null);
  
  void validateMail(String value) {
    if(value.isNotEmpty) {
      if(RegexUtils.validateEmail(value)) {
        emailErrorText.value = null;
      } else {
        emailErrorText.value = "Invalid Email"; 
      }
    }
  }

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