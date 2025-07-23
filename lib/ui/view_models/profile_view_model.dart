import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_feed/supabase/auth_service.dart';
import 'package:mini_feed/supabase/profile_settings.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileSettings _profileSettings = ProfileSettings();
  final AuthService _authService = AuthService();
  String? _profileImageUrl;

  String? get profileImageUrl => _profileImageUrl;

  ProfileViewModel() {
    loadProfileImage();
  }

  loadProfileImage() async {
    _profileImageUrl = await _authService.getprofileImage();
    notifyListeners();
  }

  editAvatar(ImageSource source) async {
    final piker = ImagePicker();
    final XFile? xFile = await piker.pickImage(source: source);
    if (xFile != null) {
      final File file = File(xFile.path);
      await _profileSettings.changeProfileImage(file: file);
      await loadProfileImage();
      //notifyListeners();
    }
  }

  // Future<String?> getProfileImage() async {
  //   final profileImage = await _authService.getprofileImage();
  //   return profileImage;
  // }
}
