import 'package:flutter_test/flutter_test.dart';
import 'package:mini_feed/ui/view_models/sign_up_view_model.dart';

void main() {
  test('email validator', () {
    final SignUpViewModel signUpViewModel = SignUpViewModel();
    expect(signUpViewModel.emailValidator("test@example.com"), null);
    expect(signUpViewModel.emailValidator("john.doe@domain.co"), null);
    expect(signUpViewModel.emailValidator("plainaddress"), "email invalide");
    expect(
      signUpViewModel.emailValidator("@no-local-part.com"),
      "email invalide",
    );
    expect(signUpViewModel.emailValidator("username@.com"), "email invalide");
    expect(signUpViewModel.emailValidator(null), "email invalide");
  });

  test('password Validator', () {
    final SignUpViewModel signUpViewModel = SignUpViewModel();
    expect(
      signUpViewModel.passwordValidator("qwe"),
      "votre mot de passe doit contenir au moins 8 caracteres",
    );
    expect(
      signUpViewModel.passwordValidator("19438"),
      "votre mot de passe doit contenir au moins 8 caracteres",
    );
    expect(
      signUpViewModel.passwordValidator("         "),
      "votre mot de passe doit contenir au moins 8 caracteres",
    );
    expect(
      signUpViewModel.passwordValidator(null),
      "votre mot de passe doit contenir au moins 8 caracteres",
    );
    expect(signUpViewModel.passwordValidator("12345678"), null);
  });

  test('user Name Validator', () {
    final SignUpViewModel signUpViewModel = SignUpViewModel();
    expect(
      signUpViewModel.userNameValidator("eds"),
      "votre nom d'utilisateur doit contenir au moins 4 caracteres",
    );
    expect(
      signUpViewModel.userNameValidator(null),
      "votre nom d'utilisateur doit contenir au moins 4 caracteres",
    );
    expect(signUpViewModel.userNameValidator("name"), null);
  });
}
