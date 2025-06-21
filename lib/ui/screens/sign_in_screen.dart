import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/constants_and_extensions/images_constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      //validator: ,
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
                label: const Text("Se connecter"),
                icon: Icon(Icons.arrow_forward),
                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                  minimumSize: WidgetStateProperty.all(
                    Size(double.infinity, 50),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
