part of 'user_auth_bloc.dart';

abstract class UserAuthState extends Equatable {
  const UserAuthState();

  @override
  List<Object> get props => <Object>[];
}

class UserAuthInitial extends UserAuthState {
  const UserAuthInitial();
}

class UserAuthLoading extends UserAuthState {
  const UserAuthLoading();
}

class UserAuthLoaded extends UserAuthState {
  const UserAuthLoaded(this.user);

  final User user;
}

class UserAuthSignedUp extends UserAuthState {
  const UserAuthSignedUp();
}

class UserAuthFailed extends UserAuthState {
  const UserAuthFailed(this.message);

  final String message;
}
