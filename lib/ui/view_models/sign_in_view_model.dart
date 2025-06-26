import 'package:flutter/material.dart';
import 'package:mini_feed/authentification/auth_service.dart';
import 'package:mini_feed/constants_and_extensions/strings_extensions.dart';
import 'package:mini_feed/ui/screens/sign_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInViewModel extends ISignInViewModel {
  final AuthService _authService = AuthService();
  bool _isloading = false;

  @override
  bool get isLoading => _isloading;

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
  signIn({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required bool mounted,
  }) async {
    final email = emailController.text;
    final password = passwordController.text;
    String errorMessage = 'Une erreur est survenue';
    if (formKey.currentState?.validate() ?? false) {
      try {
        _isloading = true;
        notifyListeners();
        await _authService.signInWithEmailPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        if (e is AuthApiException &&
            e.message.contains('Invalid login credentials')) {
          errorMessage = "email ou mot de passe incorrect";
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
      _isloading = false;
      notifyListeners();
    }
  }
}
