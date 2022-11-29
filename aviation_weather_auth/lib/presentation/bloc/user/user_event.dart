part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadImageFromGallery extends UserEvent {
  const LoadImageFromGallery();
}

class LoadImageFromCamera extends UserEvent {
  const LoadImageFromCamera();
}

class SendEmail extends UserEvent {
  const SendEmail();
}
