import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/email_service.dart';
import '../../../services/gallery_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._galleryService) : super(const UserInitial()) {
    on<LoadImageFromGallery>(_onLoadImageFromGallery);
    on<LoadImageFromCamera>(_onLoadImageFromCamera);
    on<SendEmail>(_onSendEmail);
  }

  final GalleryService _galleryService;

  FutureOr<void> _onLoadImageFromGallery(
      LoadImageFromGallery event, Emitter<ProfileState> emit) async {
    emit(const PickImageLoading());
    try {
      final File image = await _galleryService.loadImage(ImageSource.gallery);
      emit(PickImageLoaded(image));
    } on NullThrownError {
      emit(const PickImageCancelled());
    }
  }

  FutureOr<void> _onLoadImageFromCamera(
      LoadImageFromCamera event, Emitter<ProfileState> emit) async {
    emit(const PickImageLoading());
    try {
      final File image = await _galleryService.loadImage(ImageSource.camera);
      emit(PickImageLoaded(image));
    } on NullThrownError {
      emit(const PickImageCancelled());
    }
  }

  FutureOr<void> _onSendEmail(
      SendEmail event, Emitter<ProfileState> emit) async {
    emit(const EmailSending());
    if (await EmailService().sendEmail()) {
      emit(const EmailSent());
    } else {
      emit(const EmailSendingCancelled());
    }
  }
}
