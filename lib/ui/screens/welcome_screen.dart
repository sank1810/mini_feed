import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/constants_and_extensions/images_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
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
              SizedBox(height: 130),
              Image.asset(ImagesConstants.childrenImage),
              SizedBox(height: 130),
              FilledButton.icon(
                label: Text("C'est parti"),
                icon: Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  // showAuthentificationDialog(context);
                  context.pushNamed('sign_up_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //   showAuthentificationDialog(BuildContext context) {
  //     showGeneralDialog(
  //       barrierDismissible: true,
  //       barrierLabel: "Authentification",
  //       transitionDuration: Duration(microseconds: 400),
  //       context: context,
  //       pageBuilder: (context, animation, secondaryAnimation) {
  //         return Center(
  //           child: Container(
  //             height: 620,
  //             margin: EdgeInsets.symmetric(horizontal: 16),
  //             decoration: BoxDecoration(
  //               color: Colors.white.withValues(alpha: 0.95),
  //               borderRadius: BorderRadius.circular(40),
  //             ),
  //             child: Center(),
  //           ),
  //         ).animate().slideY(
  //           begin: -1,
  //           duration: 400.ms,
  //           curve: Curves.easeInOut,
  //         );
  //       },
  //     );
  //   }
}
