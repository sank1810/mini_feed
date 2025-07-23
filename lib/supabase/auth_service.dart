import 'package:mini_feed/models/app_user.dart';
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
    //create a user and add him to the app_users table
    if (_supabase.auth.currentUser != null) {
      final AppUser newUser = AppUser(
        uid: _supabase.auth.currentUser!.id,
        userName: userName,
        email: email,
      );
      await _supabase.from('app_users').insert(newUser.toMap());
    }
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

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  Future<String> getUserName() async {
    try {
      final User? currentUser = _supabase.auth.currentUser;

      if (currentUser != null) {
        final response = await _supabase
            .from('app_users')
            .select('userName')
            .eq('uid', currentUser.id)
            .single();
        final userName = response['userName'];

        return userName;
      } else {
        return "erreur";
      }
    } catch (e) {
      return "erreur";
    }
  }

  Future<String?> getprofileImage() async {
    final User? currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      return null;
    }
    final data = await _supabase
        .from('app_users')
        .select('profileImage')
        .eq('uid', currentUser.id)
        .single();
    return data['profileImage'];
  }
}
