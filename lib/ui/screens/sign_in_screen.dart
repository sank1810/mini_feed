import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/constants_and_extensions/images_constants.dart';

abstract class ISignInViewModel extends ChangeNotifier {
  String? emailValidator(String? email);
  String? passwordValidator(String? password);

  bool get isLoading;
  signIn({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required bool mounted,
  });
}

class SignInScreen extends StatefulWidget {
  final ISignInViewModel _viewMdel;

  const SignInScreen({super.key, required ISignInViewModel viewModel})
    : _viewMdel = viewModel;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                child: Image.asset(ImagesConstants.bird1, fit: BoxFit.cover),
              ),
              Text(
                "Se connecter",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Veuillez entrer vos informations pour vous connecter',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      validator: widget._viewMdel.emailValidator,
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
                      validator: widget._viewMdel.passwordValidator,
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
              AnimatedBuilder(
                animation: widget._viewMdel,
                builder: (context, child) {
                  if (widget._viewMdel.isLoading == true) {
                    return CircularProgressIndicator();
                  } else {
                    return FilledButton.icon(
                      label: const Text("Se connecter"),
                      icon: Icon(Icons.arrow_forward),
                      style: Theme.of(context).filledButtonTheme.style!
                          .copyWith(
                            minimumSize: WidgetStateProperty.all(
                              Size(double.infinity, 50),
                            ),
                          ),
                      onPressed: () {
                        widget._viewMdel.signIn(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey,
                          context: context,
                          mounted: mounted,
                        );
                      },
                    );
                  }
                },
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
                  Text("Vous n'avez pas de compte ? "),
                  GestureDetector(
                    onTap: () {
                      context.pushReplacementNamed('sign_up_screen');
                    },
                    child: Text(
                      "inscrivez-vous",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
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
