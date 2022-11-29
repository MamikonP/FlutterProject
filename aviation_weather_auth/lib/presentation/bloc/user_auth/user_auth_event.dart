part of 'user_auth_bloc.dart';

abstract class UserAuthEvent extends Equatable {
  const UserAuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class UserSignInWithGoogle extends UserAuthEvent {
  const UserSignInWithGoogle();
}

class UserSignOut extends UserAuthEvent {
  const UserSignOut(this.auth);

  final Auth? auth;
}

class UserSignInWithFacebook extends UserAuthEvent {
  const UserSignInWithFacebook();
}

class UserSignInWithApple extends UserAuthEvent {
  const UserSignInWithApple();
}

class UserSignUpWithEmail extends UserAuthEvent {
  const UserSignUpWithEmail({
    required this.email,
    required this.name,
    required this.password,
  });

  final String email;
  final String name;
  final String password;
}

class UserSignInWithEmail extends UserAuthEvent {
  const UserSignInWithEmail({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
