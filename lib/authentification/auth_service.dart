import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  signUpWithEmail({
    required String email,
    required String password,
    required String userName,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {"userName": userName},
    );
  }

  signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  signOut() async {
    await _supabase.auth.signOut();
  }

  String getUserNAme() {
    return _supabase.auth.currentUser!.userMetadata!["userName"];
  }
}
