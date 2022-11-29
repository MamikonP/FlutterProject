part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => <Object>[];
}

class UserInitial extends ProfileState {
  const UserInitial();
}

class PickImageLoading extends ProfileState {
  const PickImageLoading();
}

class PickImageCancelled extends ProfileState {
  const PickImageCancelled();
}

class PickImageLoaded extends ProfileState {
  const PickImageLoaded(this.imageFile);

  final File imageFile;
}

class EmailSending extends ProfileState {
  const EmailSending();
}

class EmailSent extends ProfileState {
  const EmailSent();
}

class EmailSendingCancelled extends ProfileState {
  const EmailSendingCancelled();
}
