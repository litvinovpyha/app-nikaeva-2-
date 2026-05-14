import 'package:app/core/auth/domain/entities/app_user.dart';
import 'package:app/core/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthPerository implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<AppUser?> loginWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser appUser = AppUser(
        uid: userCredential.user!.uid,
        email: email,
      );

      return appUser;
    } catch (e) {
      throw Exception('Ошибка входа через почту и пароль $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    email,
    password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser appUser = AppUser(
        uid: userCredential.user!.uid,
        email: email,

      );
      return appUser;
    } catch (e) {
      throw Exception('Ошибка регистрации почта+пароль $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) throw Exception('Не найден пользователь');
      await user.delete();
      await logout();
    } catch (e) {
      throw Exception('Ошибка при удалении акаунта $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,

    );
  }

  @override
  Future<void> logout() async => await firebaseAuth.signOut();

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Пароль выслан на указанную почту';
    } catch (e) {
      throw Exception('Ошибка отправки пароля на почту $e');
    }
  }
}
