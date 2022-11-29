import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/network/base_exception.dart';
import '../../../core/network/exceptions.dart';
import '../../../data/constants.dart';
import '../../../data/data_sources/local/secure_storage.dart';
import '../../../data/repositories/user_auth_api_repository_impl.dart';
import '../../../data/repositories/user_auth_repository_impl.dart';
import '../../../utils/utilities.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._userAuthRepository, this._userAuthAPIRepository)
      : super(const UserAuthInitial()) {
    on<UserSignInWithGoogle>(_onGoogleSignIn);
    on<UserSignOut>(_onSignOut);
    on<UserSignInWithFacebook>(_onFacebookSignIn);
    on<UserSignInWithApple>(_onAppleSignIn);
    on<UserSignUpWithEmail>(_onEmailSignUp);
    on<UserSignInWithEmail>(_onEmailSignIn);
  }

  final UserAuthRepository _userAuthRepository;
  final UserAuthAPIRepository _userAuthAPIRepository;
  final Utilities _utilities = Utilities();
  Auth? auth;

  FutureOr<void> _onEmailSignIn(
      UserSignInWithEmail event, Emitter<AuthState> emit) async {
    try {
      emit(const UserAuthLoading());
      final String? token =
          await _userAuthAPIRepository.login(event.email, event.password);
      if (token == null) {
        throw BaseAppException(message: 'Sign-in failed');
      }
      await SecureStorage.saveToken(token);
      emit(const UserAuthInitial());
    } on BackendException catch (e) {
      emit(UserAuthFailed(
          _utilities.getResponseError(e.message) ?? e.message.toString()));
    } catch (e) {
      emit(UserAuthFailed(e.toString()));
    }
  }

  FutureOr<void> _onEmailSignUp(
      UserSignUpWithEmail event, Emitter<AuthState> emit) async {
    try {
      emit(const UserAuthLoading());
      final String? token = await _userAuthAPIRepository.register(
          event.email, event.name, event.password);
      if (token == null) {
        throw BaseAppException(message: 'Sign-up failed');
      }
      await SecureStorage.saveToken(token);
      emit(const UserAuthInitial());
    } on BackendException catch (e) {
      emit(UserAuthFailed(
          _utilities.getResponseError(e.message) ?? e.message.toString()));
    } catch (e) {
      emit(UserAuthFailed(e.toString()));
    }
  }

  Future<void> _loadUser(Emitter<AuthState> emit, String onException) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw BaseAppException(message: onException);
    }
    emit(UserAuthLoaded(FirebaseAuth.instance.currentUser!));
  }

  Future<void> _onGoogleSignIn(
      UserSignInWithGoogle event, Emitter<AuthState> emit) async {
    try {
      emit(const UserAuthLoading());
      await _userAuthRepository.googleSignIn();
      await _loadUser(emit, 'Google sign-in failed');
      auth = Auth.google;
    } catch (e) {
      emit(UserAuthFailed(e.toString()));
    }
  }

  Future<void> _onSignOut(UserSignOut event, Emitter<AuthState> emit) async {
    try {
      emit(const UserAuthLoading());
      await _userAuthRepository.logout(event.auth);
      emit(const UserAuthSignedUp());
    } catch (e) {
      emit(UserAuthFailed(e.toString()));
    }
  }

  Future<void> _onFacebookSignIn(
      UserSignInWithFacebook event, Emitter<AuthState> emit) async {
    try {
      emit(const UserAuthLoading());
      await _userAuthRepository.facebookSignIn();
      await _loadUser(emit, 'Google sign-in failed');
      auth = Auth.facebook;
    } catch (e) {
      emit(UserAuthFailed(e.toString()));
    }
  }

  Future<void> _onAppleSignIn(
      UserSignInWithApple event, Emitter<AuthState> emit) async {
    try {
      emit(const UserAuthLoading());
      await _userAuthRepository.appleSignIn();
      await _loadUser(emit, 'Apple sign-in failed');
      auth = Auth.apple;
    } catch (e) {
      emit(UserAuthFailed(e.toString()));
    }
  }
}
