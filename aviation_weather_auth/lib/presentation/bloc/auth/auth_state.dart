part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => <Object>[];
}

class UserAuthInitial extends AuthState {
  const UserAuthInitial();
}

class UserAuthLoading extends AuthState {
  const UserAuthLoading();
}

class UserAuthLoaded extends AuthState {
  const UserAuthLoaded(this.user);

  final User user;
}

class UserAuthSignedUp extends AuthState {
  const UserAuthSignedUp();
}

class UserAuthFailed extends AuthState {
  const UserAuthFailed(this.message);

  final String message;
}
