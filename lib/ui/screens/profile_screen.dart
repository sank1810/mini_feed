import 'package:flutter/material.dart';
import 'package:mini_feed/authentification/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService authService = AuthService();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
          ],
        )),
    );
  }
}
