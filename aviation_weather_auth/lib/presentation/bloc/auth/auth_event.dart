part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class UserSignInWithGoogle extends AuthEvent {
  const UserSignInWithGoogle();
}

class UserSignOut extends AuthEvent {
  const UserSignOut(this.auth);

  final Auth? auth;
}

class UserSignInWithFacebook extends AuthEvent {
  const UserSignInWithFacebook();
}

class UserSignInWithApple extends AuthEvent {
  const UserSignInWithApple();
}

class UserSignUpWithEmail extends AuthEvent {
  const UserSignUpWithEmail({
    required this.email,
    required this.name,
    required this.password,
  });

  final String email;
  final String name;
  final String password;
}

class UserSignInWithEmail extends AuthEvent {
  const UserSignInWithEmail({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
