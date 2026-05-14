import 'package:app/core/auth/domain/entities/app_user.dart';
import 'package:app/core/auth/domain/repository/auth_repository.dart';
import 'package:app/core/auth/presentation/cubits/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubits extends Cubit<AuthState> {
  final AuthRepository r;
  AppUser? _currentUser;
  AuthCubits({required this.r}) : super(AuthInitial());

  AppUser? get currentUser => _currentUser;
  bool get isAdmin => _currentUser?.email == 'indigoshop_kz@mail.ru';
  void checkAuth() async {
    //loading...
    emit(AuthLoading());

    // get current user
    final AppUser? user = await r.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // login with email and pw
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());
      final user = await r.loginWithEmailPassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // Register with email and pw
  Future<void> register(String name, String email, String pw) async {
    try {
      emit(AuthLoading());
      final user = await r.registerWithEmailPassword(name, email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    emit(AuthLoading());
    await r.logout();
    emit(Unauthenticated());
  }

  // reset pw
  Future<String> resetpw(String email) async {
    emit(AuthLoading());

    final message = await r.sendPasswordResetEmail(email);

    emit(Unauthenticated());

    return message;
  }

  //delete  account
  Future<void> delete() async {
    try {
      emit(AuthLoading());

      await r.deleteAccount();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
