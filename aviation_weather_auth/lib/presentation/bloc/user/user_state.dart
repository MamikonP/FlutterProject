part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => <Object>[];
}

class UserInitial extends UserState {
  const UserInitial();
}

class PickImageLoading extends UserState {
  const PickImageLoading();
}

class PickImageCancelled extends UserState {
  const PickImageCancelled();
}

class PickImageLoaded extends UserState {
  const PickImageLoaded(this.imageFile);
  
  final File imageFile;
}

class EmailSending extends UserState {
  const EmailSending();
}

class EmailSent extends UserState {
  const EmailSent();
}

class EmailSendingCancelled extends UserState {
  const EmailSendingCancelled();
}
