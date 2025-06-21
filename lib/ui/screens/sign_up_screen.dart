import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/constants_and_extensions/images_constants.dart';

abstract class ISignUpViewModel {
  String? emailValidator(String? email);
  String? passwordValidator(String? email);
  String? userNameValidator(String? email);
  void validateInformations();
}

class SignUpSreen extends StatelessWidget {
  final ISignUpViewModel _viewModel;
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  SignUpSreen({super.key, required ISignUpViewModel viewModel})
    : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 170,
                child: Image.asset(ImagesConstants.bird2, fit: BoxFit.cover),
              ),
              Text(
                "S'inscrire",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Une application faite par un parfait amateur, ne vous étonez pas si vous trouvez des bugs 😁",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _userNameController,
                      validator: _viewModel.userNameValidator,
                      decoration: InputDecoration(
                        label: Text("nom d'utilisateur"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImagesConstants.nameSvg,
                            colorFilter: const ColorFilter.mode(
                              Colors.deepPurple,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        prefixIconColor: Colors.deepPurple,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      validator: _viewModel.emailValidator,
                      decoration: InputDecoration(
                        label: Text("email"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImagesConstants.mailSvg,
                            colorFilter: const ColorFilter.mode(
                              Colors.deepPurple,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        prefixIconColor: Colors.deepPurple,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      validator: _viewModel.passwordValidator,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text("mot de passe"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            ImagesConstants.passwordSvg,
                            colorFilter: const ColorFilter.mode(
                              Colors.deepPurple,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        prefixIconColor: Colors.deepPurple,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              FilledButton.icon(
                label: const Text("S'inscrire"),
                icon: Icon(Icons.arrow_forward),
                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                  minimumSize: WidgetStateProperty.all(
                    Size(double.infinity, 50),
                  ),
                ),
                onPressed: () {},
              ),
              SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Text("  ou  ", style: TextStyle(color: Colors.black38)),
                  Expanded(child: Divider()),
                ],
              ),

              Row(
                children: [
                  Spacer(),
                  Text("Vous avez déjà un compte ? "),
                  TextButton(
                    onPressed: () {
                      context.pop();
                      context.pushNamed('sign_in_screen');
                    },
                    child: Text("connectez-vous"),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
