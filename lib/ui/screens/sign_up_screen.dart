import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/constants_and_extensions/images_constants.dart';

abstract class ISignUpViewModel extends ChangeNotifier {
  String? emailValidator(String? email);
  String? passwordValidator(String? email);
  String? userNameValidator(String? email);
  bool get isLoading;

  void signUp({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController userNameController,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required bool mounted,
  });
}

class SignUpSreen extends StatefulWidget {
  final ISignUpViewModel _viewModel;

  const SignUpSreen({super.key, required ISignUpViewModel viewModel})
    : _viewModel = viewModel;

  @override
  State<SignUpSreen> createState() => _SignUpSreenState();
}

class _SignUpSreenState extends State<SignUpSreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                      validator: widget._viewModel.userNameValidator,
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
                      validator: widget._viewModel.emailValidator,
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
                      validator: widget._viewModel.passwordValidator,
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
                animation: widget._viewModel,
                builder: (context, child) {
                  if (widget._viewModel.isLoading == true) {
                    return CircularProgressIndicator();
                  } else {
                    return FilledButton.icon(
                      label: const Text("S'inscrire"),
                      icon: Icon(Icons.arrow_forward),
                      style: Theme.of(context).filledButtonTheme.style!
                          .copyWith(
                            minimumSize: WidgetStateProperty.all(
                              Size(double.infinity, 50),
                            ),
                          ),
                      onPressed: () {
                        widget._viewModel.signUp(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          userNameController: _userNameController,
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
                  Text("Vous avez déjà un compte ? "),
                  GestureDetector(
                    onTap: () {
                      context.pushReplacementNamed('sign_in_screen');
                    },
                    child: Text(
                      "connectez vous",
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
