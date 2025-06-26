import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_feed/authentification/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mini Feed", style: GoogleFonts.lobster(fontSize: 32)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _authService.signOut,
          child: Text("Se deconnecter"),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
