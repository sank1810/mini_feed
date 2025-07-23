class AppUser {
  int? id;
  String uid;
  String userName;
  String? profileImage;
  String email;
  AppUser({
    required this.uid,
    required this.userName,
    this.profileImage,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'profileImage': profileImage,
      'email': email,
    };
  }
}
