import 'dart:io';

import 'package:mini_feed/supabase/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSettings {
  final AuthService _authService = AuthService();
  final _supabase = Supabase.instance.client;

  Future changeProfileImage({required File file}) async {
    final User? currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      final String path = currentUser.id;
      await _supabase.storage
          .from('avatars')
          .upload(path, file, fileOptions: FileOptions(upsert: true));
      final String publicUrl = _supabase.storage
          .from('avatars')
          .getPublicUrl(currentUser.id);
      await _supabase
          .from('app_users')
          .update({'profileImage': publicUrl})
          .eq('uid', currentUser.id);
    }
  }

  deleteProfileImage() async {
    final User? currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      await _supabase.storage.from('avatars').remove([currentUser.id]);
      await _supabase
          .from('app_users')
          .update({'profileImage': null})
          .eq('uid', currentUser.id);
    }
  }
}
