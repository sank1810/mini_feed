import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/constants_and_extensions/images_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Bienvenu sur",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              Text(
                "Feed mini",
                style: GoogleFonts.lobster(
                  color: Colors.deepPurple,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(ImagesConstants.childrenImage),
              FilledButton.icon(
                label: Text("C'est parti"),
                icon: Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  context.pushNamed('sign_up_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
