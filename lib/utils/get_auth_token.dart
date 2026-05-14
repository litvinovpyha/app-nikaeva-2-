import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getAuthToken() async {
  final user = FirebaseAuth.instance.currentUser;

  return await user?.getIdToken();
}
