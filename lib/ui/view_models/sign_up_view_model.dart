import 'package:flutter/material.dart';
import 'package:mini_feed/constants_and_extensions/strings_extensions.dart';
import 'package:mini_feed/ui/screens/sign_up_screen.dart';

class SignUpViewModel extends ChangeNotifier implements ISignUpViewModel {
  @override
  String? emailValidator(String? email) {
    if (email == null) {
      return "email invalide";
    } else {
      if (email.isValidEmail) {
        return null;
      } else {
        return "email invalide";
      }
    }
  }

  @override
  String? passwordValidator(String? password) {
    if (password != null && password.trim().length >= 8) {
      return null;
    } else {
      return "votre mot de passe doit contenir au moins 8 caracteres";
    }
  }

  @override
  String? userNameValidator(String? userName) {
    if (userName != null && userName.trim().length >= 4) {
      return null;
    } else {
      return "votre nom d'utilisateur doit contenir au moins 4 caracteres";
    }
  }

  @override
  void validateInformations() {}
}
