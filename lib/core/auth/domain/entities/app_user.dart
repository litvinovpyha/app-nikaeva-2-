class AppUser {
  final String uid;
  final String email;

  AppUser({required this.uid, required this.email});
  // to   json
  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};
  // from json
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) =>
      AppUser(uid: jsonUser['uid'], email: jsonUser['email']); 
}
