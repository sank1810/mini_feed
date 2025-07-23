import 'package:flutter/material.dart';
import 'package:mini_feed/supabase/auth_service.dart';
import 'package:mini_feed/constants_and_extensions/strings_extensions.dart';
import 'package:mini_feed/ui/screens/sign_up_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpViewModel extends ISignUpViewModel {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  @override
  bool get isLoading => _isLoading;

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
  void signUp({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController userNameController,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required bool mounted,
  }) async {
    final String email = emailController.text;
    final String password = passwordController.text;
    String errorMessage = 'Une erreur est survenue';
    if (formKey.currentState?.validate() ?? false) {
      try {
        _isLoading = true;
        notifyListeners();
        await _authService.signUpWithEmail(
          email: email,
          password: password,
          userName: userNameController.text,
        );
      } catch (e) {
        if (e is AuthApiException &&
            e.message.contains("User already registered")) {
          errorMessage = "Cet compte existe déjà";
        }
        if (mounted) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
      _isLoading = false;
      notifyListeners();
    }
  }
}
