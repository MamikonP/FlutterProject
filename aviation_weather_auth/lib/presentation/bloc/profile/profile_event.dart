part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadImageFromGallery extends ProfileEvent {
  const LoadImageFromGallery();
}

class LoadImageFromCamera extends ProfileEvent {
  const LoadImageFromCamera();
}

class SendEmail extends ProfileEvent {
  const SendEmail();
}
